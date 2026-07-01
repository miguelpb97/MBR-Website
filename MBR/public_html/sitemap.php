<?php
require_once __DIR__ . '/api/config.php';

header('Content-Type: application/xml; charset=utf-8');

function slugify(string $text): string {
    $text = iconv('UTF-8', 'ASCII//TRANSLIT', $text);
    $text = strtolower($text);
    $text = preg_replace('/[^a-z0-9]+/', '-', $text);
    $text = trim($text, '-');
    return $text ?: 'servicio';
}

$base = 'https://' . $_SERVER['HTTP_HOST'];

try {
    $pdo  = getDB();
    $stmt = $pdo->query("
        SELECT
            s.name     AS titulo,
            v.name     AS variante
        FROM service s
        JOIN variant_has_service vhs ON vhs.service_id = s.id_service
        JOIN variant             v   ON v.id_variant   = vhs.variant_id
        WHERE s.stock = 1
        ORDER BY s.id_service ASC
    ");
    $services = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    $services = [];
}

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">

  <!-- Páginas estáticas -->
  <url>
    <loc><?= $base ?>/index.php</loc>
    <changefreq>monthly</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc><?= $base ?>/servicios.php</loc>
    <changefreq>weekly</changefreq>
    <priority>0.9</priority>
  </url>
  <url>
    <loc><?= $base ?>/contacto.php</loc>
    <changefreq>monthly</changefreq>
    <priority>0.7</priority>
  </url>

  <!-- Páginas individuales de servicios -->
  <?php foreach ($services as $s): ?>
  <url>
    <loc><?= $base ?>/servicio/<?= slugify($s['variante']) ?>/<?= slugify($s['titulo']) ?></loc>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>
  <?php endforeach; ?>

</urlset>
