<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/config.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

// Only the CLIENT ID is public — the Secret stays server-side always
echo json_encode([
    'paypal_client_id' => PAYPAL_CLIENT_ID,
    'paypal_mode'      => PAYPAL_MODE,
]);
