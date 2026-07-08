<?php
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
$turnstileSecret = CF_SECRET;

if ($turnstileToken) {
    $verify = file_get_contents(CF_URL, false,
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

// Función de notificaciones ntfy
function enviarNotificacionNTFY(string $nombre): void
{
    $topic = TOPIC_NAME;

    $payload = json_encode([
        'topic'    => $topic,
        'title'    => "Nueva consulta de $nombre",
        'message'  => "Consulta realizada. por favor revisar la base de datos para más detalles.",
        'priority' => 3,         // 4 = alta, 3 = normal
        'tags'     => ['envelope'],
    ]);

    $ch = curl_init('https://ntfy.sh');
    curl_setopt_array($ch, [
        CURLOPT_POST           => true,
        CURLOPT_POSTFIELDS     => $payload,
        CURLOPT_HTTPHEADER     => ['Content-Type: application/json'],
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => 5,   // no bloquea la respuesta al cliente si ntfy tarda
    ]);
    curl_exec($ch);
    $ch = null;
}

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

    enviarNotificacionNTFY($nombre);

    http_response_code(201);
    echo json_encode(['success' => true, 'message' => 'Consulta recibida correctamente']);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al guardar la consulta']);
}
