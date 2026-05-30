<!doctype html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Pedidos — Panel Admin MBR</title>
  <link rel="icon" href="../img/mbr_logo_new.ico" type="image/x-icon"/>
  <link rel="stylesheet" href="../css/admin-panel_styles.css"/>
  <style>
    .orders-table { width:100%; border-collapse:collapse; font-size:.85rem; }
    .orders-table th {
      text-align:left; padding:.6rem .9rem;
      background:#141414; color:#8c8c8c;
      font-family:'JetBrains Mono',monospace; font-size:.72rem;
      text-transform:uppercase; letter-spacing:.06em;
      border-bottom:1px solid #262626;
    }
    .orders-table td {
      padding:.65rem .9rem; border-bottom:1px solid #1a1a1a;
      color:#d9d9d9; font-family:'DM Sans',sans-serif;
    }
    .orders-table tr:hover td { background:#141414; }
    .status-badge {
      display:inline-block; padding:.2rem .55rem;
      border-radius:100px; font-family:'JetBrains Mono',monospace;
      font-size:.68rem; text-transform:uppercase; letter-spacing:.06em;
    }
    .status-paid      { background:#14532d; color:#86efac; }
    .status-pending   { background:#78350f; color:#fcd34d; }
    .status-cancelled { background:#450a0a; color:#fca5a5; }
    .status-refunded  { background:#1e1b4b; color:#a5b4fc; }
    .pagination { display:flex; gap:.5rem; margin-top:1.5rem; }
    .pagination button {
      background:#262626; border:none; color:#d9d9d9;
      font-family:'JetBrains Mono',monospace; font-size:.78rem;
      padding:.4rem .9rem; border-radius:4px; cursor:pointer;
    }
    .pagination button.active,
    .pagination button:hover { background:#3b82f6; color:#fff; }
    .pagination button:disabled { opacity:.35; cursor:not-allowed; }
  </style>
</head>
<body>
  <div class="admin-layout">
    <nav class="admin-sidebar">
      <div class="admin-sidebar__brand">MBR Admin</div>
      <a href="admin_requests.php" class="admin-sidebar__link">Consultas</a>
      <a href="admin_orders.php"   class="admin-sidebar__link active">Pedidos</a>
      <a href="logout.php"         class="admin-sidebar__link admin-sidebar__link--danger">Cerrar sesión</a>
    </nav>

    <main class="admin-main">
      <div class="admin-header">
        <h1 class="admin-header__title">Pedidos</h1>
        <p class="admin-header__sub" id="orders-count">Cargando…</p>
      </div>

      <div class="admin-card" style="overflow-x:auto">
        <table class="orders-table" id="orders-table">
          <thead>
            <tr>
              <th>#</th>
              <th>Cliente</th>
              <th>Email</th>
              <th>Servicios</th>
              <th>Total</th>
              <th>Estado</th>
              <th>Fecha</th>
            </tr>
          </thead>
          <tbody id="orders-tbody">
            <tr><td colspan="7" style="text-align:center;color:#737373;padding:2rem">Cargando…</td></tr>
          </tbody>
        </table>
        <div class="pagination" id="pagination"></div>
      </div>
    </main>
  </div>

  <script>
    const fmt = (n) => Number(n).toLocaleString('es-ES', { style:'currency', currency:'EUR' });
    const statusLabel = { paid:'Pagado', pending:'Pendiente', cancelled:'Cancelado', refunded:'Reembolsado' };
    let currentPage = 1;

    async function loadOrders(page = 1) {
      const res  = await fetch(`admin_orders.php?page=${page}`, { credentials:'same-origin' });
      const data = await res.json();
      currentPage = page;

      document.getElementById('orders-count').textContent =
        `${data.total} pedido${data.total !== 1 ? 's' : ''} en total`;

      const tbody = document.getElementById('orders-tbody');
      if (!data.orders.length) {
        tbody.innerHTML = `<tr><td colspan="7" style="text-align:center;color:#737373;padding:2rem">Sin pedidos todavía.</td></tr>`;
        return;
      }

      tbody.innerHTML = data.orders.map(o => `
        <tr>
          <td style="font-family:'JetBrains Mono',monospace;color:#a6a6a6">${o.id_order}</td>
          <td>${o.customer_name}</td>
          <td style="font-family:'JetBrains Mono',monospace;font-size:.78rem">${o.customer_email}</td>
          <td style="color:#a6a6a6">${o.num_items} ítem${o.num_items !== 1 ? 's' : ''}</td>
          <td style="font-family:'JetBrains Mono',monospace">${fmt(o.total)}</td>
          <td><span class="status-badge status-${o.status}">${statusLabel[o.status] || o.status}</span></td>
          <td style="font-family:'JetBrains Mono',monospace;font-size:.75rem;color:#737373">
            ${new Date(o.created_at).toLocaleDateString('es-ES')}
          </td>
        </tr>
      `).join('');

      renderPagination(data.pages);
    }

    function renderPagination(pages) {
      const el = document.getElementById('pagination');
      if (pages <= 1) { el.innerHTML = ''; return; }
      let html = `<button onclick="loadOrders(${currentPage - 1})" ${currentPage === 1 ? 'disabled' : ''}>← Ant</button>`;
      for (let i = 1; i <= pages; i++) {
        html += `<button onclick="loadOrders(${i})" class="${i === currentPage ? 'active' : ''}">${i}</button>`;
      }
      html += `<button onclick="loadOrders(${currentPage + 1})" ${currentPage === pages ? 'disabled' : ''}>Sig →</button>`;
      el.innerHTML = html;
    }

    loadOrders();
  </script>
</body>
</html>
