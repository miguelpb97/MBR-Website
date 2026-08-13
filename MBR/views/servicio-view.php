<?php
require_once __DIR__ . '/../cfg/data.php';
require_once __DIR__ . '/../cfg/config.php';
require_once __DIR__ . '/../public_html/includes/translate.php';

$current_lang  = detect_language();
$translations  = load_translations($current_lang);

$slug_variante = $_GET['variante'] ?? '';
$slug_servicio = $_GET['servicio'] ?? '';

if (!$slug_variante || !$slug_servicio) {
  header('Location: /servicios');
  exit;
}

$servicio  = null;
$not_found = false;

try {
  $found = buscarServicioPorSlug($slug_variante, $slug_servicio, $current_lang);

  if (!$found) {
    $not_found = true;
    http_response_code(404);
  } else {
    $servicio = $found;
    $compatibilidad = cargarCompatibilidad($servicio['id'], $current_lang);
  }
} catch (PDOException $e) {
  $not_found = true;
  http_response_code(500);
}

// --- Datos para SEO ---
$base_path = parse_url(BASE_URL, PHP_URL_PATH) ?? '';

$page_title    = $not_found
  ? t('service_detail_404_title') . ' - MBR Almería'
  : htmlspecialchars($servicio['titulo']) . ' · ' . htmlspecialchars($servicio['modelo']) . ' ' . htmlspecialchars($servicio['variante']) . ' - MBR Almería';

$page_desc     = $not_found
  ? t('service_detail_404_desc')
  : (
    $servicio['descripcion']
    ? htmlspecialchars(mb_substr(strip_tags($servicio['descripcion']), 0, 155)) . '…'
    : t('service_detail_default_desc_pre') . ' ' . htmlspecialchars($servicio['modelo']) . ' ' . htmlspecialchars($servicio['variante']) . ' ' . t('service_detail_default_desc_post')
  );

$canonical_path = $base_path . ($not_found
  ? '/servicios.php'
  : '/servicio/' . slugify($servicio['variante']) . '/' . slugify($servicio['titulo_es']));

$canonical     = BASE_URL . ($not_found
  ? '/servicios.php'
  : '/servicio/' . slugify($servicio['variante']) . '/' . slugify($servicio['titulo_es']));

$imagen_og     = (!$not_found && $servicio['imagen'])
  ? BASE_URL . '/img/servicios/' . htmlspecialchars($servicio['imagen'])
  : BASE_URL . '/img/mbr_logo_blanco_sin_fondo.png';

if (!$not_found) {
  $current_path = $_SERVER['REQUEST_URI'];
  if (strpos($current_path, $canonical_path) === false) {
    $query = $_SERVER['QUERY_STRING'] ?? '';
    parse_str($query, $query_params);
    unset($query_params['variante'], $query_params['servicio']);
    $redirect_url = $canonical_path . (!empty($query_params) ? '?' . http_build_query($query_params) : '');

    header("Location: {$redirect_url}", true, 301);
    exit;
  }
}
?>
<!doctype html>
<html lang="<?= htmlspecialchars($current_lang) ?>">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <title><?= $page_title ?></title>
  <meta name="description" content="<?= $page_desc ?>" />
  <link rel="canonical" href="<?= $canonical ?>" />

  <!-- Open Graph -->
  <meta property="og:type" content="product" />
  <meta property="og:title" content="<?= $page_title ?>" />
  <meta property="og:description" content="<?= $page_desc ?>" />
  <meta property="og:url" content="<?= $canonical ?>" />
  <meta property="og:image" content="<?= $imagen_og ?>" />
  <meta property="og:locale" content="<?= str_replace('-', '_', lang_info($current_lang, 'html')) ?>" />
  <meta property="og:site_name" content="MBR Almería" />

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
        <?php if ($servicio['precio'] !== null): ?>,
          "offers": {
            "@type": "Offer",
            "price": "<?= number_format($servicio['precio'], 2, '.', '') ?>",
            "priceCurrency": "EUR",
            "availability": "https://schema.org/InStock"
          }
        <?php endif; ?>
        <?php if ($servicio['imagen']): ?>,
          "image": "<?= $imagen_og ?>"
        <?php endif; ?>
      }
    </script>
  <?php endif; ?>

  <link rel="icon" href="<?= BASE_URL ?>/img/mbr_logo_new.ico" type="image/x-icon" />
  <link rel="mask-icon" href="<?= BASE_URL ?>/img/mbr_logo_new.svg" color="#000000" />
  <link rel="stylesheet" href="<?= BASE_URL ?>/css/styles.css" />
  <link rel="stylesheet" href="<?= BASE_URL ?>/css/chat-widget.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icons/7.2.3/css/flag-icons.min.css">
</head>

<body>

  <!-- NAVBAR -->
  <nav class="navbar scrolled" id="navbar">
    <div class="navbar__inner">
      <a href="<?= BASE_URL ?>/index.php" class="navbar__logo">
        <img class="navbar__logo" src="<?= BASE_URL ?>/img/mbr_logo_blanco_sin_fondo.png" alt="Logo" height="75rem" width="75rem" />
      </a>
      <div class="navbar__links">
        <a href="<?= BASE_URL ?>/index.php" class="navbar__link"><?= t('nav_home') ?></a>
        <a href="<?= BASE_URL ?>/servicios.php" class="navbar__link active"><?= t('nav_products') ?></a>
        <a href="<?= BASE_URL ?>/contacto.php" class="navbar__link"><?= t('nav_contact') ?></a>
        <a href="<?= BASE_URL ?>/contacto.php" class="btn btn--primary navbar__cta"><?= t('nav_btn_book_service') ?></a>
        <div class="navbar__lang">
          <?php foreach (get_available_languages() as $l): ?>
            <a href="?lang=<?= $l ?>"
              class="navbar__lang-flag <?= $l === $current_lang ? 'active' : '' ?>"
              title="<?= lang_info($l, 'label') ?>">
              <span class="fi <?= lang_info($l, 'flag') ?>"></span>
            </a>
          <?php endforeach; ?>
        </div>
      </div>
      <button class="navbar__burger" id="burger" aria-label="<?= t('nav_menu_aria') ?>">
        <span></span><span></span><span></span>
      </button>
    </div>
  </nav>

  <div class="navbar__mobile" id="mobileMenu">
    <a href="<?= BASE_URL ?>/index.php" class="navbar__link"><?= t('nav_home') ?></a>
    <a href="<?= BASE_URL ?>/servicios.php" class="navbar__link active"><?= t('nav_products') ?></a>
    <a href="<?= BASE_URL ?>/contacto.php" class="navbar__link"><?= t('nav_contact') ?></a>
    <a href="<?= BASE_URL ?>/contacto.php" class="btn btn--primary"><?= t('nav_btn_book_service') ?></a>

    <div class="navbar__lang">
      <?php foreach (get_available_languages() as $l): ?>
        <a href="?lang=<?= $l ?>"
          class="navbar__lang-flag <?= $l === $current_lang ? 'active' : '' ?>"
          title="<?= lang_info($l, 'label') ?>">
          <span class="fi <?= lang_info($l, 'flag') ?>"></span>
        </a>
      <?php endforeach; ?>
    </div>
  </div>

  <?php if ($not_found): ?>

    <!-- 404 -->
    <div class="page-header">
      <div class="page-header__inner">
        <div class="accent-line"></div>
        <span class="section-label"><?= t('service_detail_404_label') ?></span>
        <h1 class="section-title"><?= t('service_detail_404_title_pre') ?><br /><em><?= t('service_detail_404_title_em') ?></em></h1>
      </div>
    </div>
    <section class="section section--dark" style="padding-top:2rem;padding-bottom:6rem;text-align:center;">
      <div class="container">
        <p class="hero__subtitle" style="margin-bottom:2.5rem;"><?= t('service_detail_404_text') ?></p>
        <a href="servicios.php" class="btn btn--primary"><?= t('service_detail_404_btn') ?></a>
      </div>
    </section>

  <?php else: ?>

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
        <div class="service-detail__grid">

          <!-- Imagen -->
          <div class="service-detail__image">
            <?php if ($servicio['imagen']): ?>
              <img
                src="<?= BASE_URL ?>/img/servicios/<?= htmlspecialchars($servicio['imagen']) ?>"
                alt="<?= htmlspecialchars($servicio['titulo']) ?> <?= t('service_detail_img_alt_for') ?> <?= htmlspecialchars($servicio['modelo']) ?>" />
            <?php else: ?>
              <div style="width:100%;height:100%;min-height:260px;display:flex;align-items:center;justify-content:center;">
                <span style="font-family:var(--font-mono);font-size:.75rem;color:var(--carbon-600);letter-spacing:.15em;"><?= t('service_detail_no_image') ?></span>
              </div>
            <?php endif; ?>
          </div>

          <!-- Info -->
          <div class="about__text" style="display:flex;flex-direction:column;gap:2rem;">

            <!-- Precio + CTAs -->
            <div style="border-bottom:1px solid var(--carbon-800);padding-bottom:1.5rem;display:flex;justify-content:space-between;align-items:flex-end;flex-wrap:wrap;gap:1.5rem;">
              <div>
                <span class="section-label"><?= t('service_detail_price_label') ?></span>
                <?php if ($servicio['precio'] !== null): ?>
                  <div style="font-family:var(--font-body);font-size:3.5rem;font-weight:600;color:var(--carbon-50);line-height:1.1;">
                    <?= number_format($servicio['precio'], 0, ',', '.') ?>&thinsp;€
                  </div>
                  <p style="font-family:var(--font-mono);font-size:.65rem;color:var(--carbon-600);margin-top:.4rem;letter-spacing:.1em;"><?= t('service_tax') ?></p>
                <?php else: ?>
                  <div style="font-family:var(--font-display);font-size:2.5rem;font-weight:300;color:var(--carbon-400);"><?= t('service_detail_price_consult') ?></div>
                <?php endif; ?>
              </div>

              <div class="hero__actions" style="justify-content:flex-end;margin:0;">
                <a href="<?= BASE_URL ?>/contacto.php?servicio=<?= urlencode($servicio['titulo']) ?>&modelo=<?= urlencode($servicio['variante']) ?>" class="btn btn--outline">
                  <?= t('service_detail_cta_interested') ?>
                </a>
              </div>
            </div>

            <!-- Descripción -->
            <?php if ($servicio['descripcion']): ?>
              <div>
                <span class="section-label"><?= t('service_detail_description_label') ?></span>
                <p style="color:var(--carbon-400);font-size:.9rem;line-height:1.8;">
                  <?= nl2br(htmlspecialchars($servicio['descripcion'])) ?>
                </p>
              </div>
            <?php endif; ?>

          </div>
        </div>

        <!-- Compatibilidad — ancho completo -->
        <div class="tool-card" style="margin-top:3rem;">
          <div class="tool-card__line"></div>
          <p class="tool-card__name"><?= t('service_detail_compat_label') ?></p>
          <div class="compat__grid" style="margin-top:.75rem;">
            <?php foreach ($compatibilidad as $modelo => $variantes): ?>
              <div class="compat__chip">
                <strong><?= htmlspecialchars($modelo) ?></strong>
                <span>— <?= htmlspecialchars(implode(', ', $variantes)) ?></span>
              </div>
            <?php endforeach; ?>
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
          <div class="footer__brand-sub"><?= t('footer_brand_sub') ?></div>
          <p class="footer__brand-text"><?= t('footer_brand_text') ?></p>
        </div>
        <div>
          <p class="footer__col-title"><?= t('footer_nav_title') ?></p>
          <div class="footer__links">
            <a href="<?= BASE_URL ?>/index.php" class="footer__link"><?= t('footer_link_home') ?></a>
            <a href="<?= BASE_URL ?>/servicios.php" class="footer__link"><?= t('footer_link_services') ?></a>
            <a href="<?= BASE_URL ?>/contacto.php" class="footer__link"><?= t('footer_link_contact') ?></a>
          </div>
        </div>
        <div>
          <p class="footer__col-title"><?= t('footer_legal_title') ?></p>
          <div class="footer__links">
            <a href="<?= BASE_URL ?>/politica-de-privacidad.php" class="footer__link"><?= t('footer_link_privacy') ?></a>
            <a href="<?= BASE_URL ?>/terminos-y-condiciones.php" class="footer__link"><?= t('footer_link_terms') ?></a>
          </div>
        </div>
      </div>
      <div class="footer__bottom">
        <span class="footer__copy">© <span id="year"></span> <?= t('footer_copy_rest') ?></span>
        <span class="footer__made"><?= t('footer_made') ?></span>
      </div>
    </div>
  </footer>

  <script src="<?= BASE_URL ?>/js/main.js"></script>
  <script>
    const BASE_URL = <?= json_encode(BASE_URL) ?>;
    const PHONE_NUMBER = <?= json_encode(PHONE_NUMBER) ?>;
    const CHAT_I18N = <?= json_encode([
                        'aria_label' => t('chat_aria_label'),
                        'greeting'   => t('chat_greeting'),
                        'wp_button'  => t('chat_wp_button'),
                        'wp_message' => t('chat_wp_message'),
                      ]) ?>;
  </script>
  <script src="<?= BASE_URL ?>/js/chat-widget.js"></script>
</body>

</html>