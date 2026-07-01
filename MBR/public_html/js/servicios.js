const API = {
  vehicles: "api/vehicles.php",
  variants: (id) => `api/variants.php?id_vehicle=${id}`,
  services: (id) => `api/services.php?id_variant=${id}`,
};

// Helpers
function showError(container, msg) {
  container.innerHTML = `<p style="color:var(--carbon-500);font-family:var(--font-mono);font-size:.8rem;">${msg}</p>`;
}

function imgSrc(path, folder) {
  return path ? `img/${folder}/${path}` : null;
}

// Convierte "Coding Luces LED" -> "coding-luces-led"
function slugify(text) {
  return (
    text
      .toString()
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "") // quita tildes
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-")
      .replace(/^-+|-+$/g, "") || "servicio"
  );
}

// Render modelos
function renderModels(vehicles) {
  const grid = document.getElementById("modelsGrid");
  grid.innerHTML = "";

  if (!vehicles.length) {
    showError(grid, "No hay modelos disponibles.");
    return;
  }

  vehicles.forEach((vehicle) => {
    const btn = document.createElement("button");
    btn.className = "model-card";
    btn.dataset.id = vehicle.id_vehicle;

    btn.innerHTML = `
      <div class="model-card__line"></div>
      <div class="model-card__name">${vehicle.nombre}</div>
    `;

    btn.addEventListener("click", () => selectModel(vehicle, btn));
    grid.appendChild(btn);
  });
}

// Seleccionar modelo --> carga variantes
async function selectModel(vehicle, btn) {
  document
    .querySelectorAll(".model-card")
    .forEach((b) => b.classList.remove("active"));
  btn.classList.add("active");

  // Oculta servicios previos
  document.getElementById("servicesSection").style.display = "none";

  // Muestra sección variantes con skeleton
  const variantsSection = document.getElementById("variantsSection");
  variantsSection.style.display = "block";
  document.getElementById("variantsLabel").textContent =
    `${vehicle.nombre} · Variantes`;
  document.getElementById("variantsList").innerHTML = `
    <div class="skeleton" style="height:40px;width:120px;"></div>
    <div class="skeleton" style="height:40px;width:100px;"></div>
    <div class="skeleton" style="height:40px;width:140px;"></div>
  `;

  setTimeout(
    () =>
      variantsSection.scrollIntoView({ behavior: "smooth", block: "start" }),
    100,
  );

  try {
    const res = await fetch(API.variants(vehicle.id_vehicle));
    const variants = await res.json();
    renderVariants(variants, vehicle.nombre);
  } catch {
    showError(
      document.getElementById("variantsList"),
      "Error al cargar las variantes.",
    );
  }
}

// Render variantes
function renderVariants(variants, modelName) {
  const list = document.getElementById("variantsList");
  list.innerHTML = "";

  if (!variants.length) {
    showError(list, "No hay variantes disponibles para este modelo.");
    return;
  }

  variants.forEach((variant) => {
    const btn = document.createElement("button");
    btn.className = "variant-btn";
    btn.dataset.id = variant.id_variant;
    btn.textContent = variant.nombre;
    btn.addEventListener("click", () => {
      document
        .querySelectorAll(".variant-btn")
        .forEach((b) => b.classList.remove("active"));
      btn.classList.add("active");
      selectVariant(variant, modelName);
    });
    list.appendChild(btn);
  });
}

// Seleccionar variante --> carga servicios
async function selectVariant(variant, modelName) {
  const servicesSection = document.getElementById("servicesSection");
  servicesSection.style.display = "block";
  document.getElementById("servicesLabel").textContent =
    `Servicios disponibles · ${variant.nombre}`;

  const grid = document.getElementById("servicesGrid");
  grid.innerHTML = `
    <div class="skeleton" style="height:80px;"></div>
    <div class="skeleton" style="height:80px;"></div>
    <div class="skeleton" style="height:80px;"></div>
    <div class="skeleton" style="height:80px;"></div>
  `;

  setTimeout(
    () =>
      servicesSection.scrollIntoView({ behavior: "smooth", block: "start" }),
    100,
  );

  try {
    const res = await fetch(API.services(variant.id_variant));
    const services = await res.json();
    renderServices(services, variant.nombre);
  } catch {
    showError(grid, "Error al cargar los servicios.");
  }
}

// Render servicios — ahora con <a> real para SEO
function renderServices(services, variantName) {
  const grid = document.getElementById("servicesGrid");
  grid.innerHTML = "";

  if (!services.length) {
    grid.innerHTML =
      '<p class="services__empty">No hay servicios disponibles para esta variante.</p>';
    return;
  }

  services.forEach((service) => {
    // <a> con href real → Google puede rastrear la URL
    const item = document.createElement("a");
    item.className = "service-item";
    item.href = `${BASE_URL}/servicio/${slugify(service.variante)}/${slugify(service.titulo)}`;

    // Precio formateado
    const precioHTML =
      service.precio !== null
        ? `<div class="service-item__price">${parseInt(service.precio)} €</div>`
        : `<div class="service-item__price">Consultar</div>`;

    item.innerHTML = `
      <div style="display:flex;align-items:flex-start;gap:1rem;flex:1;">
        <div>
          <div class="service-item__name">${service.titulo}</div>
          ${
            service.descripcion
              ? `<div class="service-item__desc">${service.descripcion}</div>`
              : ""
          }
        </div>
      </div>
      ${precioHTML}
    `;

    grid.appendChild(item);
  });
}

// Init
async function init() {
  const grid = document.getElementById("modelsGrid");
  try {
    const res = await fetch(API.vehicles);
    const vehicles = await res.json();
    renderModels(vehicles);
  } catch {
    showError(grid, "Error al cargar los modelos.");
  }
}

init();
