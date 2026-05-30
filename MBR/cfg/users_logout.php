<?php
require_once __DIR__ . '/cors.php';
require_once __DIR__ . '/../src/Csrf.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit;
}

Csrf::validateRequest();

if (session_status() === PHP_SESSION_NONE) session_start();

unset($_SESSION['user_id'], $_SESSION['user_email'], $_SESSION['user_name']);
session_regenerate_id(true);

echo json_encode(['ok' => true]);
