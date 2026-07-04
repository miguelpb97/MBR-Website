<?php
require_once __DIR__ . '/../cfg/data.php';

header('Content-Type: application/xml; charset=utf-8');

$host = $_SERVER['HTTP_HOST'];
$base = 'https://' . $host;

// --- Páginas estáticas ---
$estaticas = [
    ['loc' => '/',                          'priority' => '1.0'],
    ['loc' => '/servicios',                 'priority' => '0.9'],
    ['loc' => '/contacto',                  'priority' => '0.7'],
    ['loc' => '/terminos-y-condiciones',    'priority' => '0.3'],
    ['loc' => '/politica-de-privacidad',    'priority' => '0.3'],
];

// --- Combinaciones variante + servicio (una URL por cada fila de variant_has_service) ---
try {
    $pdo = getDB();
    $stmt = $pdo->query("
        SELECT
            s.name AS titulo,
            v.name AS variante
        FROM variant_has_service vhs
        JOIN service s ON s.id_service = vhs.service_id
        JOIN variant v ON v.id_variant = vhs.variant_id
        WHERE s.stock = 1
        ORDER BY v.name ASC, s.name ASC
    ");
    $filas = $stmt->fetchAll();
} catch (PDOException $e) {
    $filas = [];
}

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n";

foreach ($estaticas as $pagina) {
    echo "  <url>\n";
    echo "    <loc>" . htmlspecialchars($base . $pagina['loc']) . "</loc>\n";
    echo "    <priority>" . $pagina['priority'] . "</priority>\n";
    echo "  </url>\n";
}

foreach ($filas as $fila) {
    $slug_variante = slugify($fila['variante']);
    $slug_servicio = slugify($fila['titulo']);
    $loc = $base . '/servicio/' . $slug_variante . '/' . $slug_servicio;

    echo "  <url>\n";
    echo "    <loc>" . htmlspecialchars($loc) . "</loc>\n";
    echo "    <priority>0.8</priority>\n";
    echo "  </url>\n";
}

echo '</urlset>';
