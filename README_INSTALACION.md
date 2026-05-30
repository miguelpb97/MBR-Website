# 🛒 MBR Almería — Integración Tienda + PayPal

## Resumen de archivos nuevos

```
MBR/
├── cfg/
│   ├── cart_get.php          ← API carrito: obtener
│   ├── cart_add.php          ← API carrito: añadir (valida stock y precio en BD)
│   ├── cart_remove.php       ← API carrito: eliminar item
│   ├── cart_clear.php        ← API carrito: vaciar
│   ├── paypal_create.php     ← Crea orden en PayPal (server-side)
│   ├── paypal_capture.php    ← Captura y verifica el pago (server-side) ⭐
│   ├── orders_history.php    ← Historial de pedidos por email
│   ├── users_register.php    ← Registro de usuario
│   ├── users_login.php       ← Login
│   ├── users_logout.php      ← Logout
│   ├── users_me.php          ← Sesión actual + CSRF token
│   └── config_public.php     ← Solo expone el Client ID de PayPal
├── src/
│   ├── Csrf.php              ← Protección CSRF
│   ├── CartManager.php       ← Gestión del carrito en sesión
│   ├── PayPalClient.php      ← Cliente PayPal REST API
│   ├── OrderRepository.php   ← Persistencia de pedidos (PDO)
│   └── UserRepository.php    ← Usuarios con bcrypt
├── public_html/
│   ├── api/
│   │   ├── cart/{get,add,remove,clear}.php
│   │   ├── paypal/{create,capture}.php
│   │   ├── orders/history.php
│   │   ├── users/{me,register,login,logout}.php
│   │   └── config/public.php
│   ├── css/shop.css          ← Estilos de la tienda
│   ├── js/shop.js            ← Lógica carrito + PayPal + auth
│   ├── pedidos.php           ← Página historial de pedidos
│   └── admin/admin_orders.php
└── views/
    ├── pedidos-view.html
    └── admin/admin_orders-view.php
```

---

## Instalación paso a paso

### 1. Ejecutar el SQL en phpMyAdmin

Abrir `shop_tables.sql` y ejecutarlo en tu BD. Crea 3 tablas:
- `users` — clientes registrados
- `orders` — pedidos
- `order_items` — líneas de cada pedido

### 2. Añadir credenciales PayPal a `cfg/config.php`

Copiar el contenido de `config_paypal_additions.php` al final de tu `cfg/config.php`.

Para obtener las claves:
- **Sandbox (pruebas):** https://developer.paypal.com/dashboard/applications/sandbox
- **Live (producción):** https://developer.paypal.com/dashboard/applications/live

```php
define('PAYPAL_MODE',          'sandbox');  // ← cambiar a 'live' para producción
define('PAYPAL_CLIENT_ID',     'TU_CLIENT_ID');
define('PAYPAL_CLIENT_SECRET', 'TU_CLIENT_SECRET');
```

### 3. Copiar los archivos nuevos al proyecto

Copiar todo el contenido de esta carpeta respetando la estructura.

### 4. Parchear `views/servicios-view.html`

Ver el archivo `PATCH_servicios-view.html` — son 4 cambios simples:
1. Añadir `<link rel="stylesheet" href="css/shop.css" />` en `<head>`
2. Añadir botones de auth + carrito en la navbar
3. Añadir los modales y `<script src="js/shop.js">` antes de `</body>`
4. En `js/servicios.js`, añadir una línea en el `forEach` de servicios

### 5. Parchear `js/servicios.js`

En la función `renderServices`, dentro del `forEach`, antes del `grid.appendChild(item)`:

```js
if (window.injectAddToCartBtn) window.injectAddToCartBtn(item, service);
```

### 6. Añadir enlace a "Mis Pedidos" en las navbars

En `views/index-view.html`, `views/contact-view.html`, etc., añadir:

```html
<a href="pedidos.php" class="navbar__link">Mis Pedidos</a>
```

---

## Seguridad implementada

| Medida | Dónde |
|--------|-------|
| CSRF token en todas las mutaciones POST | `Csrf.php` + `shop.js` |
| Validación de pago server-side (nunca confiar en el cliente) | `paypal_capture.php` |
| Verificación del importe capturado vs carrito | `paypal_capture.php` |
| Idempotencia: rechaza re-proceso del mismo `paypal_order_id` | `OrderRepository::isAlreadyProcessed()` |
| Rate limiting en login, registro y consulta de historial | `users_login.php`, `users_register.php`, `orders_history.php` |
| Contraseñas con `password_hash()` bcrypt cost 12 | `UserRepository.php` |
| Prepared statements en todas las queries | todos los Repository |
| `session_regenerate_id()` en login/registro | `users_login.php`, `users_register.php` |
| Cookies de sesión con `secure`, `httponly`, `SameSite=Lax` | `Csrf.php`, `CartManager.php` |
| Stock y precio validados en el servidor al añadir al carrito | `cart_add.php` |
| Solo el `CLIENT_ID` se expone al frontend (nunca el Secret) | `config_public.php` |

---

## Probar en sandbox PayPal

1. Entrar en https://developer.paypal.com/dashboard/testing/sandbox
2. Crear una "Sandbox account" de tipo **Personal** (el comprador)
3. Usar ese email y contraseña en la ventana de PayPal al hacer checkout
4. Verificar que el pedido aparece en `/admin/admin_orders.php`
