<?php
require_once __DIR__ . '/../cfg/config.php';
require_once __DIR__ . '/../public_html/includes/translate.php';

$current_lang  = detect_language();
$translations  = load_translations($current_lang);
?>
<!doctype html>
<html lang="<?= htmlspecialchars($current_lang) ?>">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="description" content="<?= t('services_meta_description') ?>" />
  <title><?= t('services_meta_title') ?></title>
  <link rel="icon" href="./img/mbr_logo_new.ico" type="image/x-icon" />
  <link rel="mask-icon" href="./img/mbr_logo_new.svg" color="#000000" />
  <link rel="stylesheet" href="css/styles.css" />
  <link rel="stylesheet" href="css/chat-widget.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icons/7.2.3/css/flag-icons.min.css">
</head>

<body>
  <nav class="navbar scrolled" id="navbar">
    <div class="navbar__inner">
      <a href="index.php" class="navbar__logo">
        <img
          class="navbar__logo"
          src="./img/mbr_logo_blanco_sin_fondo.png"
          alt="Logo"
          height="75"
          width="75" />
      </a>
      <div class="navbar__links">
        <a href="index.php" class="navbar__link"><?= t('nav_home') ?></a>
        <a href="servicios.php" class="navbar__link active"><?= t('nav_products') ?></a>
        <a href="contacto.php" class="navbar__link"><?= t('nav_contact') ?></a>
        <a href="store.php" class="navbar__link"><?= t('nav_store') ?></a>
        <a href="contacto.php" class="btn btn--primary navbar__cta"><?= t('nav_btn_book_service') ?></a>
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
    <a href="index.php" class="navbar__link"><?= t('nav_home') ?></a>
    <a href="servicios.php" class="navbar__link active"><?= t('nav_products') ?></a>
    <a href="contacto.php" class="navbar__link"><?= t('nav_contact') ?></a>
    <a href="store.php" class="navbar__link"><?= t('nav_store') ?></a>
    <a href="contacto.php" class="btn btn--primary"><?= t('nav_btn_book_service') ?></a>

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

  <div class="page-header">
    <div class="page-header__inner">
      <div class="accent-line"></div>
      <span class="section-label"><?= t('services_catalog_label') ?></span>
      <h1 class="section-title"><?= t('services_title_pre') ?><br /><em><?= t('services_title_em') ?></em></h1>
    </div>
  </div>

  <!-- MODELOS -->
  <section class="section section--dark" style="padding-top: 2rem; padding-bottom: 2rem">
    <div class="container">
      <div class="models__grid" id="modelsGrid">
        <div class="skeleton" style="height: 110px"></div>
        <div class="skeleton" style="height: 110px"></div>
        <div class="skeleton" style="height: 110px"></div>
        <div class="skeleton" style="height: 110px"></div>
      </div>
    </div>
  </section>

  <!-- VARIANTES -->
  <section class="section section--darker" id="variantsSection" style="display: none; padding-top: 2rem; padding-bottom: 2rem">
    <div class="container">
      <div style="border-top: 1px solid var(--carbon-800); padding-top: 2rem">
        <span class="section-label" id="variantsLabel"><?= t('services_variants_label') ?></span>
        <div class="variants__list" id="variantsList"></div>
      </div>
    </div>
  </section>

  <!-- SERVICIOS -->
  <section class="section section--dark" id="servicesSection" style="display: none; padding-top: 2rem">
    <div class="container">
      <div style="border-top: 1px solid var(--carbon-800); padding-top: 2rem">
        <span class="section-label" id="servicesLabel"><?= t('services_available_label') ?></span>
        <div class="services__grid" id="servicesGrid" style="margin-top: 1.5rem"></div>
      </div>
    </div>
    <p style="padding-top: 4rem" class="content-justification-center text-align-center hero__subtitle">
      <?= t('services_disclaimer_1') ?><br>
      <?= t('services_disclaimer_2') ?><br>
      <?= t('services_disclaimer_3') ?><br><br>
      <?= t_html('services_contact_cta', [
        '{link}' => '<a href="contacto.php" style="color: var(--accent-400)">' . t('services_contact_link_label') . '</a>',
      ]) ?>
    </p>
  </section>

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
            <a href="index.php" class="footer__link"><?= t('footer_link_home') ?></a>
            <a href="servicios.php" class="footer__link"><?= t('footer_link_services') ?></a>
            <a href="contacto.php" class="footer__link"><?= t('footer_link_contact') ?></a>
            <a href="store.php" class="footer__link"><?= t('nav_store') ?></a>
          </div>
        </div>
        <div>
          <p class="footer__col-title"><?= t('footer_legal_title') ?></p>
          <div class="footer__links">
            <a href="politica-de-privacidad.php" class="footer__link"><?= t('footer_link_privacy') ?></a>
            <a href="terminos-y-condiciones.php" class="footer__link"><?= t('footer_link_terms') ?></a>
          </div>
        </div>
      </div>
      <div class="footer__bottom">
        <span class="footer__copy">© <span id="year"></span> <?= t('footer_copy_rest') ?></span>
        <span class="footer__made"><?= t('footer_made') ?></span>
      </div>
    </div>
  </footer>

  <script src="js/main.js"></script>
  <script>
    const BASE_URL = <?= json_encode(BASE_URL) ?>;
    const PHONE_NUMBER = <?= json_encode(PHONE_NUMBER) ?>;
    const CURRENT_LANG = <?= json_encode($current_lang) ?>;
    const I18N = <?= json_encode([
                    'no_models'      => t('services_js_no_models'),
                    'no_variants'    => t('services_js_no_variants'),
                    'no_services'    => t('services_js_no_services'),
                    'error_variants' => t('services_js_error_variants'),
                    'error_services' => t('services_js_error_services'),
                    'error_models'   => t('services_js_error_models'),
                    'variants_suffix' => t('services_js_variants_suffix'),
                    'services_label' => t('services_available_label'),
                    'price_consult'  => t('services_js_price_consult'),
                  ]) ?>;
  </script>
  <script src="js/servicios.js"></script>
</body>

</html>