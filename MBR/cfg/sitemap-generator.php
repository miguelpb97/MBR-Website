<?php
ob_start(); // por si algún require cuela un espacio/salto de línea antes del XML

require_once __DIR__ . '/../cfg/data.php';
require_once __DIR__ . '/../public_html/includes/translate.php';

$host = $_SERVER['HTTP_HOST'];
$base = 'https://' . $host;

$langs = get_available_languages(); // ['es', 'en', 'de', 'fr', 'it']
$default_lang = 'es';

// Páginas estáticas
$estaticas = [
    ['loc' => '/',                          'priority' => '1.0'],
    ['loc' => '/servicios',                 'priority' => '0.9'],
    ['loc' => '/store',                     'priority' => '0.8'],
    ['loc' => '/contacto',                  'priority' => '0.7'],
    ['loc' => '/terminos-y-condiciones',    'priority' => '0.3'],
    ['loc' => '/politica-de-privacidad',    'priority' => '0.3'],
];

// Combinaciones variante + servicio (una URL por cada fila de variant_has_service)
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

// El idioma se controla con ?lang=xx (ver navbar__lang). El español (idioma
// por defecto) no lleva parámetro; el resto de idiomas sí.
function url_con_lang(string $base, string $path, string $lang, string $default_lang): string
{
    return $lang === $default_lang
        ? $base . $path
        : $base . $path . '?lang=' . $lang;
}

function imprimir_url(string $base, string $path, string $priority, array $langs, string $default_lang): void
{
    foreach ($langs as $lang) {
        echo "  <url>\n";
        echo "    <loc>" . htmlspecialchars(url_con_lang($base, $path, $lang, $default_lang)) . "</loc>\n";

        foreach ($langs as $alt_lang) {
            $alt_href = url_con_lang($base, $path, $alt_lang, $default_lang);
            echo "    <xhtml:link rel=\"alternate\" hreflang=\"" . htmlspecialchars($alt_lang) . "\" href=\"" . htmlspecialchars($alt_href) . "\" />\n";
        }
        // x-default apunta a la versión sin parámetro de idioma (español)
        echo "    <xhtml:link rel=\"alternate\" hreflang=\"x-default\" href=\"" . htmlspecialchars($base . $path) . "\" />\n";

        echo "    <priority>" . $priority . "</priority>\n";
        echo "  </url>\n";
    }
}

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">' . "\n";

foreach ($estaticas as $pagina) {
    imprimir_url($base, $pagina['loc'], $pagina['priority'], $langs, $default_lang);
}

foreach ($filas as $fila) {
    $slug_variante = slugify($fila['variante']);
    $slug_servicio = slugify($fila['titulo']);
    $path = '/servicio/' . $slug_variante . '/' . $slug_servicio;

    imprimir_url($base, $path, '0.8', $langs, $default_lang);
}

echo '</urlset>';

$xml = trim(ob_get_clean());
header('Content-Type: application/xml; charset=utf-8');
echo $xml;
