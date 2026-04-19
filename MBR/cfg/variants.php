<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/config.php';

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
    $pdo  = getDB();
    $stmt = $pdo->prepare("
        SELECT id_variant, name AS nombre, image_url AS imagen
        FROM variant
        WHERE vehicle_id = ?
        ORDER BY id_variant ASC
    ");
    $stmt->execute([$id_vehicle]);

    echo json_encode(array_values($stmt->fetchAll()), JSON_UNESCAPED_UNICODE);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al obtener las variantes']);
}
