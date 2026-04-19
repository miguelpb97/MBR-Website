<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

try {
    $pdo  = getDB();
    $rows = $pdo->query("
        SELECT id_vehicle, name AS nombre, image_url AS imagen
        FROM vehicle
        ORDER BY name ASC
    ")->fetchAll();

    echo json_encode(array_values($rows), JSON_UNESCAPED_UNICODE);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al obtener los modelos']);
}
