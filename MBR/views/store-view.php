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
  <meta name="description" content="<?= t('store_meta_description') ?>" />
  <title><?= t('store_meta_title') ?></title>
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
        <a href="servicios.php" class="navbar__link"><?= t('nav_products') ?></a>
        <a href="contacto.php" class="navbar__link"><?= t('nav_contact') ?></a>
        <a href="store.php" class="navbar__link active"><?= t('nav_store') ?></a>
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
    <a href="store.php" class="navbar__link active"><?= t('nav_store') ?></a>
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
      <span class="section-label"><?= t('store_catalog_label') ?></span>
      <h1 class="section-title"><?= t('store_title_pre') ?><br /><em><?= t('store_title_em') ?></em></h1>
    </div>
  </div>

  <section class="section section--dark" style="padding-top: 3rem">
    <div class="container">

      <div class="store-tabs" id="storeTabs">
        <button class="store-tab active" data-panel="partsPanel"><?= t('store_tab_parts') ?></button>
        <button class="store-tab" data-panel="productsPanel"><?= t('store_tab_products') ?></button>
      </div>

      <!-- REPUESTOS -->
      <div class="store-panel active" id="partsPanel">
        <p class="parts-intro"><?= t('parts_intro') ?></p>
        <form class="parts-search" id="partsSearchForm">
          <input
            type="text"
            class="form__input parts-search__input"
            id="partRefInput"
            name="ref"
            placeholder="<?= t('parts_input_placeholder') ?>"
            autocomplete="off" />
          <button type="submit" class="btn btn--primary parts-search__btn"><?= t('parts_consult_btn') ?></button>
        </form>
      </div>

      <!-- PRODUCTOS -->
      <div class="store-panel" id="productsPanel">
        <div class="product-grid" id="productGrid">
          <div class="skeleton" style="height: 220px"></div>
          <div class="skeleton" style="height: 220px"></div>
          <div class="skeleton" style="height: 220px"></div>
        </div>
      </div>

    </div>
  </section>

  <!-- CARRITO -->
  <button class="cart-fab" id="cartFab" aria-label="<?= t('cart_title') ?>">
    🛒<span class="cart-fab__badge" id="cartBadge" style="display:none">0</span>
  </button>

  <div class="cart-overlay" id="cartOverlay"></div>

  <aside class="cart-drawer" id="cartDrawer">
    <div class="cart-drawer__header">
      <span class="section-label"><?= t('cart_title') ?></span>
      <button class="cart-drawer__close" id="cartClose" aria-label="<?= t('cart_close') ?>">&times;</button>
    </div>

    <div class="cart-drawer__items" id="cartItems"></div>

    <div class="cart-drawer__footer">
      <div class="cart-drawer__row">
        <span><?= t('cart_subtotal') ?></span>
        <span id="cartSubtotal">0,00 €</span>
      </div>
      <div class="cart-drawer__row">
        <span><?= t('cart_iva') ?></span>
        <span id="cartIva">0,00 €</span>
      </div>
      <div class="cart-drawer__total">
        <span><?= t('cart_total') ?></span>
        <span id="cartTotal">0,00 €</span>
      </div>
      <div id="paypal-button-container"></div>
      <p class="cart-drawer__msg" id="cartMsg"></p>
    </div>
  </aside>

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

  <script src="https://www.paypal.com/sdk/js?client-id=<?= urlencode(PAYPAL_CLIENT_ID) ?>&currency=EUR"></script>
  <script src="js/main.js"></script>
  <script>
    const BASE_URL = <?= json_encode(BASE_URL) ?>;
    const PHONE_NUMBER = <?= json_encode(PHONE_NUMBER) ?>;
    const CURRENT_LANG = <?= json_encode($current_lang) ?>;
    const I18N = <?= json_encode([
                    'no_products'      => t('products_js_no_products'),
                    'error_products'   => t('products_js_error'),
                    'buy_btn'          => t('products_add_cart_btn'),
                    'consult_btn'      => t('parts_consult_btn'),
                    'out_of_stock'     => t('products_out_of_stock'),
                    'cart_title'       => t('cart_title'),
                    'cart_empty'       => t('cart_empty'),
                    'cart_total'       => t('cart_total'),
                    'cart_remove'      => t('cart_remove'),
                    'cart_checkout_error' => t('cart_checkout_error'),
                    'cart_processing'  => t('cart_processing'),
                    'cart_success'     => t('cart_success'),
                  ]) ?>;
  </script>
  <script src="js/store.js"></script>
  <script src="js/cart.js"></script>
</body>

</html>