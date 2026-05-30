<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/../src/CartManager.php';
require_once __DIR__ . '/../src/Csrf.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

Csrf::validateRequest();

CartManager::clear();
echo json_encode(['ok' => true]);
