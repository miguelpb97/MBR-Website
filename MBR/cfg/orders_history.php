<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/../src/OrderRepository.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

if (session_status() === PHP_SESSION_NONE) session_start();

$email = trim($_GET['email'] ?? '');

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['error' => 'Email inválido']);
    exit;
}

// ── Rate limiting: máx 5 consultas por minuto ──────────────────
$now = time();
$key = 'order_lookup_' . md5($email);
if (!isset($_SESSION[$key]) || ($now - $_SESSION[$key]['w']) > 60) {
    $_SESSION[$key] = ['c' => 0, 'w' => $now];
}
$_SESSION[$key]['c']++;
if ($_SESSION[$key]['c'] > 5) {
    http_response_code(429);
    echo json_encode(['error' => 'Demasiadas consultas. Espera un momento.']);
    exit;
}

// ── If logged in, only allow own email ─────────────────────────
if (!empty($_SESSION['user_id']) && !empty($_SESSION['user_email'])) {
    if (strtolower($email) !== strtolower($_SESSION['user_email'])) {
        http_response_code(403);
        echo json_encode(['error' => 'No autorizado']);
        exit;
    }
}

try {
    $repo   = new OrderRepository();
    $orders = $repo->getByEmail($email);
    echo json_encode($orders, JSON_UNESCAPED_UNICODE);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al obtener los pedidos']);
}
