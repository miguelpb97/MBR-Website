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
  <title><?= t('terms_meta_title') ?></title>
  <link rel="icon" href="./img/mbr_logo_new.ico" type="image/x-icon" />
  <link rel="mask-icon" href="./img/mbr_logo_new.svg" color="#000000" />
  <link rel="stylesheet" href="css/styles.css" />
  <link rel="stylesheet" href="css/chat-widget.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icons/7.2.3/css/flag-icons.min.css">
</head>

<body>
  <nav class="navbar" id="navbar">
    <div class="navbar__inner">
      <a href="index.php" class="navbar__logo">
        <img
          class="navbar__logo"
          src="./img/mbr_logo_blanco_sin_fondo.png"
          alt="Logo"
          height="75rem"
          width="75rem" />
      </a>
      <div class="navbar__links">
        <a href="index.php" class="navbar__link"><?= t('nav_home') ?></a>
        <a href="servicios.php" class="navbar__link"><?= t('nav_products') ?></a>
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
    <a href="servicios.php" class="navbar__link"><?= t('nav_products') ?></a>
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
      <span class="section-label"><?= t('legal_label') ?></span>
      <h1 class="section-title"><?= t('terms_title_pre') ?><br /><em><?= t('terms_title_em') ?></em></h1>
    </div>
  </div>

  <section class="section section--dark" style="padding-top: 2rem">
    <div class="container">
      <div class="legal__content">
        <h2><?= t('terms_h1') ?></h2>
        <p><?= t('terms_p1') ?></p>

        <h2><?= t('terms_h2') ?></h2>
        <p><?= t('terms_p2') ?></p>

        <h2><?= t('terms_h3') ?></h2>
        <p><?= t('terms_p3') ?></p>

        <h2><?= t('terms_h4') ?></h2>
        <p><?= t('terms_p4') ?></p>

        <h2><?= t('terms_h5') ?></h2>
        <p><?= t('terms_p5') ?></p>

        <h2><?= t('terms_h6') ?></h2>
        <p><?= t('terms_p6') ?></p>

        <h2><?= t('terms_h7') ?></h2>
        <p><?= t('terms_p7') ?></p>

        <h2><?= t('terms_h8') ?></h2>
        <p><?= t('terms_p8') ?></p>

        <h2><?= t('terms_h9') ?></h2>
        <p><?= t('terms_p9') ?></p>

        <h2><?= t('terms_h10') ?></h2>
        <p><?= t('terms_p10') ?></p>

        <h2><?= t('terms_h11') ?></h2>
        <p><?= t('terms_p11') ?></p>

        <h2><?= t('terms_h12') ?></h2>
        <p><?= t('terms_p12') ?></p>
      </div>
    </div>
  </section>

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
    const CHAT_I18N = <?= json_encode([
                        'aria_label' => t('chat_aria_label'),
                        'greeting'   => t('chat_greeting'),
                        'wp_button'  => t('chat_wp_button'),
                        'wp_message' => t('chat_wp_message'),
                      ]) ?>;
  </script>
  <script src="js/chat-widget.js"></script>
</body>

</html>