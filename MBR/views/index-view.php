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
  <meta name="description" content="<?= t('meta_description') ?>" />
  <title><?= t('meta_title') ?></title>
  <link rel="icon" href="./img/mbr_logo_new.ico" type="image/x-icon" />
  <link rel="mask-icon" href="./img/mbr_logo_new.svg" color="#000000" />
  <link rel="stylesheet" href="css/styles.css" />
  <link rel="stylesheet" href="css/chat-widget.css" />
  <link rel="canonical" href="https://www.mbretrofitalmeria.es/" />

  <!-- Open Graph -->
  <meta property="og:type" content="website" />
  <meta property="og:url" content="https://www.mbretrofitalmeria.es/" />
  <meta property="og:title" content="<?= t('og_title') ?>" />
  <meta property="og:description" content="<?= t('og_description') ?>" />
  <meta property="og:image" content="https://www.mbretrofitalmeria.es/img/hero_imagen1.png" />
  <meta property="og:locale" content="<?= str_replace('-', '_', lang_info($current_lang, 'html')) ?>" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icons/7.2.3/css/flag-icons.min.css">
  <!-- Schema -->
  <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "AutoRepair",
      "name": "MB Retrofit Almería",
      "url": "https://www.mbretrofitalmeria.es",
      "telephone": "+34645482782",
      "email": "mbretrofitalmeria@gmail.com",
      "description": "Especialistas en coding SCN y retrofits para vehículos Mercedes-Benz en Almería.",
      "areaServed": {
        "@type": "City",
        "name": "Almería"
      },
      "priceRange": "€€"
    }
  </script>
</head>

<body>
  <!-- NAVBAR -->
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
        <a href="index.php" class="navbar__link active"><?= t('nav_home') ?></a>
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

  <!-- MOBILE MENU -->
  <div class="navbar__mobile" id="mobileMenu">
    <a href="index.php" class="navbar__link active"><?= t('nav_home') ?></a>
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

  <!-- HERO -->
  <section class="hero">
    <div class="hero__bg" style="background-image: url(img/hero-img.jpg)"></div>
    <div class="hero__overlay"></div>
    <div class="hero__content">
      <span class="section-label"><?= t('hero_label') ?></span>
      <p class="hero__subtitle"><?= t('hero_subtitle') ?></p>
      <div class="hero__actions">
        <a href="servicios.php" class="btn btn--primary"><?= t('hero_btn_services') ?></a>
        <a href="contacto.php" class="btn btn--outline"><?= t('hero_btn_contact') ?></a>
      </div>
    </div>
    <div class="hero__scroll">
      <div class="hero__scroll-line"></div>
      <span class="hero__scroll-text"><?= t('hero_scroll_text') ?></span>
    </div>
  </section>

  <!-- ABOUT -->
  <section class="section section--dark">
    <div class="container">
      <div class="about__grid">
        <div class="about__text">
          <div class="accent-line"></div>
          <span class="section-label"><?= t('about_label') ?></span>
          <h2 class="section-title">
            <?= t('about_title_pre') ?><br /><em><?= t('about_title_em') ?></em>
          </h2>
          <p><?= t('about_text_1') ?></p>
          <p><?= t('about_text_2') ?></p>
        </div>
        <div class="about__image about__slider">
          <img src="img/slide-img1.jpg" alt="" class="about__slide active" />
          <img src="img/slide-img2.jpg" alt="" class="about__slide" />
          <img src="img/slide-img3.jpg" alt="" class="about__slide" />
        </div>
      </div>
    </div>
  </section>

  <!-- WHAT WE DO -->
  <section class="section section--darker">
    <div class="container">
      <div class="whatwedo__header">
        <div class="accent-line accent-line--center"></div>
        <span class="section-label"><?= t('whatwedo_label') ?></span>
        <h2 class="section-title"><?= t('whatwedo_title') ?></h2>
      </div>
      <div class="whatwedo__grid">
        <div class="card">
          <svg class="whatwedo__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9.75 3.104v5.714a2.25 2.25 0 0 1-.659 1.591L5 14.5M9.75 3.104c-.251.023-.501.05-.75.082m.75-.082a24.301 24.301 0 0 1 4.5 0m0 0v5.714c0 .597.237 1.17.659 1.591L19.8 15.3M14.25 3.104c.251.023.501.05.75.082M19.8 15.3l-1.57.393A9.065 9.065 0 0 1 12 15a9.065 9.065 0 0 0-6.23-.693L5 14.5m14.8.8 1.402 1.402c1.232 1.232.65 3.318-1.067 3.611A48.309 48.309 0 0 1 12 21a48.25 48.25 0 0 1-8.135-.687c-1.718-.293-2.3-2.379-1.067-3.61L5 14.5" />
          </svg>
          <h3 class="card__title"><?= t('whatwedo_card1_title') ?></h3>
          <p class="card__text"><?= t('whatwedo_card1_text') ?></p>
        </div>

        <div class="card">
          <svg class="whatwedo__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" d="M11.42 15.17 17.25 21A2.652 2.652 0 0 0 21 17.25l-5.877-5.877M11.42 15.17l2.496-3.03c.317-.384.74-.626 1.208-.766M11.42 15.17l-4.655 5.653a2.548 2.548 0 1 1-3.586-3.586l5.654-4.654m5.965-3.979-.14.469a1.5 1.5 0 0 1-1.372 1.031H15m-7.979 5.966.469-.14a1.5 1.5 0 0 0 1.031-1.372V15" />
          </svg>
          <h3 class="card__title"><?= t('whatwedo_card2_title') ?></h3>
          <p class="card__text"><?= t('whatwedo_card2_text') ?></p>
        </div>

        <div class="card">
          <svg class="whatwedo__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 3v11.25A2.25 2.25 0 0 0 6 16.5h2.25M3.75 3h-1.5m1.5 0h16.5m0 0h1.5m-1.5 0v11.25A2.25 2.25 0 0 1 18 16.5h-2.25m-7.5 0h7.5m-7.5 0-1 3m8.5-3 1 3m0 0 .5 1.5m-.5-1.5h-9.5m0 0-.5 1.5m.75-9 3-3 2.148 2.148A12.061 12.061 0 0 1 16.5 7.605" />
          </svg>
          <h3 class="card__title"><?= t('whatwedo_card3_title') ?></h3>
          <p class="card__text"><?= t('whatwedo_card3_text') ?></p>
        </div>
      </div>
    </div>
  </section>

  <!-- TOOLS -->
  <section class="section section--dark">
    <div class="container">
      <div class="tools__header">
        <div class="accent-line"></div>
        <span class="section-label"><?= t('tools_label') ?></span>
        <h2 class="section-title">
          <?= t('tools_title_pre') ?><br /><em><?= t('tools_title_em') ?></em>
        </h2>
      </div>
      <div class="tools__grid">
        <div class="tool-card">
          <div class="tool-card__line"></div>
          <p class="tool-card__name"><?= t('tool1_name') ?></p>
          <p class="tool-card__desc"><?= t('tool1_desc') ?></p>
        </div>
        <div class="tool-card">
          <div class="tool-card__line"></div>
          <p class="tool-card__name"><?= t('tool2_name') ?></p>
          <p class="tool-card__desc"><?= t('tool2_desc') ?></p>
        </div>
        <div class="tool-card">
          <div class="tool-card__line"></div>
          <p class="tool-card__name"><?= t('tool3_name') ?></p>
          <p class="tool-card__desc"><?= t('tool3_desc') ?></p>
        </div>
      </div>
    </div>
  </section>

  <!-- FAQ -->
  <section class="section section--darker">
    <div class="container">
      <div class="faq__header">
        <div class="accent-line accent-line--center"></div>
        <span class="section-label"><?= t('faq_label') ?></span>
        <h2 class="section-title"><?= t('faq_title') ?></h2>
      </div>
      <div class="faq__list">
        <div class="faq__item">
          <button class="faq__question">
            <?= t('faq_q1') ?>
            <span class="faq__icon">+</span>
          </button>
          <div class="faq__answer">
            <p><?= t('faq_a1') ?></p>
          </div>
        </div>

        <div class="faq__item">
          <button class="faq__question">
            <?= t('faq_q2') ?>
            <span class="faq__icon">+</span>
          </button>
          <div class="faq__answer">
            <p><?= t('faq_a2') ?></p>
          </div>
        </div>

        <div class="faq__item">
          <button class="faq__question">
            <?= t('faq_q3') ?>
            <span class="faq__icon">+</span>
          </button>
          <div class="faq__answer">
            <p><?= t('faq_a3') ?></p>
          </div>
        </div>

        <div class="faq__item">
          <button class="faq__question">
            <?= t('faq_q4') ?>
            <span class="faq__icon">+</span>
          </button>
          <div class="faq__answer">
            <p><?= t('faq_a4') ?></p>
          </div>
        </div>

        <div class="faq__item">
          <button class="faq__question">
            <?= t('faq_q5') ?>
            <span class="faq__icon">+</span>
          </button>
          <div class="faq__answer">
            <p><?= t('faq_a5') ?></p>
          </div>
        </div>

        <div class="faq__item">
          <button class="faq__question">
            <?= t('faq_q6') ?>
            <span class="faq__icon">+</span>
          </button>
          <div class="faq__answer">
            <p><?= t('faq_a6') ?></p>
          </div>
        </div>
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