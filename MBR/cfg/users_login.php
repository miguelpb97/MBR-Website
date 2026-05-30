<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/../src/UserRepository.php';
require_once __DIR__ . '/../src/Csrf.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

Csrf::validateRequest();

$data     = json_decode(file_get_contents('php://input'), true);
$email    = trim($data['email'] ?? '');
$password = $data['password'] ?? '';

if (!$email || !$password) {
    http_response_code(400);
    echo json_encode(['error' => 'Datos incompletos']);
    exit;
}

// ── Rate limiting: máx 10 intentos por 5 min ──────────────────
if (session_status() === PHP_SESSION_NONE) session_start();
$now    = time();
$rlKey  = 'login_rl_' . md5(($_SERVER['REMOTE_ADDR'] ?? '') . $email);
if (!isset($_SESSION[$rlKey]) || ($now - $_SESSION[$rlKey]['w']) > 300) {
    $_SESSION[$rlKey] = ['c' => 0, 'w' => $now];
}
$_SESSION[$rlKey]['c']++;
if ($_SESSION[$rlKey]['c'] > 10) {
    http_response_code(429);
    echo json_encode(['error' => 'Demasiados intentos. Espera 5 minutos.']);
    exit;
}

try {
    $repo = new UserRepository();
    $user = $repo->login($email, $password);

    if (!$user) {
        // Mensaje genérico para no revelar si el email existe
        http_response_code(401);
        echo json_encode(['error' => 'Credenciales incorrectas']);
        exit;
    }

    session_regenerate_id(true);
    $_SESSION['user_id']    = $user['id_user'];
    $_SESSION['user_email'] = $user['email'];
    $_SESSION['user_name']  = $user['name'];
    $_SESSION[$rlKey]       = ['c' => 0, 'w' => time()];

    echo json_encode(['ok' => true, 'name' => $user['name']]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error del servidor']);
    error_log('login PDO: ' . $e->getMessage());
}
