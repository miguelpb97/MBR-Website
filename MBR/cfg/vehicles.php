<?php
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/data.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

try {
    $modelos = cargarModelos();
    echo json_encode(array_values($modelos), JSON_UNESCAPED_UNICODE);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al obtener los modelos']);
}
