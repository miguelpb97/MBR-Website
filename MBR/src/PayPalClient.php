<?php
require_once __DIR__ . '/../cfg/config.php';

class PayPalClient
{
    private string $clientId;
    private string $clientSecret;
    private string $apiBase;

    public function __construct()
    {
        $this->clientId     = PAYPAL_CLIENT_ID;
        $this->clientSecret = PAYPAL_CLIENT_SECRET;
        $this->apiBase      = PAYPAL_API_BASE;
    }

    // ── OAuth2 Token ──────────────────────────────────────────────
    private function getAccessToken(): string
    {
        $ch = curl_init($this->apiBase . '/v1/oauth2/token');
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POST           => true,
            CURLOPT_USERPWD        => $this->clientId . ':' . $this->clientSecret,
            CURLOPT_POSTFIELDS     => 'grant_type=client_credentials',
            CURLOPT_HTTPHEADER     => ['Content-Type: application/x-www-form-urlencoded'],
            CURLOPT_TIMEOUT        => 15,
        ]);
        $response = curl_exec($ch);
        $errno    = curl_errno($ch);
        curl_close($ch);

        if ($errno) throw new RuntimeException('cURL error al obtener token PayPal: ' . $errno);

        $data = json_decode($response, true);
        if (empty($data['access_token'])) {
            throw new RuntimeException('No se pudo obtener el token de PayPal: ' . $response);
        }
        return $data['access_token'];
    }

    // ── Create Order ──────────────────────────────────────────────
    public function createOrder(array $items, float $total, string $currency = 'EUR'): array
    {
        $token = $this->getAccessToken();

        $purchaseItems = array_map(fn($item) => [
            'name'        => mb_substr($item['name'], 0, 127),
            'unit_amount' => [
                'currency_code' => $currency,
                'value'         => number_format((float) $item['price'], 2, '.', ''),
            ],
            'quantity' => (string) max(1, (int) $item['quantity']),
        ], $items);

        $body = json_encode([
            'intent'         => 'CAPTURE',
            'purchase_units' => [[
                'description' => 'Servicios MBR Almería',
                'amount'      => [
                    'currency_code' => $currency,
                    'value'         => number_format($total, 2, '.', ''),
                    'breakdown'     => [
                        'item_total' => [
                            'currency_code' => $currency,
                            'value'         => number_format($total, 2, '.', ''),
                        ],
                    ],
                ],
                'items' => $purchaseItems,
            ]],
        ]);

        $ch = curl_init($this->apiBase . '/v2/checkout/orders');
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POST           => true,
            CURLOPT_POSTFIELDS     => $body,
            CURLOPT_TIMEOUT        => 15,
            CURLOPT_HTTPHEADER     => [
                'Content-Type: application/json',
                'Authorization: Bearer ' . $token,
                'PayPal-Request-Id: mbr_' . bin2hex(random_bytes(8)),
            ],
        ]);
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $errno    = curl_errno($ch);
        curl_close($ch);

        if ($errno) throw new RuntimeException('cURL error al crear orden PayPal: ' . $errno);

        $data = json_decode($response, true);
        if ($httpCode !== 201 || empty($data['id'])) {
            throw new RuntimeException('Error al crear la orden en PayPal (' . $httpCode . '): ' . $response);
        }
        return $data;
    }

    // ── Capture Order (server-side verification) ──────────────────
    public function captureOrder(string $orderId): array
    {
        $token = $this->getAccessToken();

        $ch = curl_init($this->apiBase . '/v2/checkout/orders/' . $orderId . '/capture');
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POST           => true,
            CURLOPT_POSTFIELDS     => '{}',
            CURLOPT_TIMEOUT        => 20,
            CURLOPT_HTTPHEADER     => [
                'Content-Type: application/json',
                'Authorization: Bearer ' . $token,
            ],
        ]);
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $errno    = curl_errno($ch);
        curl_close($ch);

        if ($errno) throw new RuntimeException('cURL error al capturar PayPal: ' . $errno);

        $data = json_decode($response, true);
        if ($httpCode !== 201 && $httpCode !== 200) {
            throw new RuntimeException('Error al capturar el pago PayPal (' . $httpCode . '): ' . $response);
        }
        return $data;
    }
}
