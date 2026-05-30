<?php
require_once __DIR__ . '/../../src/Auth.php';

Auth::requireLogin();

// Si la request viene con ?page=, responde JSON
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['page'])) {
    require_once __DIR__ . '/../../src/OrderRepository.php';
    header('Content-Type: application/json');
    $repo    = new OrderRepository();
    $page    = max(1, (int) ($_GET['page'] ?? 1));
    $perPage = 25;
    $orders  = $repo->getAll($perPage, ($page - 1) * $perPage);
    $total   = $repo->countAll();
    echo json_encode([
        'orders' => $orders,
        'total'  => $total,
        'pages'  => (int) ceil($total / $perPage),
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

// Renderiza la vista
require_once __DIR__ . '/../../views/admin/admin_orders-view.php';
