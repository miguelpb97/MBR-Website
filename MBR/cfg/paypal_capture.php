<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/../src/CartManager.php';
require_once __DIR__ . '/../src/PayPalClient.php';
require_once __DIR__ . '/../src/OrderRepository.php';
require_once __DIR__ . '/../src/Csrf.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

Csrf::validateRequest();

$data          = json_decode(file_get_contents('php://input'), true);
$paypalOrderId = trim($data['paypal_order_id'] ?? '');
$name          = trim(strip_tags($data['name'] ?? ''));
$email         = trim($data['email'] ?? '');

// ── Input validation ──────────────────────────────────────────
if (!$paypalOrderId) {
    http_response_code(400);
    echo json_encode(['error' => 'ID de orden PayPal requerido']);
    exit;
}
if (strlen($name) < 2 || strlen($name) > 80) {
    http_response_code(400);
    echo json_encode(['error' => 'Nombre inválido (2–80 caracteres)']);
    exit;
}
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['error' => 'Email inválido']);
    exit;
}

$items = CartManager::get();
if (empty($items)) {
    http_response_code(400);
    echo json_encode(['error' => 'El carrito está vacío']);
    exit;
}

$expectedTotal = CartManager::total();

try {
    $repo = new OrderRepository();

    // ── Idempotency: reject duplicate processing ───────────────
    if ($repo->isAlreadyProcessed($paypalOrderId)) {
        http_response_code(409);
        echo json_encode(['error' => 'Este pedido ya fue procesado']);
        exit;
    }

    // ── Server-side capture (never trust the client) ───────────
    $paypal  = new PayPalClient();
    $capture = $paypal->captureOrder($paypalOrderId);

    $captureStatus = $capture['status'] ?? '';
    if ($captureStatus !== 'COMPLETED') {
        http_response_code(402);
        echo json_encode(['error' => 'El pago no se completó (estado: ' . $captureStatus . ')']);
        exit;
    }

    // ── Amount integrity check ─────────────────────────────────
    $capturedAmount = (float) ($capture['purchase_units'][0]['payments']['captures'][0]['amount']['value'] ?? 0);
    if (abs($capturedAmount - $expectedTotal) > 0.02) {
        error_log(sprintf(
            'PayPal amount mismatch — expected %.2f, got %.2f — order %s — IP %s',
            $expectedTotal, $capturedAmount, $paypalOrderId,
            $_SERVER['HTTP_X_FORWARDED_FOR'] ?? $_SERVER['REMOTE_ADDR'] ?? 'unknown'
        ));
        http_response_code(400);
        echo json_encode(['error' => 'Discrepancia en el importe. Contacta con nosotros.']);
        exit;
    }

    $captureId = $capture['purchase_units'][0]['payments']['captures'][0]['id'] ?? '';

    // ── Persist order ──────────────────────────────────────────
    if (session_status() === PHP_SESSION_NONE) session_start();
    $userId = $_SESSION['user_id'] ?? null;
    $ip     = $_SERVER['HTTP_X_FORWARDED_FOR'] ?? $_SERVER['REMOTE_ADDR'] ?? null;

    $orderId = $repo->createOrder(
        $name, $email, $capturedAmount,
        $paypalOrderId, $captureId,
        $items, $userId, $ip
    );

    CartManager::clear();

    echo json_encode(['ok' => true, 'order_id' => $orderId]);

} catch (RuntimeException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al procesar el pago. Contacta con nosotros.']);
    error_log('paypal_capture RuntimeException: ' . $e->getMessage());
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al guardar el pedido. Contacta con nosotros.']);
    error_log('paypal_capture PDOException: ' . $e->getMessage());
}
