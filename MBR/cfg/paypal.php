<?php

/**
 * Requiere en config.php:
 *   define('PAYPAL_CLIENT_ID', '...');
 *   define('PAYPAL_CLIENT_SECRET', '...');
 *   define('PAYPAL_MODE', 'sandbox'); // 'sandbox' o 'live'
 *
 * PAYPAL_CLIENT_ID es público (va también al frontend con el SDK JS).
 * PAYPAL_CLIENT_SECRET es privado, NUNCA lo mandes al navegador.
 */

function paypalApiBase(): string
{
    return PAYPAL_MODE === 'live'
        ? 'https://api-m.paypal.com'
        : 'https://api-m.sandbox.paypal.com';
}

function paypalGetAccessToken(): ?string
{
    $ch = curl_init(paypalApiBase() . '/v1/oauth2/token');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, 'grant_type=client_credentials');
    curl_setopt($ch, CURLOPT_USERPWD, PAYPAL_CLIENT_ID . ':' . PAYPAL_CLIENT_SECRET);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Accept: application/json',
        'Accept-Language: es_ES',
    ]);

    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($httpCode !== 200) {
        return null;
    }

    $data = json_decode($response, true);
    return $data['access_token'] ?? null;
}

/**
 * Llamada genérica autenticada a la API de PayPal.
 */
function paypalRequest(string $method, string $path, ?array $body = null): array
{
    $token = paypalGetAccessToken();
    if (!$token) {
        return ['httpCode' => 500, 'body' => ['error' => 'No se pudo autenticar con PayPal']];
    }

    $ch = curl_init(paypalApiBase() . $path);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json',
        'Authorization: Bearer ' . $token,
    ]);

    if ($body !== null) {
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($body));
    }

    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    return ['httpCode' => $httpCode, 'body' => json_decode($response, true)];
}
