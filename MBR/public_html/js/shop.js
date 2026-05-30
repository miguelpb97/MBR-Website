/* =====================================================================
   MBR Almería — shop.js
   Gestión del carrito, checkout PayPal, login/registro e historial
===================================================================== */

const API = {
  cartGet:      'api/cart/get.php',
  cartAdd:      'api/cart/add.php',
  cartRemove:   'api/cart/remove.php',
  cartClear:    'api/cart/clear.php',
  paypalCreate: 'api/paypal/create.php',
  paypalCapture:'api/paypal/capture.php',
  ordersHistory:'api/orders/history.php',
  usersMe:      'api/users/me.php',
  usersLogin:   'api/users/login.php',
  usersRegister:'api/users/register.php',
  usersLogout:  'api/users/logout.php',
  configPublic: 'api/config/public.php',
};

/* ── Estado global ──────────────────────────────────────────────── */
let csrfToken = '';
let cartOpen  = false;

/* ── Helpers HTTP ───────────────────────────────────────────────── */
async function apiGet(url) {
  const r = await fetch(url, { credentials: 'same-origin' });
  return r.json();
}

async function apiPost(url, body) {
  const r = await fetch(url, {
    method: 'POST',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken,
    },
    body: JSON.stringify(body),
  });
  return r.json();
}

/* ── Formatear precio ───────────────────────────────────────────── */
function fmt(price) {
  return Number(price).toLocaleString('es-ES', { style: 'currency', currency: 'EUR' });
}

/* ── Toast notifications ────────────────────────────────────────── */
function toast(msg, type = 'ok') {
  const t = document.getElementById('mbr-toast');
  if (!t) return;
  t.textContent = msg;
  t.className   = `mbr-toast mbr-toast--${type} show`;
  clearTimeout(t._timer);
  t._timer = setTimeout(() => t.classList.remove('show'), 3800);
}

/* ── Badge del carrito ──────────────────────────────────────────── */
function setBadge(count) {
  document.querySelectorAll('.cart-badge').forEach(b => {
    b.textContent = count;
    b.style.display = count > 0 ? 'flex' : 'none';
  });
}

/* ═══════════════════════════════════════════════════════════════════
   CARRITO
═══════════════════════════════════════════════════════════════════ */
async function refreshCart() {
  const data = await apiGet(API.cartGet);
  renderCart(data);
  setBadge(data.count || 0);
}

function renderCart(data) {
  const body  = document.getElementById('cart-body');
  const foot  = document.getElementById('cart-footer');
  const items = data.items || [];

  if (!body) return;

  if (!items.length) {
    body.innerHTML = `<p class="cart-empty">Tu carrito está vacío.</p>`;
    if (foot) foot.style.display = 'none';
    return;
  }

  body.innerHTML = items.map(item => `
    <div class="cart-item" data-id="${item.id}">
      <div class="cart-item__info">
        <div class="cart-item__name">${item.name}</div>
        <div class="cart-item__qty">x${item.quantity}</div>
      </div>
      <div class="cart-item__right">
        <div class="cart-item__price">${fmt(item.price * item.quantity)}</div>
        <button class="cart-item__remove" onclick="removeFromCart(${item.id})" title="Eliminar">×</button>
      </div>
    </div>
  `).join('');

  if (foot) {
    foot.style.display = 'block';
    document.getElementById('cart-total').textContent = fmt(data.total || 0);
  }
}

async function addToCart(id, name, price) {
  const res = await apiPost(API.cartAdd, { id, quantity: 1 });
  if (res.ok) {
    setBadge(res.count);
    toast(`"${name}" añadido al carrito ✓`);
    if (cartOpen) refreshCart();
  } else {
    toast(res.error || 'Error al añadir al carrito', 'err');
  }
}

async function removeFromCart(id) {
  const res = await apiPost(API.cartRemove, { id });
  if (res.ok) {
    setBadge(res.count);
    refreshCart();
  } else {
    toast(res.error || 'Error al eliminar', 'err');
  }
}

function toggleCart() {
  const panel = document.getElementById('cart-panel');
  const overlay = document.getElementById('cart-overlay');
  cartOpen = !cartOpen;
  panel?.classList.toggle('open', cartOpen);
  overlay?.classList.toggle('show', cartOpen);
  if (cartOpen) refreshCart();
}

/* ═══════════════════════════════════════════════════════════════════
   CHECKOUT PAYPAL
═══════════════════════════════════════════════════════════════════ */
async function initPayPalButton() {
  const container = document.getElementById('paypal-button-container');
  if (!container) return;

  try {
    const cfg = await apiGet(API.configPublic);
    if (!cfg.paypal_client_id) return;

    // Carga el SDK de PayPal dinámicamente
    await loadPayPalSDK(cfg.paypal_client_id);

    window.paypal.Buttons({
      style: { layout: 'vertical', color: 'black', shape: 'rect', label: 'pay' },

      // 1) Crear la orden en el servidor
      createOrder: async () => {
        const name  = document.getElementById('checkout-name')?.value.trim();
        const email = document.getElementById('checkout-email')?.value.trim();
        if (!name || !email) {
          toast('Introduce tu nombre y email antes de pagar', 'err');
          return null;
        }
        const res = await apiPost(API.paypalCreate, {});
        if (res.error) { toast(res.error, 'err'); return null; }
        return res.id;
      },

      // 2) Capturar el pago en el servidor (verificación real)
      onApprove: async (data) => {
        const name  = document.getElementById('checkout-name')?.value.trim();
        const email = document.getElementById('checkout-email')?.value.trim();
        showCheckoutSpinner(true);
        const res = await apiPost(API.paypalCapture, {
          paypal_order_id: data.orderID,
          name,
          email,
        });
        showCheckoutSpinner(false);
        if (res.ok) {
          setBadge(0);
          showSuccess(res.order_id);
        } else {
          toast(res.error || 'Error al procesar el pago', 'err');
        }
      },

      onError: (err) => {
        console.error('PayPal error:', err);
        toast('Error en PayPal. Inténtalo de nuevo.', 'err');
      },

      onCancel: () => {
        toast('Pago cancelado.', 'err');
      },
    }).render('#paypal-button-container');

  } catch (e) {
    console.error('Error iniciando PayPal:', e);
  }
}

function loadPayPalSDK(clientId) {
  return new Promise((resolve, reject) => {
    if (window.paypal) { resolve(); return; }
    const s   = document.createElement('script');
    s.src     = `https://www.paypal.com/sdk/js?client-id=${clientId}&currency=EUR&intent=capture`;
    s.onload  = resolve;
    s.onerror = reject;
    document.head.appendChild(s);
  });
}

function showCheckoutSpinner(show) {
  const spin = document.getElementById('checkout-spinner');
  const btn  = document.getElementById('paypal-button-container');
  if (spin) spin.style.display = show ? 'flex' : 'none';
  if (btn)  btn.style.display  = show ? 'none' : 'block';
}

function showSuccess(orderId) {
  const panel = document.getElementById('checkout-success');
  const form  = document.getElementById('checkout-form');
  if (panel) {
    panel.style.display = 'block';
    panel.querySelector('.order-id').textContent = '#' + orderId;
  }
  if (form) form.style.display = 'none';
  refreshCart();
}

/* Abre el modal de checkout desde el carrito */
function openCheckout() {
  const modal = document.getElementById('checkout-modal');
  if (!modal) return;
  modal.classList.add('open');
  document.getElementById('checkout-success').style.display = 'none';
  document.getElementById('checkout-form').style.display    = 'block';
  // Pre-rellena email si está logado
  const emailInput = document.getElementById('checkout-email');
  const nameInput  = document.getElementById('checkout-name');
  if (emailInput && window._MBR_USER?.email) emailInput.value = window._MBR_USER.email;
  if (nameInput  && window._MBR_USER?.name)  nameInput.value  = window._MBR_USER.name;
  initPayPalButton();
}

function closeCheckout() {
  document.getElementById('checkout-modal')?.classList.remove('open');
}

/* ═══════════════════════════════════════════════════════════════════
   HISTORIAL DE PEDIDOS
═══════════════════════════════════════════════════════════════════ */
async function loadOrderHistory(email) {
  const container = document.getElementById('orders-list');
  if (!container) return;
  container.innerHTML = `<div class="skeleton" style="height:60px"></div>
                         <div class="skeleton" style="height:60px"></div>`;

  const data = await apiGet(`${API.ordersHistory}?email=${encodeURIComponent(email)}`);
  if (!Array.isArray(data)) {
    container.innerHTML = `<p class="shop-error">${data.error || 'Error al cargar pedidos'}</p>`;
    return;
  }
  if (!data.length) {
    container.innerHTML = `<p class="cart-empty">Aún no tienes pedidos.</p>`;
    return;
  }

  const statLabel = { paid: 'Pagado', pending: 'Pendiente', cancelled: 'Cancelado', refunded: 'Reembolsado' };
  container.innerHTML = data.map(o => `
    <div class="order-row">
      <div class="order-row__top">
        <span class="order-row__id">Pedido #${o.id_order}</span>
        <span class="order-row__status order-row__status--${o.status}">${statLabel[o.status] || o.status}</span>
      </div>
      <div class="order-row__services">${o.servicios || '—'}</div>
      <div class="order-row__bottom">
        <span class="order-row__date">${new Date(o.created_at).toLocaleDateString('es-ES')}</span>
        <span class="order-row__total">${fmt(o.total)}</span>
      </div>
    </div>
  `).join('');
}

/* ── Formulario de búsqueda de pedidos ──────────────────────────── */
function initOrdersSearch() {
  const form = document.getElementById('orders-search-form');
  if (!form) return;
  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const email = document.getElementById('orders-email')?.value.trim();
    if (email) loadOrderHistory(email);
  });
  // Auto-load si hay usuario logado
  if (window._MBR_USER?.email) {
    document.getElementById('orders-email').value = window._MBR_USER.email;
    loadOrderHistory(window._MBR_USER.email);
  }
}

/* ═══════════════════════════════════════════════════════════════════
   AUTH (login / registro)
═══════════════════════════════════════════════════════════════════ */
function openAuthModal(tab = 'login') {
  const modal = document.getElementById('auth-modal');
  if (!modal) return;
  modal.classList.add('open');
  switchAuthTab(tab);
}

function closeAuthModal() {
  document.getElementById('auth-modal')?.classList.remove('open');
}

function switchAuthTab(tab) {
  document.querySelectorAll('.auth-tab').forEach(t =>
    t.classList.toggle('active', t.dataset.tab === tab));
  document.querySelectorAll('.auth-panel').forEach(p =>
    p.style.display = p.id === `auth-${tab}` ? 'block' : 'none');
}

async function handleLogin(e) {
  e.preventDefault();
  const email    = document.getElementById('login-email').value.trim();
  const password = document.getElementById('login-pass').value;
  const btn      = e.submitter;
  btn.disabled   = true;

  const res = await apiPost(API.usersLogin, { email, password });
  btn.disabled = false;
  if (res.ok) {
    window._MBR_USER = { name: res.name, email };
    updateNavAuth();
    closeAuthModal();
    toast(`¡Bienvenido, ${res.name}!`);
  } else {
    document.getElementById('login-error').textContent = res.error;
  }
}

async function handleRegister(e) {
  e.preventDefault();
  const name     = document.getElementById('reg-name').value.trim();
  const email    = document.getElementById('reg-email').value.trim();
  const password = document.getElementById('reg-pass').value;
  const btn      = e.submitter;
  btn.disabled   = true;

  const res = await apiPost(API.usersRegister, { name, email, password });
  btn.disabled = false;
  if (res.ok) {
    window._MBR_USER = { name: res.name, email };
    updateNavAuth();
    closeAuthModal();
    toast(`Cuenta creada. ¡Bienvenido, ${res.name}!`);
  } else {
    document.getElementById('reg-error').textContent = res.error;
  }
}

async function handleLogout() {
  await apiPost(API.usersLogout, {});
  window._MBR_USER = null;
  updateNavAuth();
  toast('Sesión cerrada.');
}

function updateNavAuth() {
  const user    = window._MBR_USER;
  const authBtn = document.getElementById('nav-auth-btn');
  const userEl  = document.getElementById('nav-user-name');
  const logoutEl= document.getElementById('nav-logout-btn');

  if (!authBtn) return;
  if (user) {
    authBtn.style.display    = 'none';
    userEl.style.display     = 'inline';
    userEl.textContent       = user.name;
    logoutEl.style.display   = 'inline';
  } else {
    authBtn.style.display    = 'inline';
    userEl.style.display     = 'none';
    logoutEl.style.display   = 'none';
  }
}

/* ═══════════════════════════════════════════════════════════════════
   AÑADIR BOTÓN AL SERVICE-ITEM (se llama desde servicios.js)
═══════════════════════════════════════════════════════════════════ */
window.injectAddToCartBtn = function(serviceEl, service) {
  if (service.precio === null) return; // servicios sin precio no se compran online
  const btn = document.createElement('button');
  btn.className = 'btn-add-cart';
  btn.textContent = 'Añadir al carrito';
  btn.addEventListener('click', () => addToCart(service.id, service.titulo, service.precio));
  serviceEl.appendChild(btn);
};

/* ═══════════════════════════════════════════════════════════════════
   INIT
═══════════════════════════════════════════════════════════════════ */
async function initShop() {
  // Obtiene CSRF token y estado de sesión
  const me = await apiGet(API.usersMe);
  csrfToken = me.csrf_token || '';
  if (me.logged_in) {
    window._MBR_USER = { name: me.name, email: me.email };
  }
  updateNavAuth();

  // Badge inicial
  const cart = await apiGet(API.cartGet);
  setBadge(cart.count || 0);

  // Eventos carrito
  document.getElementById('cart-toggle-btn')?.addEventListener('click', toggleCart);
  document.getElementById('cart-overlay')?.addEventListener('click', toggleCart);
  document.getElementById('cart-checkout-btn')?.addEventListener('click', () => {
    toggleCart();
    openCheckout();
  });

  // Eventos modal checkout
  document.getElementById('checkout-close')?.addEventListener('click', closeCheckout);
  document.getElementById('checkout-modal')?.addEventListener('click', (e) => {
    if (e.target === e.currentTarget) closeCheckout();
  });

  // Eventos auth
  document.getElementById('nav-auth-btn')?.addEventListener('click', () => openAuthModal('login'));
  document.getElementById('nav-logout-btn')?.addEventListener('click', handleLogout);
  document.getElementById('auth-modal')?.addEventListener('click', (e) => {
    if (e.target === e.currentTarget) closeAuthModal();
  });
  document.querySelectorAll('.auth-tab').forEach(tab =>
    tab.addEventListener('click', () => switchAuthTab(tab.dataset.tab)));
  document.getElementById('auth-login-form')?.addEventListener('submit', handleLogin);
  document.getElementById('auth-reg-form')?.addEventListener('submit', handleRegister);

  // Historial
  initOrdersSearch();
}

document.addEventListener('DOMContentLoaded', initShop);
