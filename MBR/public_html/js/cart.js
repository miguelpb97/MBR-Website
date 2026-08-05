const CART_KEY = "mbr_cart";
const IVA_RATE = 0.21; // 21% España — si cambia, actualízalo también en api/paypal-create-order.php

function getCart() {
  try {
    return JSON.parse(localStorage.getItem(CART_KEY)) || [];
  } catch {
    return [];
  }
}

function saveCart(cart) {
  localStorage.setItem(CART_KEY, JSON.stringify(cart));
  renderCart();
}

function addToCart(item) {
  const cart = getCart();
  const existing = cart.find((i) => i.id === item.id);

  if (existing) {
    existing.qty += 1;
  } else {
    cart.push({
      id: item.id,
      nombre: item.nombre,
      precio: item.precio,
      imagen: item.imagen,
      qty: 1,
    });
  }

  saveCart(cart);
  openCart();
}

function removeFromCart(id) {
  saveCart(getCart().filter((i) => i.id !== id));
}

function changeQty(id, delta) {
  const cart = getCart();
  const item = cart.find((i) => i.id === id);
  if (!item) return;

  item.qty += delta;
  if (item.qty <= 0) {
    saveCart(cart.filter((i) => i.id !== id));
  } else {
    saveCart(cart);
  }
}

function cartTotals(cart) {
  const subtotal = cart.reduce((sum, i) => sum + i.precio * i.qty, 0);
  const iva = subtotal * IVA_RATE;
  return {
    subtotal: Math.round(subtotal * 100) / 100,
    iva: Math.round(iva * 100) / 100,
    total: Math.round((subtotal + iva) * 100) / 100,
  };
}

function formatPrice(n) {
  return n.toLocaleString("es-ES", { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + " €";
}

/* ---------- Render ---------- */
function renderCart() {
  const cart = getCart();
  const badge = document.getElementById("cartBadge");
  const itemsEl = document.getElementById("cartItems");
  const subtotalEl = document.getElementById("cartSubtotal");
  const ivaEl = document.getElementById("cartIva");
  const totalEl = document.getElementById("cartTotal");
  const payPalContainer = document.getElementById("paypal-button-container");

  const count = cart.reduce((sum, i) => sum + i.qty, 0);
  badge.textContent = count;
  badge.style.display = count > 0 ? "flex" : "none";

  if (!cart.length) {
    itemsEl.innerHTML = `<p class="cart-drawer__empty">${I18N.cart_empty}</p>`;
    subtotalEl.textContent = formatPrice(0);
    ivaEl.textContent = formatPrice(0);
    totalEl.textContent = formatPrice(0);
    payPalContainer.style.display = "none";
    return;
  }

  payPalContainer.style.display = "block";

  itemsEl.innerHTML = cart
    .map(
      (item) => `
    <div class="cart-item">
      ${item.imagen ? `<img src="img/${item.imagen}" alt="${item.nombre}" class="cart-item__image" loading="lazy" />` : ""}
      <div class="cart-item__info">
        <span class="cart-item__name">${item.nombre}</span>
        <span class="cart-item__price">${formatPrice(item.precio)}</span>
        <div class="cart-item__qty">
          <button type="button" data-qty-minus="${item.id}">−</button>
          <span>${item.qty}</span>
          <button type="button" data-qty-plus="${item.id}">+</button>
        </div>
      </div>
      <button type="button" class="cart-item__remove" data-remove="${item.id}" aria-label="${I18N.cart_remove}">&times;</button>
    </div>
  `,
    )
    .join("");

  const totals = cartTotals(cart);
  subtotalEl.textContent = formatPrice(totals.subtotal);
  ivaEl.textContent = formatPrice(totals.iva);
  totalEl.textContent = formatPrice(totals.total);
}

/* ---------- Drawer open/close ---------- */
function openCart() {
  document.getElementById("cartDrawer").classList.add("open");
  document.getElementById("cartOverlay").classList.add("open");
}

function closeCart() {
  document.getElementById("cartDrawer").classList.remove("open");
  document.getElementById("cartOverlay").classList.remove("open");
}

document.getElementById("cartFab").addEventListener("click", openCart);
document.getElementById("cartClose").addEventListener("click", closeCart);
document.getElementById("cartOverlay").addEventListener("click", closeCart);

/* Delegación: añadir al carrito, quitar, +/- cantidad */
document.addEventListener("click", (e) => {
  const addBtn = e.target.closest("[data-add-to-cart]");
  if (addBtn) {
    addToCart({
      id: Number(addBtn.dataset.id),
      nombre: addBtn.dataset.nombre,
      precio: Number(addBtn.dataset.precio),
      imagen: addBtn.dataset.imagen,
    });
    return;
  }

  const removeBtn = e.target.closest("[data-remove]");
  if (removeBtn) {
    removeFromCart(Number(removeBtn.dataset.remove));
    return;
  }

  const plusBtn = e.target.closest("[data-qty-plus]");
  if (plusBtn) {
    changeQty(Number(plusBtn.dataset.qtyPlus), 1);
    return;
  }

  const minusBtn = e.target.closest("[data-qty-minus]");
  if (minusBtn) {
    changeQty(Number(minusBtn.dataset.qtyMinus), -1);
  }
});

/* ---------- PayPal ---------- */
if (window.paypal) {
  paypal
    .Buttons({
      style: { layout: "vertical", color: "black", label: "paypal" },

      createOrder: function () {
        const cart = getCart();
        const msg = document.getElementById("cartMsg");
        msg.textContent = I18N.cart_processing;
        msg.className = "cart-drawer__msg";

        return fetch(`${BASE_URL}/api/paypal-create-order.php`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            items: cart.map((i) => ({ id: i.id, qty: i.qty })),
          }),
        })
          .then((res) => res.json())
          .then((data) => {
            if (!data.id) throw new Error(data.error || "error");
            return data.id;
          })
          .catch(() => {
            msg.textContent = I18N.cart_checkout_error;
            msg.className = "cart-drawer__msg cart-drawer__msg--error";
            throw new Error("create order failed");
          });
      },

      onApprove: function (data) {
        return fetch(`${BASE_URL}/api/paypal-capture-order.php`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ orderID: data.orderID }),
        })
          .then((res) => res.json())
          .then((details) => {
            const msg = document.getElementById("cartMsg");
            if (details.status === "paid") {
              localStorage.removeItem(CART_KEY);
              renderCart();
              msg.textContent = I18N.cart_success;
              msg.className = "cart-drawer__msg cart-drawer__msg--success";
            } else {
              msg.textContent = I18N.cart_checkout_error;
              msg.className = "cart-drawer__msg cart-drawer__msg--error";
            }
          });
      },

      onError: function () {
        const msg = document.getElementById("cartMsg");
        msg.textContent = I18N.cart_checkout_error;
        msg.className = "cart-drawer__msg cart-drawer__msg--error";
      },
    })
    .render("#paypal-button-container");
}

renderCart();