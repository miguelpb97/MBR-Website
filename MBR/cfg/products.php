<?php
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/data.php';
require_once __DIR__ . '/../public_html/includes/translate.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

$lang = isset($_GET['lang']) && in_array($_GET['lang'], get_available_languages(), true)
    ? $_GET['lang']
    : 'es';

try {
    $productos = cargarProductos($lang);
    echo json_encode($productos, JSON_UNESCAPED_UNICODE);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al obtener los productos']);
}
