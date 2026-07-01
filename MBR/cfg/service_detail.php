<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

$id_service = isset($_GET['id']) ? (int) $_GET['id'] : 0;

if (!$id_service) {
    http_response_code(400);
    echo json_encode(['error' => 'id requerido']);
    exit;
}

try {
    $pdo  = getDB();
    $stmt = $pdo->prepare("
        SELECT
            s.id_service AS id,
            s.name       AS titulo,
            s.description AS descripcion,
            s.price      AS precio,
            s.image_url  AS imagen,
            v.name       AS variante
        FROM variant_has_service vhs
        JOIN service s ON s.id_service = vhs.service_id
        JOIN variant v ON v.id_variant = vhs.variant_id
        WHERE vhs.variant_id = ?
        AND s.stock = 1
        ORDER BY s.name ASC
    ");
    $stmt->execute([$id_service]);
    $row = $stmt->fetch();

    if (!$row) {
        http_response_code(404);
        echo json_encode(['error' => 'Servicio no encontrado']);
        exit;
    }

    $row['precio'] = $row['precio'] !== null ? (float) $row['precio'] : null;

    echo json_encode($row, JSON_UNESCAPED_UNICODE);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al obtener el servicio']);
}
