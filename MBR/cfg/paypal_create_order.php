<?php
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/data.php';
require_once __DIR__ . '/paypal.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);
$items = $input['items'] ?? []; // [{ id: 12, qty: 2 }, ...]

if (!is_array($items) || empty($items)) {
    http_response_code(400);
    echo json_encode(['error' => 'Carrito vacío']);
    exit;
}

$pdo = getDB();

// Recalculamos cada línea contra la BBDD: id, nombre y precio vienen de `service`,
// nunca del navegador. Si el servicio no existe, no tiene precio o no está en
// stock, esa línea se descarta.
$lineItems = [];
$total = 0.0;

foreach ($items as $item) {
    $idService = (int) ($item['id'] ?? 0);
    $qty = max(1, (int) ($item['qty'] ?? 1));

    $stmt = $pdo->prepare("SELECT id_service, name, price, stock FROM service WHERE id_service = ? LIMIT 1");
    $stmt->execute([$idService]);
    $row = $stmt->fetch();

    if (!$row || $row['price'] === null || (int) $row['stock'] !== 1) {
        continue;
    }

    $unitPrice = (float) $row['price'];
    $lineItems[] = [
        'id_service' => $row['id_service'],
        'nombre'     => $row['name'],
        'unit_price' => $unitPrice,
        'quantity'   => $qty,
    ];
    $total += $unitPrice * $qty;
}

if (empty($lineItems)) {
    http_response_code(400);
    echo json_encode(['error' => 'Ninguno de los productos del carrito está disponible']);
    exit;
}

$total = round($total, 2);

// 1. Creamos el pedido en PayPal
$paypalItems = array_map(fn($li) => [
    'name'        => mb_substr($li['nombre'], 0, 127),
    'quantity'    => (string) $li['quantity'],
    'unit_amount' => ['currency_code' => 'EUR', 'value' => number_format($li['unit_price'], 2, '.', '')],
], $lineItems);

$paypalOrderPayload = [
    'intent' => 'CAPTURE',
    'purchase_units' => [[
        'amount' => [
            'currency_code' => 'EUR',
            'value' => number_format($total, 2, '.', ''),
            'breakdown' => [
                'item_total' => ['currency_code' => 'EUR', 'value' => number_format($total, 2, '.', '')],
            ],
        ],
        'items' => $paypalItems,
    ]],
];

$result = paypalRequest('POST', '/v2/checkout/orders', $paypalOrderPayload);

if ($result['httpCode'] !== 201 || empty($result['body']['id'])) {
    http_response_code(502);
    echo json_encode(['error' => 'Error al crear el pedido en PayPal']);
    exit;
}

$paypalOrderId = $result['body']['id'];

// 2. Guardamos el pedido en nuestra BBDD como "pending" (se confirma al capturar el pago)
$pdo->beginTransaction();

$stmt = $pdo->prepare("
    INSERT INTO customer_order (paypal_order_id, status, total)
    VALUES (?, 'pending', ?)
");
$stmt->execute([$paypalOrderId, $total]);
$idOrder = $pdo->lastInsertId();

$stmtItem = $pdo->prepare("
    INSERT INTO order_item (id_order, id_service, nombre_snapshot, quantity, unit_price)
    VALUES (?, ?, ?, ?, ?)
");
foreach ($lineItems as $li) {
    $stmtItem->execute([$idOrder, $li['id_service'], $li['nombre'], $li['quantity'], $li['unit_price']]);
}

$pdo->commit();

echo json_encode(['id' => $paypalOrderId]);
