<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/config.php';
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
$qty  = isset($data['quantity']) ? max(1, min(10, (int) $data['quantity'])) : 1;

if ($id <= 0) {
    http_response_code(400);
    echo json_encode(['error' => 'ID de servicio inválido']);
    exit;
}

try {
    $pdo  = getDB();
    $stmt = $pdo->prepare(
        "SELECT id_service, name, price FROM service WHERE id_service = ? AND stock = 1"
    );
    $stmt->execute([$id]);
    $service = $stmt->fetch();

    if (!$service) {
        http_response_code(404);
        echo json_encode(['error' => 'Servicio no encontrado o sin disponibilidad']);
        exit;
    }

    if ($service['price'] === null) {
        http_response_code(400);
        echo json_encode(['error' => 'Este servicio requiere consulta previa y no puede comprarse online']);
        exit;
    }

    CartManager::add($id, $service['name'], (float) $service['price'], $qty);

    echo json_encode([
        'ok'    => true,
        'count' => CartManager::count(),
        'total' => CartManager::total(),
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error del servidor']);
    error_log('cart_add PDO error: ' . $e->getMessage());
}
