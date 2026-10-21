<?php

$scriptDir = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/');
$request   = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

$path = $scriptDir ? substr($request, strlen($scriptDir)) : $request;
$path = '/' . ltrim($path, '/');
$path = preg_replace('#^/index\.php#', '', $path);
$path = rtrim($path, '/') ?: '/';

$views = [
    '/'                 => 'index-view.php',
    '/index'            => 'index-view.php',
    '/servicios'        => 'servicios-view.php',
    '/faq'              => 'faq-view.php',
    '/contacto'         => 'contacto-view.php',
    '/politica-de-privacidad'       => 'privacidad-view.php',
    '/terminos-y-condiciones'       => 'terminos-view.php',
];

if (isset($views[$path])) {
    require_once __DIR__ . '/../views/' . $views[$path];
} else {
    http_response_code(404);
    echo '<h1>404 - Ruta no encontrada: ' . htmlspecialchars($path) . '</h1>';
}
