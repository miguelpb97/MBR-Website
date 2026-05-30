/* ── PayPal ─────────────────────────────────────────────────────
   Añadir estas líneas al final de cfg/config.php
   Sandbox:  https://developer.paypal.com/dashboard/applications/sandbox
   Live:     https://developer.paypal.com/dashboard/applications/live
─────────────────────────────────────────────────────────────── */

define('PAYPAL_MODE',          'sandbox');   // 'sandbox' | 'live'
define('PAYPAL_CLIENT_ID',     'TU_PAYPAL_CLIENT_ID_AQUI');
define('PAYPAL_CLIENT_SECRET', 'TU_PAYPAL_CLIENT_SECRET_AQUI');
define('PAYPAL_API_BASE',
    PAYPAL_MODE === 'live'
        ? 'https://api-m.paypal.com'
        : 'https://api-m.sandbox.paypal.com'
);
