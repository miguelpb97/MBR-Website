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
$paypalOrderId = $input['orderID'] ?? null;

if (!$paypalOrderId) {
    http_response_code(400);
    echo json_encode(['error' => 'Falta orderID']);
    exit;
}

$pdo = getDB();

// El pedido debe existir ya (lo creamos en paypal-create-order.php)
$stmt = $pdo->prepare("SELECT id_order, status, total FROM customer_order WHERE paypal_order_id = ? LIMIT 1");
$stmt->execute([$paypalOrderId]);
$order = $stmt->fetch();

if (!$order) {
    http_response_code(404);
    echo json_encode(['error' => 'Pedido no encontrado']);
    exit;
}

if ($order['status'] === 'paid') {
    // Ya se había capturado antes (doble clic, retry del navegador...)
    echo json_encode(['status' => 'paid', 'id_order' => $order['id_order']]);
    exit;
}

$result = paypalRequest('POST', "/v2/checkout/orders/{$paypalOrderId}/capture");

$captureStatus = $result['body']['status'] ?? null;

if ($result['httpCode'] !== 201 || $captureStatus !== 'COMPLETED') {
    $stmt = $pdo->prepare("UPDATE customer_order SET status = 'failed' WHERE id_order = ?");
    $stmt->execute([$order['id_order']]);

    http_response_code(502);
    echo json_encode(['error' => 'El pago no se pudo completar']);
    exit;
}

// Datos del pagador que nos da PayPal, para guardarlos en el pedido
$payer = $result['body']['payer'] ?? [];
$customerName = trim(($payer['name']['given_name'] ?? '') . ' ' . ($payer['name']['surname'] ?? ''));
$customerEmail = $payer['email_address'] ?? null;

$stmt = $pdo->prepare("
    UPDATE customer_order
    SET status = 'paid', customer_name = ?, customer_email = ?, paid_at = NOW()
    WHERE id_order = ?
");
$stmt->execute([$customerName ?: null, $customerEmail, $order['id_order']]);

// --- Aquí es donde "hace lo que tenga que hacer" tras el pago ---
// Por ejemplo: enviar email de confirmación al cliente y aviso interno.
// Dejo el hueco listo; dime qué necesitas exactamente (plantilla de email,
// aviso por WhatsApp, etc.) y lo añado.
//
// enviarEmailConfirmacionPedido($order['id_order'], $customerEmail);
// notificarNuevoPedido($order['id_order']);

echo json_encode([
    'status' => 'paid',
    'id_order' => $order['id_order'],
    'total' => (float) $order['total'],
]);
