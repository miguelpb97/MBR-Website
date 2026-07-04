<?php
require_once __DIR__ . '/../cfg/config.php';
?>
<!doctype html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Política de Privacidad - MBR Almería</title>
    <link rel="icon" href="./img/mbr_logo_new.ico" type="image/x-icon" />
    <link rel="mask-icon" href="./img/mbr_logo_new.svg" color="#000000" />
    <link rel="stylesheet" href="css/styles.css" />
    <link rel="stylesheet" href="css/chat-widget.css" />
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
            width="75rem"
          />
        </a>
        <div class="navbar__links">
          <a href="index.php" class="navbar__link">Inicio</a>
          <a href="servicios.php" class="navbar__link">Servicios</a>
          <a href="contacto.php" class="navbar__link">Contacto</a>
          <a href="contacto.php" class="btn btn--primary navbar__cta"
            >Pedir Cita</a
          >
        </div>
        <button class="navbar__burger" id="burger" aria-label="Menú">
          <span></span><span></span><span></span>
        </button>
      </div>
    </nav>

    <div class="navbar__mobile" id="mobileMenu">
      <a href="index.php" class="navbar__link">Inicio</a>
      <a href="servicios.php" class="navbar__link">Servicios</a>
      <a href="contacto.php" class="navbar__link">Contacto</a>
      <a href="contacto.php" class="btn btn--primary">Pedir Cita</a>
    </div>

    <div class="page-header">
      <div class="page-header__inner">
        <div class="accent-line"></div>
        <span class="section-label">Legal</span>
        <h1 class="section-title">Política de<br /><em>privacidad</em></h1>
      </div>
    </div>

    <section class="section section--dark" style="padding-top: 2rem">
      <div class="container">
        <div class="legal__content">
          <h2>1. Introducción</h2>
          <p>
            En MBR Almería nos tomamos muy en serio la protección de tu
            privacidad. Esta Política de Privacidad describe cómo recopilamos,
            usamos y protegemos tus datos personales cuando utilizas nuestro
            sitio web, de conformidad con el Reglamento General de Protección de
            Datos (RGPD) y la Ley Orgánica 3/2018 de Protección de Datos
            Personales y garantía de los derechos digitales (LOPDGDD).
          </p>

          <h2>2. Responsable del tratamiento</h2>
          <p>
            El responsable del tratamiento de tus datos personales es MBR
            Almería, con domicilio en Almería. Para cualquier consulta
            relacionada con el tratamiento de tus datos, puedes contactarnos a
            través del formulario de contacto disponible en el sitio web o
            mediante el correo electrónico
            <a
              href="mailto:<?= EMAIL ?>"
              style="color: var(--accent-400)"
              >mbretrofitalmeria@gmail.com</a
            >.
          </p>

          <h2>3. Información que recopilamos</h2>
          <p>
            Recopilamos información personal que nos proporcionas de manera
            voluntaria a través de nuestro formulario de contacto, como:
          </p>
          <ul class="ul-privacy-policy">
            <li class="li-privacy-policy">Nombre.</li>
            <li class="li-privacy-policy">Dirección de correo electrónico.</li>
            <li class="li-privacy-policy">Teléfono (si se proporciona).</li>
            <li class="li-privacy-policy">
              Datos del vehículo (si se proporciona).
            </li>
            <li class="li-privacy-policy">Consulta en cuestión.</li>
          </ul>
          <p>
            No recopilamos datos de forma automática salvo los estrictamente
            necesarios para el funcionamiento técnico del sitio.
          </p>

          <h2>4. Finalidad y legitimación del tratamiento</h2>
          <p>
            La información recopilada se utiliza exclusivamente para responder a
            tus consultas o solicitudes realizadas a través del formulario de
            contacto, y para mejorar nuestros servicios. La base legal que
            legitima el tratamiento es el consentimiento expreso del interesado
            al enviar el formulario, de conformidad con el artículo 6.1.a del
            RGPD.
          </p>

          <h2>5. Plazo de conservación</h2>
          <p>
            Tus datos serán conservados durante el tiempo necesario para atender
            tu consulta y, una vez finalizada la relación, durante los plazos
            legalmente establecidos. Transcurrido dicho plazo, los datos serán
            eliminados de forma segura.
          </p>

          <h2>6. Protección de datos</h2>
          <p>
            Implementamos medidas técnicas y organizativas adecuadas para
            proteger tu información personal frente a accesos no autorizados,
            pérdida o alteración. No obstante, ninguna transmisión de datos a
            través de internet puede garantizarse como completamente segura.
          </p>

          <h2>7. No cesión de datos a terceros</h2>
          <p>
            No compartimos, vendemos ni cedemos tu información personal a
            terceros. Únicamente podremos comunicar tus datos cuando exista una
            obligación legal, una orden judicial o sea necesario para proteger
            nuestros derechos legítimos.
          </p>

          <h2>8. Tus derechos</h2>
          <p>
            En cualquier momento puedes ejercer tus derechos de acceso,
            rectificación, supresión, oposición, portabilidad y limitación del
            tratamiento de tus datos personales, dirigiéndote a nosotros a
            través del formulario de contacto o del correo electrónico indicado.
            Asimismo, tienes derecho a presentar una reclamación ante la Agencia
            Española de Protección de Datos (<a
              href="https://www.aepd.es"
              target="_blank"
              style="color: var(--accent-400)"
              >www.aepd.es</a
            >) si consideras que el tratamiento de tus datos no es conforme a la
            normativa vigente.
          </p>

          <h2>9. Enlaces a otros sitios</h2>
          <p>
            Nuestro sitio puede contener enlaces a otros sitios web. No nos
            hacemos responsables de las prácticas de privacidad de esos sitios.
            Te recomendamos leer las políticas de privacidad de cualquier sitio
            que visites a través de un enlace desde el nuestro.
          </p>

          <h2>10. Modificaciones de esta política</h2>
          <p>
            Nos reservamos el derecho de modificar esta Política de Privacidad
            en cualquier momento para adaptarla a cambios legislativos o de
            nuestros servicios. Cualquier modificación será publicada en esta
            página e indicará la fecha de última actualización. Te recomendamos
            revisarla periódicamente.
          </p>

          <h2>11. Ley aplicable</h2>
          <p>
            Esta Política de Privacidad se rige por la legislación española y
            europea en materia de protección de datos. Cualquier disputa
            relacionada con el tratamiento de datos personales será resuelta
            conforme a dicha legislación, siendo competentes los tribunales de
            Almería.
          </p>
        </div>
      </div>
    </section>

    <!-- FOOTER -->
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
              <a href="politica-de-privacidad.php" class="footer__link"
                >Política de privacidad</a
              >
              <a href="terminos-y-condiciones.php" class="footer__link"
                >Términos y condiciones</a
              >
            </div>
          </div>
        </div>
        <div class="footer__bottom">
          <span class="footer__copy"
            >© <span id="year"></span> MBR Almería. Todos los derechos
            reservados.</span
          >
          <span class="footer__made"
            >MBR Almería - Mercedes-Benz Specialist</span
          >
        </div>
      </div>
    </footer>

    <script src="js/main.js"></script>
    <script>
      const URL = <?= json_encode(BASE_URL) ?>;
      const PHONE_NUM = <?= json_encode(PHONE_NUMBER) ?>;
    </script>
    <script src="js/chat-widget.js"></script>
  </body>
</html>
