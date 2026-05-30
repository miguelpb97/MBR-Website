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
$name     = trim(strip_tags($data['name'] ?? ''));
$email    = trim($data['email'] ?? '');
$password = $data['password'] ?? '';

// ── Validation ────────────────────────────────────────────────
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
if (strlen($password) < 8 || strlen($password) > 128) {
    http_response_code(400);
    echo json_encode(['error' => 'La contraseña debe tener entre 8 y 128 caracteres']);
    exit;
}

// ── Rate limiting: máx 3 registros por 5 min ──────────────────
if (session_status() === PHP_SESSION_NONE) session_start();
$now = time();
if (!isset($_SESSION['reg_rl']) || ($now - $_SESSION['reg_rl']['w']) > 300) {
    $_SESSION['reg_rl'] = ['c' => 0, 'w' => $now];
}
$_SESSION['reg_rl']['c']++;
if ($_SESSION['reg_rl']['c'] > 3) {
    http_response_code(429);
    echo json_encode(['error' => 'Demasiados intentos. Espera 5 minutos.']);
    exit;
}

try {
    $repo = new UserRepository();

    if ($repo->emailExists($email)) {
        http_response_code(409);
        echo json_encode(['error' => 'Este email ya está registrado']);
        exit;
    }

    $userId = $repo->register($name, $email, $password);

    session_regenerate_id(true);
    $_SESSION['user_id']    = $userId;
    $_SESSION['user_email'] = $email;
    $_SESSION['user_name']  = $name;
    $_SESSION['reg_rl']     = ['c' => 0, 'w' => time()];

    echo json_encode(['ok' => true, 'name' => $name]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al registrar el usuario']);
    error_log('register PDO: ' . $e->getMessage());
}
