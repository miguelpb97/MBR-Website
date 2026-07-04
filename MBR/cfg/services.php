<?php
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/data.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

$id_variant = isset($_GET['id_variant']) ? (int) $_GET['id_variant'] : 0;

if (!$id_variant) {
    http_response_code(400);
    echo json_encode(['error' => 'id_variant requerido']);
    exit;
}

try {
    $servicios = cargarServicios($id_variant);
    echo json_encode(array_values($servicios), JSON_UNESCAPED_UNICODE);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al obtener los servicios']);
}