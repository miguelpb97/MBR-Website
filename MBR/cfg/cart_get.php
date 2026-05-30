<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/../src/CartManager.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

echo json_encode([
    'items' => CartManager::get(),
    'total' => CartManager::total(),
    'count' => CartManager::count(),
], JSON_UNESCAPED_UNICODE);
