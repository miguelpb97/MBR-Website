<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/../src/CartManager.php';
require_once __DIR__ . '/../src/PayPalClient.php';
require_once __DIR__ . '/../src/Csrf.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

Csrf::validateRequest();

$items = CartManager::get();
if (empty($items)) {
    http_response_code(400);
    echo json_encode(['error' => 'El carrito está vacío']);
    exit;
}

$total = CartManager::total();
if ($total <= 0) {
    http_response_code(400);
    echo json_encode(['error' => 'Total inválido']);
    exit;
}

try {
    $paypal = new PayPalClient();
    $order  = $paypal->createOrder($items, $total);
    echo json_encode(['id' => $order['id']]);

} catch (RuntimeException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al iniciar el pago con PayPal']);
    error_log('paypal_create error: ' . $e->getMessage());
}
