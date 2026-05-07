<?php
require_once __DIR__ . '/../cfg/config.php';
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="description" content="Contacta con MBR Almería para solicitar información sobre nuestros servicios de coding y retrofits." />
  <title>Contacto - MBR Almería</title>
  <link rel="icon" href="./img/mbr_logo_new.ico" type="image/x-icon" />
  <link rel="mask-icon" href="./img/mbr_logo_new.svg" color="#000000" />
  <link rel="stylesheet" href="css/styles.css" />
  <script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>
</head>
<body>

  <nav class="navbar scrolled" id="navbar">
    <div class="navbar__inner">
      <a href="index.php" class="navbar__logo">
        <img class="navbar__logo" src="./img/mbr_logo_blanco_sin_fondo.png" alt="Logo" height="75" width="75" />
      </a>
      <div class="navbar__links">
        <a href="index.php" class="navbar__link">Inicio</a>
        <a href="servicios.php" class="navbar__link">Servicios</a>
        <a href="contacto.php" class="navbar__link active">Contacto</a>
        <a href="contacto.php" class="btn btn--primary navbar__cta">Pedir Cita</a>
      </div>
      <button class="navbar__burger" id="burger" aria-label="Menú">
        <span></span><span></span><span></span>
      </button>
    </div>
  </nav>

  <div class="navbar__mobile" id="mobileMenu">
    <a href="index.php" class="navbar__link">Inicio</a>
    <a href="servicios.php" class="navbar__link">Servicios</a>
    <a href="contacto.php" class="navbar__link active">Contacto</a>
    <a href="contacto.php" class="btn btn--primary">Pedir Cita</a>
  </div>

  <div class="page-header">
    <div class="page-header__inner">
      <div class="accent-line"></div>
      <span class="section-label">Contacto</span>
      <p class="content-justification-center text-align-center hero__subtitle">
        Para cualquier consulta, puedes escribirnos directamente a través del
        siguiente formulario, por
        <a
              href="<?= CORREO_CONTACTO ?>"
              style="color: var(--accent-400)"
              > correo electrónico</a>, o por
        <a id="link_wp" href="<?= WHATSAPP_CONTACTO ?>">WhatsApp<img
          src="./img/whatsapp_icon.png"
          alt="WhatsApp Icon"
          width="20"
          height="20"
        /></a>
        <br />
        Le atenderemos lo antes posible.
        <br />
        Horario: <?= HORARIO ?>
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
                <label class="form__label" for="nombre">Nombre *</label>
                <input class="form__input" type="text" id="nombre" name="nombre" placeholder="Tu nombre" required />
              </div>
              <div class="form__group">
                <label class="form__label" for="email">Email *</label>
                <input class="form__input" type="email" id="email" name="email" placeholder="tu@email.com" required />
              </div>
            </div>

            <div class="form__row">
              <div class="form__group">
                <label class="form__label" for="telefono">Teléfono</label>
                <input class="form__input" type="tel" id="telefono" name="telefono" placeholder="+34 600 000 000" />
              </div>
              <div class="form__group">
                <label class="form__label" for="modelo">Modelo</label>
                <input class="form__input" type="text" id="modelo" name="modelo" placeholder="Ej: C220d W205 2018" />
              </div>
            </div>

            <div class="form__group">
              <label class="form__label" for="mensaje">Mensaje *</label>
              <textarea class="form__textarea" id="mensaje" name="mensaje" placeholder="Describe qué servicio necesitas..." required></textarea>
            </div>

            <!-- Honeypot anti-spam -->
            <div style="display:none;">
              <input type="text" name="empresa" tabindex="-1" autocomplete="off" />
            </div>

            <!-- Turnstile -->
            <div class="form__group">
              <div class="cf-turnstile" data-sitekey="<?= htmlspecialchars(CF_SITEKEY_TEST) ?>" data-theme="dark"></div>
            </div>

            <div id="formError" class="form__error" style="display:none;"></div>

            <button type="submit" class="btn btn--primary form__submit" id="submitBtn">
              Enviar consulta
            </button>

            <p class="form__legal">
              Al enviar aceptas nuestra <a href="privacidad.php">política de privacidad</a>
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
          <div class="footer__brand-sub">Mercedes Specialist</div>
          <p class="footer__brand-text">Especialistas en coding y retrofits para vehículos Mercedes-Benz. Diagnóstico profesional con herramientas de fabricante.</p>
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
            <a href="privacidad.php" class="footer__link">Política de privacidad</a>
            <a href="terminos.php" class="footer__link">Términos y condiciones</a>
          </div>
        </div>
      </div>
      <div class="footer__bottom">
        <span class="footer__copy">© <span id="year"></span> MBR Almería. Todos los derechos reservados.</span>
        <span class="footer__made">MBR Almería - Mercedes-Benz Specialist</span>
      </div>
    </div>
  </footer>

  <script src="js/main.js"></script>
  <script src="js/contacto.js"></script>
</body>
</html>
