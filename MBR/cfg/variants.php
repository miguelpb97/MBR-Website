<?php
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/data.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

$id_vehicle = isset($_GET['id_vehicle']) ? (int) $_GET['id_vehicle'] : 0;

if (!$id_vehicle) {
    http_response_code(400);
    echo json_encode(['error' => 'id_vehicle requerido']);
    exit;
}

try {
    $variantes = cargarVariantes($id_vehicle);
    echo json_encode(array_values($variantes), JSON_UNESCAPED_UNICODE);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al obtener las variantes']);
}
