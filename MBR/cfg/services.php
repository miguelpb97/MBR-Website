<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/config.php';

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
    $pdo  = getDB();
    $stmt = $pdo->prepare("
        SELECT
            s.id_service AS id,
            s.name AS titulo,
            s.description AS descripcion,
            s.price AS precio,
            s.image_url AS imagen
        FROM variant_has_service vhs
        JOIN service s ON s.id_service = vhs.service_id
        WHERE vhs.variant_id = ?
          AND s.stock = 1
        ORDER BY s.name ASC
    ");
    $stmt->execute([$id_variant]);
    $rows = $stmt->fetchAll();

    // Castea precio a float o null
    foreach ($rows as &$row) {
        $row['precio'] = $row['precio'] !== null ? (float) $row['precio'] : null;
    }

    echo json_encode(array_values($rows), JSON_UNESCAPED_UNICODE);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al obtener los servicios']);
}
