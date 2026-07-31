/* ---------- Tabs ---------- */
document.querySelectorAll(".store-tab").forEach((tab) => {
  tab.addEventListener("click", () => {
    document.querySelectorAll(".store-tab").forEach((t) => t.classList.remove("active"));
    document.querySelectorAll(".store-panel").forEach((p) => p.classList.remove("active"));

    tab.classList.add("active");
    document.getElementById(tab.dataset.panel).classList.add("active");

    if (tab.dataset.panel === "productsPanel" && !productsLoaded) {
      loadProducts();
    }
  });
});

/* ---------- Repuestos: sin buscador real (aún no hay fuente de datos),
   solo recoge la referencia y manda al formulario de contacto. ---------- */
document.getElementById("partsSearchForm").addEventListener("submit", (e) => {
  e.preventDefault();
  const ref = document.getElementById("partRefInput").value.trim();
  const url = ref
    ? `contacto.php?referencia=${encodeURIComponent(ref)}`
    : "contacto.php";
  window.location.href = url;
});

/* ---------- Productos (servicios ya existentes, catálogo plano) ---------- */
const API_PRODUCTS = `${BASE_URL}/api/products.php?lang=${CURRENT_LANG}`;
let productsLoaded = false;

function renderProducts(products) {
  const grid = document.getElementById("productGrid");
  grid.innerHTML = "";

  if (!products.length) {
    grid.innerHTML = `<p class="services__empty">${I18N.no_products}</p>`;
    return;
  }

  products.forEach((product) => {
    const card = document.createElement("div");
    card.className = "product-card";

    const imageHTML = product.imagen
      ? `<img src="img/servicios/${product.imagen}" alt="${product.nombre}" class="product-card__image" loading="lazy" />`
      : "";

    const statusHTML = !product.stock
      ? `<span class="product-card__status">${I18N.out_of_stock}</span>`
      : "";

    const hasPrice = product.precio !== null;

    // Con precio: "Añadir al carrito" (lo gestiona cart.js). Sin precio:
    // "Consultar", directo al formulario de contacto.
    const priceHTML = hasPrice
      ? `<span class="product-card__price">${product.precio.toFixed(2)} €</span>`
      : "";

    const btnLabel = hasPrice ? I18N.buy_btn : I18N.consult_btn;
    const btnClass = hasPrice ? "btn--primary" : "btn--outline";

    const btnHTML = hasPrice
      ? `<button type="button" class="btn ${btnClass} product-card__btn"
           data-add-to-cart
           data-id="${product.id}"
           data-nombre="${product.nombre}"
           data-precio="${product.precio}"
           data-imagen="${product.imagen || ""}">
           ${btnLabel}
         </button>`
      : `<a href="contacto.php?producto=${encodeURIComponent(product.nombre)}" class="btn ${btnClass} product-card__btn">
           ${btnLabel}
         </a>`;

    card.innerHTML = `
      ${imageHTML}
      <span class="product-card__name">${product.nombre}</span>
      ${priceHTML}
      ${statusHTML}
      ${btnHTML}
    `;

    grid.appendChild(card);
  });
}

async function loadProducts() {
  const grid = document.getElementById("productGrid");
  try {
    const res = await fetch(API_PRODUCTS);
    const products = await res.json();
    renderProducts(products);
    productsLoaded = true;
  } catch {
    grid.innerHTML = `<p class="services__empty">${I18N.error_products}</p>`;
  }
}