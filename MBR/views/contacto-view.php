<?php
require_once __DIR__ . '/../cfg/config.php';
require_once __DIR__ . '/../public_html/includes/translate.php';

$current_lang  = detect_language();
$translations  = load_translations($current_lang);

$VARIANTE = $_GET['modelo'] ?? '';
$SERVICIO = $_GET['servicio'] ?? '';
?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars($current_lang) ?>">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="description" content="<?= t('contact_meta_description') ?>" />
  <title><?= t('contact_meta_title') ?></title>
  <link rel="icon" href="./img/mbr_logo_new.ico" type="image/x-icon" />
  <link rel="mask-icon" href="./img/mbr_logo_new.svg" color="#000000" />
  <link rel="stylesheet" href="css/styles.css" />
  <link rel="stylesheet" href="css/chat-widget.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icons/7.2.3/css/flag-icons.min.css">
  <script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>
</head>

<body>

  <nav class="navbar scrolled" id="navbar">
    <div class="navbar__inner">
      <a href="index.php" class="navbar__logo">
        <img class="navbar__logo" src="./img/mbr_logo_blanco_sin_fondo.png" alt="Logo" height="75" width="75" />
      </a>
      <div class="navbar__links">
        <a href="index.php" class="navbar__link"><?= t('nav_home') ?></a>
        <a href="servicios.php" class="navbar__link"><?= t('nav_products') ?></a>
        <a href="contacto.php" class="navbar__link active"><?= t('nav_contact') ?></a>
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
    <a href="contacto.php" class="navbar__link active"><?= t('nav_contact') ?></a>
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
      <span class="section-label"><?= t('nav_contact') ?></span>
      <p class="content-justification-center text-align-center hero__subtitle">
        <?= t_html('contact_intro', [
          '{email}' => '<a href="mailto:' . htmlspecialchars(EMAIL) . '" style="color: var(--accent-400)">' . t('contact_intro_email_label') . '</a>',
          '{whatsapp}' => '<a style="color: var(--color-wp)" href="https://api.whatsapp.com/send/?phone=' . htmlspecialchars(PHONE_NUMBER) . '">WhatsApp</a>',
        ]) ?><br>
        <?= t_html('contact_schedule', ['{schedule}' => htmlspecialchars(SCHEDULE)]) ?>
      </p>
    </div>
  </div>

  <section class="section section--dark" style="padding-top:1.5rem;">
    <div class="container">
      <div style="max-width:640px; margin:0 auto;">
        <div id="formWrapper">
          <form id="contactForm" novalidate>

            <div class="form__row">
              <div class="form__group">
                <label class="form__label" for="nombre"><?= t('form_name_label') ?> *</label>
                <input class="form__input" type="text" id="nombre" name="nombre" placeholder="<?= t('form_name_placeholder') ?>" required />
              </div>
              <div class="form__group">
                <label class="form__label" for="email"><?= t('form_email_label') ?> *</label>
                <input class="form__input" type="email" id="email" name="email" placeholder="tu@email.com" required />
              </div>
            </div>

            <div class="form__row">
              <div class="form__group">
                <label class="form__label" for="telefono"><?= t('form_phone_label') ?></label>
                <input class="form__input" type="tel" id="telefono" name="telefono" placeholder="+34 600 000 000" />
              </div>
              <div class="form__group">
                <label class="form__label" for="modelo"><?= t('form_model_label') ?></label>
                <input class="form__input" type="text" id="modelo" name="modelo" placeholder="<?= t('form_model_placeholder') ?>" value="<?= htmlspecialchars(empty($VARIANTE) ? '' : $VARIANTE) ?>" />
              </div>
            </div>

            <div class="form__group">
              <label class="form__label" for="mensaje"><?= t('form_message_label') ?> *</label>
              <textarea class="form__textarea" id="mensaje" name="mensaje" placeholder="<?= t('form_message_placeholder') ?>" required><?= htmlspecialchars(empty($SERVICIO) ? '' : $SERVICIO) ?></textarea>
            </div>

            <!-- Honeypot anti-spam -->
            <div style="display:none;">
              <input type="text" name="empresa" tabindex="-1" autocomplete="off" />
            </div>

            <!-- Turnstile -->
            <div class="form__group">
              <div class="cf-turnstile" data-sitekey="<?= htmlspecialchars(CF_SITEKEY) ?>" data-theme="dark"></div>
            </div>

            <div id="formError" class="form__error" style="display:none;"></div>

            <button type="submit" class="btn btn--primary form__submit" id="submitBtn">
              <?= t('form_submit_btn') ?>
            </button>

            <p class="form__legal">
              <?= t('form_legal_pre') ?> <a href="politica-de-privacidad.php"><?= t('form_legal_link') ?></a>.
            </p>

          </form>
        </div>
      </div>
    </div>
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
    const CHAT_I18N = <?= json_encode([
                        'aria_label' => t('chat_aria_label'),
                        'greeting'   => t('chat_greeting'),
                        'wp_button'  => t('chat_wp_button'),
                        'wp_message' => t('chat_wp_message'),
                      ]) ?>;
    const FORM_I18N = <?= json_encode([
                        'error_turnstile' => t('form_error_turnstile'),
                        'error_required'  => t('form_error_required'),
                        'error_generic'   => t('form_error_generic'),
                        'sending'         => t('form_sending'),
                        'submit_btn'      => t('form_submit_btn'),
                        'success_title'   => t('form_success_title'),
                        'success_text'    => t('form_success_text'),
                      ]) ?>;
  </script>
  <script src="js/chat-widget.js"></script>
  <script src="js/contacto.js"></script>
</body>

</html>