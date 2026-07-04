<?php
require_once __DIR__ . '/../cfg/data.php';

$slug_variante = $_GET['variante'] ?? '';
$slug_servicio = $_GET['servicio'] ?? '';

if (!$slug_variante || !$slug_servicio) {
    header('Location: /servicios');
    exit;
}

$servicio  = null;
$not_found = false;

try {
    $found = buscarServicioPorSlug($slug_variante, $slug_servicio);

    if (!$found) {
        $not_found = true;
        http_response_code(404);
    } else {
        $servicio = $found;
        $compatibilidad = cargarCompatibilidad($servicio['id']);
    }

} catch (PDOException $e) {
    $not_found = true;
    http_response_code(500);
}

// --- Datos para SEO ---
$page_title    = $not_found
    ? 'Servicio no encontrado - MBR Almería'
    : htmlspecialchars($servicio['titulo']) . ' · ' . htmlspecialchars($servicio['modelo']) . ' ' . htmlspecialchars($servicio['variante']) . ' - MBR Almería';

$page_desc     = $not_found
    ? 'El servicio solicitado no está disponible.'
    : (
        $servicio['descripcion']
            ? htmlspecialchars(mb_substr(strip_tags($servicio['descripcion']), 0, 155)) . '…'
            : 'Servicio de coding SCN y retrofit para ' . htmlspecialchars($servicio['modelo']) . ' ' . htmlspecialchars($servicio['variante']) . ' en MBR Almería.'
      );

$canonical_path = $not_found
    ? '/servicios.php'
    : '/servicio/' . slugify($servicio['variante']) . '/' . slugify($servicio['titulo']);

$canonical     = 'https://' . $_SERVER['HTTP_HOST'] . $canonical_path;
$imagen_og     = (!$not_found && $servicio['imagen'])
    ? 'https://' . $_SERVER['HTTP_HOST'] . '/img/servicios/' . htmlspecialchars($servicio['imagen'])
    : 'https://' . $_SERVER['HTTP_HOST'] . '/img/mbr_logo_blanco_sin_fondo.png';

// Si acceden sin slug (servicio.php?id=42) o con slug desactualizado,
// redirige 301 a la URL canónica para evitar contenido duplicado
if (!$not_found) {
    $current_path = $_SERVER['REQUEST_URI'];
    if (strpos($current_path, $canonical_path) === false) {
        header("Location: {$canonical_path}", true, 301);
        exit;
    }
}
?>
<!doctype html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title><?= $page_title ?></title>
    <meta name="description" content="<?= $page_desc ?>" />
    <link rel="canonical" href="<?= $canonical ?>" />

    <!-- Open Graph -->
    <meta property="og:type"        content="product" />
    <meta property="og:title"       content="<?= $page_title ?>" />
    <meta property="og:description" content="<?= $page_desc ?>" />
    <meta property="og:url"         content="<?= $canonical ?>" />
    <meta property="og:image"       content="<?= $imagen_og ?>" />
    <meta property="og:locale"      content="es_ES" />
    <meta property="og:site_name"   content="MBR Almería" />

    <!-- Schema.org (ld+json) para Google Rich Results -->
    <?php if (!$not_found): ?>
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "Service",
      "name": "<?= addslashes($servicio['titulo']) ?>",
      "description": "<?= addslashes(strip_tags($servicio['descripcion'] ?? '')) ?>",
      "provider": {
        "@type": "LocalBusiness",
        "name": "MBR Almería",
        "url": "https://<?= $_SERVER['HTTP_HOST'] ?>"
      }
      <?php if ($servicio['precio'] !== null): ?>
      ,"offers": {
        "@type": "Offer",
        "price": "<?= number_format($servicio['precio'], 2, '.', '') ?>",
        "priceCurrency": "EUR",
        "availability": "https://schema.org/InStock"
      }
      <?php endif; ?>
      <?php if ($servicio['imagen']): ?>
      ,"image": "<?= $imagen_og ?>"
      <?php endif; ?>
    }
    </script>
    <?php endif; ?>

    <link rel="icon"        href="<?= BASE_URL ?>/img/mbr_logo_new.ico"  type="image/x-icon" />
    <link rel="mask-icon"   href="<?= BASE_URL ?>/img/mbr_logo_new.svg"  color="#000000" />
    <link rel="stylesheet"  href="<?= BASE_URL ?>/css/styles.css" />
    <link rel="stylesheet"  href="<?= BASE_URL ?>/css/chat-widget.css" />
  </head>
  <body>

    <!-- NAVBAR -->
    <nav class="navbar scrolled" id="navbar">
      <div class="navbar__inner">
        <a href="<?= BASE_URL ?>/index.php" class="navbar__logo">
          <img class="navbar__logo" src="<?= BASE_URL ?>/img/mbr_logo_blanco_sin_fondo.png" alt="Logo" height="75rem" width="75rem" />
        </a>
        <div class="navbar__links">
          <a href="<?= BASE_URL ?>/index.php"     class="navbar__link">Inicio</a>
          <a href="<?= BASE_URL ?>/servicios.php" class="navbar__link active">Servicios</a>
          <a href="<?= BASE_URL ?>/contacto.php"  class="navbar__link">Contacto</a>
          <a href="<?= BASE_URL ?>/contacto.php"  class="btn btn--primary navbar__cta">Pedir Cita</a>
        </div>
        <button class="navbar__burger" id="burger" aria-label="Menú">
          <span></span><span></span><span></span>
        </button>
      </div>
    </nav>

    <div class="navbar__mobile" id="mobileMenu">
      <a href="<?= BASE_URL ?>/index.php"     class="navbar__link">Inicio</a>
      <a href="<?= BASE_URL ?>/servicios.php" class="navbar__link active">Servicios</a>
      <a href="<?= BASE_URL ?>/contacto.php"  class="navbar__link">Contacto</a>
      <a href="<?= BASE_URL ?>/contacto.php"  class="btn btn--primary">Pedir Cita</a>
    </div>

    <?php if ($not_found): ?>

    <!-- 404 -->
    <div class="page-header">
      <div class="page-header__inner">
        <div class="accent-line"></div>
        <span class="section-label">Error 404</span>
        <h1 class="section-title">Servicio<br /><em>no encontrado</em></h1>
      </div>
    </div>
    <section class="section section--dark" style="padding-top:2rem;padding-bottom:6rem;text-align:center;">
      <div class="container">
        <p class="hero__subtitle" style="margin-bottom:2.5rem;">Este servicio no existe o ya no está disponible.</p>
        <a href="servicios.php" class="btn btn--primary">Ver todos los servicios</a>
      </div>
    </section>

    <?php else: ?>

    <!-- BREADCRUMB -->
    <nav aria-label="Breadcrumb" style="background:var(--carbon-950);padding:.75rem 0;border-bottom:1px solid var(--carbon-800);">
      <div class="container" style="font-family:var(--font-mono);font-size:.7rem;letter-spacing:.1em;color:var(--carbon-500);display:flex;gap:.5rem;align-items:center;flex-wrap:wrap;">
        <a href="index.php" style="color:var(--carbon-400);transition:color .3s;">Inicio</a>
        <span style="color:var(--carbon-700);">/</span>
        <a href="servicios.php" style="color:var(--carbon-400);transition:color .3s;">Servicios</a>
        <span style="color:var(--carbon-700);">/</span>
        <span style="color:var(--accent-400);"><?= htmlspecialchars($servicio['titulo']) ?></span>
      </div>
    </nav>

    <!-- PAGE HEADER -->
    <div class="page-header">
      <div class="page-header__inner">
        <div class="accent-line"></div>
        <span class="section-label"><?= htmlspecialchars($servicio['modelo']) ?> &middot; <?= htmlspecialchars($servicio['variante']) ?></span>
        <h1 class="section-title"><?= htmlspecialchars($servicio['titulo']) ?></h1>
      </div>
    </div>

    <!-- CONTENIDO PRINCIPAL -->
    <section class="section section--dark" style="padding-top:3rem;padding-bottom:6rem;">
      <div class="container">
        <div class="about__grid" style="align-items: flex-start;">

          <!-- Imagen -->
          <div class="about__image">
            <?php if ($servicio['imagen']): ?>
              <img
                src="<?= BASE_URL ?>/img/servicios/<?= htmlspecialchars($servicio['imagen']) ?>"
                alt="<?= htmlspecialchars($servicio['titulo']) ?> para <?= htmlspecialchars($servicio['modelo']) ?>"
                style="width:100%;height:100%;object-fit:cover;"
              />
            <?php else: ?>
              <div style="width:100%;height:100%;min-height:260px;display:flex;align-items:center;justify-content:center;">
                <span style="font-family:var(--font-mono);font-size:.75rem;color:var(--carbon-600);letter-spacing:.15em;">SIN IMAGEN</span>
              </div>
            <?php endif; ?>
          </div>

          <!-- Info -->
          <div class="about__text" style="display:flex;flex-direction:column;gap:2rem;">

          <!-- Precio + CTAs -->
          <div style="border-bottom:1px solid var(--carbon-800);padding-bottom:1.5rem;display:flex;justify-content:space-between;align-items:flex-end;flex-wrap:wrap;gap:1.5rem;">
            <div>
              <span class="section-label">Precio</span>
              <?php if ($servicio['precio'] !== null): ?>
                <div style="font-family:var(--font-body);font-size:3.5rem;font-weight:600;color:var(--carbon-50);line-height:1.1;">
                  <?= number_format($servicio['precio'], 0, ',', '.') ?>&thinsp;€
                </div>
                <!-- <p style="font-family:var(--font-mono);font-size:.65rem;color:var(--carbon-600);margin-top:.4rem;letter-spacing:.1em;">IVA NO INCLUIDO</p> -->
              <?php else: ?>
                <div style="font-family:var(--font-display);font-size:2.5rem;font-weight:300;color:var(--carbon-400);">Consultar</div>
              <?php endif; ?>
            </div>

            <div class="hero__actions" style="justify-content:flex-end;margin:0;">
              <a href="<?= BASE_URL ?>/contacto.php?servicio=<?= urlencode($servicio['titulo']) ?>&modelo=<?= urlencode($servicio['modelo']) ?>" class="btn btn--primary">
                Pedir cita
              </a>
              <a href="<?= BASE_URL ?>/servicios.php" class="btn btn--outline">
                ← Volver
              </a>
            </div>
          </div>

            <!-- Descripción -->
            <?php if ($servicio['descripcion']): ?>
            <div>
              <span class="section-label">Descripción</span>
              <p style="color:var(--carbon-400);font-size:.9rem;line-height:1.8;">
                <?= nl2br(htmlspecialchars($servicio['descripcion'])) ?>
              </p>
            </div>
            <?php endif; ?>

            <!-- Compatibilidad -->
            <div class="tool-card">
              <div class="tool-card__line"></div>
              <p class="tool-card__name">Compatible con</p>
              <div style="margin-top:.75rem;display:flex;flex-direction:column;gap:.6rem;">
                <?php foreach ($compatibilidad as $modelo => $variantes): ?>
                  <p style="font-family:var(--font-display);font-size:1rem;color:var(--carbon-100);">
                    <?= htmlspecialchars($modelo) ?>
                    <span style="color:var(--carbon-500);font-size:.85rem;">
                      — <?= htmlspecialchars(implode(', ', $variantes)) ?>
                    </span>
                  </p>
                <?php endforeach; ?>
              </div>
            </div>

          </div>
        </div>
      </div>
    </section>

    <?php endif; ?>

    <!-- FOOTER -->
    <footer class="footer">
      <div class="footer__inner">
        <div class="footer__grid">
          <div>
            <div class="footer__brand-name">MBR Almería</div>
            <div class="footer__brand-sub">Mercedes Specialist</div>
            <p class="footer__brand-text">
              Especialistas en coding SCN y retrofits para Mercedes-Benz en Almería.
              Diagnóstico oficial con Xentry, Vediamo y DTS Monaco. Garantía 1 año.
            </p>
          </div>
          <div>
            <p class="footer__col-title">Navegación</p>
            <div class="footer__links">
              <a href="<?= BASE_URL ?>/index.php"     class="footer__link">Inicio</a>
              <a href="<?= BASE_URL ?>/servicios.php" class="footer__link">Servicios</a>
              <a href="<?= BASE_URL ?>/contacto.php"  class="footer__link">Contacto</a>
            </div>
          </div>
          <div>
            <p class="footer__col-title">Legal</p>
            <div class="footer__links">
              <a href="<?= BASE_URL ?>/politica-de-privacidad.php" class="footer__link">Política de privacidad</a>
              <a href="<?= BASE_URL ?>/terminos-y-condiciones.php" class="footer__link">Términos y condiciones</a>
            </div>
          </div>
        </div>
        <div class="footer__bottom">
          <span class="footer__copy">© <span id="year"></span> MBR Almería. Todos los derechos reservados.</span>
          <span class="footer__made">MBR Almería - Mercedes-Benz Specialist</span>
        </div>
      </div>
    </footer>

    <script src="<?= BASE_URL ?>/js/main.js"></script>
    <script>
      const URL = <?= json_encode(BASE_URL) ?>;
      const PHONE_NUM = <?= json_encode(PHONE_NUMBER) ?>;
    </script>
    <script src="<?= BASE_URL ?>/js/chat-widget.js"></script>
  </body>
</html>
