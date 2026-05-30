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

$data = json_decode(file_get_contents('php://input'), true);
$id   = isset($data['id']) ? (int) $data['id'] : 0;

if ($id <= 0) {
    http_response_code(400);
    echo json_encode(['error' => 'ID inválido']);
    exit;
}

CartManager::remove($id);

echo json_encode([
    'ok'    => true,
    'count' => CartManager::count(),
    'total' => CartManager::total(),
]);
