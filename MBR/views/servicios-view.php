<?php
require_once __DIR__ . '/../cfg/config.php';
?>
<!doctype html>
<html lang="es">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta
    name="description"
    content="Catálogo de servicios de coding y retrofits para Mercedes-Benz." />
  <title>Servicios - MBR Almería</title>
  <link rel="icon" href="./img/mbr_logo_new.ico" type="image/x-icon" />
  <link rel="mask-icon" href="./img/mbr_logo_new.svg" color="#000000" />
  <link rel="stylesheet" href="css/styles.css" />
  <link rel="stylesheet" href="css/chat-widget.css" />
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
        <a href="index.php" class="navbar__link">Inicio</a>
        <a href="servicios.php" class="navbar__link active">Servicios</a>
        <a href="contacto.php" class="navbar__link">Contacto</a>
        <a href="contacto.php" class="btn btn--primary navbar__cta">Pedir Cita</a>
      </div>
      <button class="navbar__burger" id="burger" aria-label="Menú">
        <span></span><span></span><span></span>
      </button>
    </div>
  </nav>

  <div class="navbar__mobile" id="mobileMenu">
    <a href="index.php" class="navbar__link">Inicio</a>
    <a href="servicios.php" class="navbar__link active">Servicios</a>
    <a href="contacto.php" class="navbar__link">Contacto</a>
    <a href="contacto.php" class="btn btn--primary">Pedir Cita</a>
  </div>

  <div class="page-header">
    <div class="page-header__inner">
      <div class="accent-line"></div>
      <span class="section-label">Catálogo</span>
      <h1 class="section-title">Selecciona tu<br /><em>Mercedes-Benz</em></h1>
    </div>
  </div>

  <!-- MODELOS -->
  <section
    class="section section--dark"
    style="padding-top: 2rem; padding-bottom: 2rem">
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
  <section
    class="section section--darker"
    id="variantsSection"
    style="display: none; padding-top: 2rem; padding-bottom: 2rem">
    <div class="container">
      <div style="border-top: 1px solid var(--carbon-800); padding-top: 2rem">
        <span class="section-label" id="variantsLabel">Variantes</span>
        <div class="variants__list" id="variantsList"></div>
      </div>
    </div>
  </section>

  <!-- SERVICIOS -->
  <section
    class="section section--dark"
    id="servicesSection"
    style="display: none; padding-top: 2rem">
    <div class="container">
      <div style="border-top: 1px solid var(--carbon-800); padding-top: 2rem">
        <span class="section-label" id="servicesLabel">Servicios disponibles</span>
        <div
          class="services__grid"
          id="servicesGrid"
          style="margin-top: 1.5rem"></div>
      </div>
    </div>
    <p
      style="padding-top: 4rem"
      class="content-justification-center text-align-center hero__subtitle">
      * Todos los modelos que aparecen pueden presentar errores en su
      descripción, falta de servicios y/o variantes. <br>** Los precios de cada servicio, corresponden al servicio de forma individual. Si desea varios codings se aplicará un descuento por volumen.<br><br>
      Para cualquier duda,
      <a href="contacto.php" style="color: var(--accent-400)"> contáctenos</a>.
    </p>
  </section>

  <footer class="footer">
    <div class="footer__inner">
      <div class="footer__grid">
        <div>
          <div class="footer__brand-name">MBR Almería</div>
          <div class="footer__brand-sub">Mercedes Specialist</div>
          <p class="footer__brand-text">
            Especialistas en coding SCN y retrofits para Mercedes-Benz en
            Almería. Diagnóstico oficial con Xentry, Vediamo y DTS Monaco.
            Garantía 1 año.
          </p>
        </div>
        <div>
          <p class="footer__col-title">Navegación</p>
          <div class="footer__links">
            <a href="index.php" class="footer__link">Inicio</a>
            <a href="servicios.php" class="footer__link">Servicios</a>
            <a href="contacto.php" class="footer__link">Contacto</a>
          </div>
        </div>
        <div>
          <p class="footer__col-title">Legal</p>
          <div class="footer__links">
            <a href="politica-de-privacidad.php" class="footer__link">Política de privacidad</a>
            <a href="terminos-y-condiciones.php" class="footer__link">Términos y condiciones</a>
          </div>
        </div>
      </div>
      <div class="footer__bottom">
        <span class="footer__copy">© <span id="year"></span> MBR Almería. Todos los derechos
          reservados.</span>
        <span class="footer__made">MBR Almería - Mercedes-Benz Specialist</span>
      </div>
    </div>
  </footer>

  <script src="js/main.js"></script>
  <script>
    const BASE_URL = <?= json_encode(BASE_URL) ?>;
    const PHONE_NUMBER = <?= json_encode(PHONE_NUMBER) ?>;
  </script>
  <script src="js/chat-widget.js"></script>
  <script src="js/servicios.js"></script>
</body>

</html>