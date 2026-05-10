<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

$body = json_decode(file_get_contents('php://input'), true);

if (!$body) {
    http_response_code(400);
    echo json_encode(['error' => 'Datos inválidos']);
    exit;
}

$nombre  = trim($body['name']    ?? '');
$email   = trim($body['email']   ?? '');
$mensaje = trim($body['message'] ?? '');

if (!$nombre || !$email || !$mensaje) {
    http_response_code(422);
    echo json_encode(['error' => 'Nombre, email y mensaje son obligatorios']);
    exit;
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(422);
    echo json_encode(['error' => 'Email no válido']);
    exit;
}

// Honeypot anti-spam
if (!empty($body['empresa'])) {
    http_response_code(200);
    echo json_encode(['success' => true]);
    exit;
}

// Validación Turnstile
$turnstileToken  = $body['turnstileToken'] ?? '';
$turnstileSecret = CF_SECRET_TEST;

if ($turnstileToken) {
    $verify = file_get_contents('https://challenges.cloudflare.com/turnstile/v0/siteverify', false,
        stream_context_create([
            'http' => [
                'method'  => 'POST',
                'header'  => 'Content-Type: application/x-www-form-urlencoded',
                'content' => http_build_query([
                    'secret'   => $turnstileSecret,
                    'response' => $turnstileToken,
                ]),
            ],
        ])
    );
    $result = json_decode($verify, true);
    if (!($result['success'] ?? false)) {
        http_response_code(403);
        echo json_encode(['error' => 'Verificación de seguridad fallida']);
        exit;
    }
}

$telefono = trim($body['phone']  ?? '') ?: null;
$modelo   = trim($body['model']  ?? '') ?: null;

try {
    $pdo  = getDB();
    $stmt = $pdo->prepare("
        INSERT INTO consultas (nombre, email, telefono, modelo, mensaje)
        VALUES (:nombre, :email, :telefono, :modelo, :mensaje)
    ");
    $stmt->execute([
        ':nombre'   => $nombre,
        ':email'    => $email,
        ':telefono' => $telefono,
        ':modelo'   => $modelo,
        ':mensaje'  => $mensaje,
    ]);

    http_response_code(201);
    echo json_encode(['success' => true, 'message' => 'Consulta recibida correctamente']);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al guardar la consulta']);
}