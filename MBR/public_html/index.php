<?php

$scriptDir = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/');
$request   = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

$path = $scriptDir ? substr($request, strlen($scriptDir)) : $request;
$path = '/' . ltrim($path, '/');
$path = preg_replace('#^/index\.php#', '', $path);
$path = rtrim($path, '/') ?: '/';

$views = [
    '/'                 => 'index-view.html',
    '/index'            => 'index-view.html',
    '/servicios'        => 'servicios-view.html',
    '/contacto'         => 'contacto-view.html',
    '/privacidad'       => 'privacidad-view.html',
    '/terminos'         => 'terminos-view.html',
];

if (isset($views[$path])) {
    require_once __DIR__ . '/../views/' . $views[$path];
} else {
    http_response_code(404);
    echo '<h1>404 - Ruta no encontrada: ' . htmlspecialchars($path) . '</h1>';
}
