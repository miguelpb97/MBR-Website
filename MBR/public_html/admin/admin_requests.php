<?php
require_once __DIR__ . '/../../src/Auth.php';
require_once __DIR__ . '/../../src/ConsultaRepository.php';

Auth::requireLogin();

$repo = new ConsultaRepository();

// Borrado
if (isset($_GET['borrar'])) {
    $id = (int) $_GET['borrar'];
    if ($id > 0) {
        $repo->deleteById($id);
    }
    header('Location: admin_requests.php');
    exit;
}

// Marcar como leído
if (isset($_GET['leido'])) {
    $id = (int) $_GET['leido'];
    if ($id > 0) {
        $repo->toggleRead($id);
    }
    header('Location: admin_requests.php');
    exit;
}

// Descarga CSV
if (isset($_GET['descargar']) && $_GET['descargar'] === 'csv') {
    $busqueda = isset($_GET['buscar']) ? trim($_GET['buscar']) : '';
    $result = $repo->obtenerParaCsv($busqueda);

    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename=consultas.csv');

    $out = fopen('php://output', 'w');
    fputcsv($out, ['ID', 'Nombre', 'Email', 'Teléfono', 'Mensaje', 'Modelo', 'Variante', 'Servicio', 'Fecha']);
    while ($r = $result->fetch_assoc()) {
        fputcsv($out, $r);
    }
    fclose($out);
    exit;
}

// Búsqueda + paginación
$busqueda = isset($_GET['buscar']) ? trim($_GET['buscar']) : '';
$pagina_actual = isset($_GET['p']) ? max(1, (int) $_GET['p']) : 1;
$por_pagina = RESULTADOS_POR_PAGINA;

$data = $repo->buscarConsultas($busqueda, $pagina_actual, $por_pagina);
$consultas = $data['consultas'];
$total = $data['total'];
$paginas = (int) ceil($total / $por_pagina);

// Vista
require_once __DIR__ . '/../../views/admin_requests-view.php';
