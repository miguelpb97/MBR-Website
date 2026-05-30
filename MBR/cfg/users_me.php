<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/../src/Csrf.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

Csrf::start();

echo json_encode([
    'logged_in'  => !empty($_SESSION['user_id']),
    'name'       => $_SESSION['user_name']  ?? null,
    'email'      => $_SESSION['user_email'] ?? null,
    'csrf_token' => Csrf::getToken(),
], JSON_UNESCAPED_UNICODE);
