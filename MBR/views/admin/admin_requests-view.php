<?php

/** @var string $busqueda */
/** @var array $consultas */
/** @var int $paginas */
/** @var int $pagina_actual */

?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>MBR - Consultas Recibidas</title>
    <link rel="icon" href="./img/mbr_logo_new.ico" type="image/x-icon" />
    <link rel="mask-icon" href="./img/mbr_logo_new.svg" color="#000000" />
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/admin-panel_styles.css" />
    <script>
        function confirmarBorrado(id) {
            if (confirm('¿Seguro que deseas borrar esta consulta?')) {
                window.location.href = '?borrar=' + id;
            }
        }
        function marcarLeido(id) {
            window.location.href = '?leido=' + id;
        }
    </script>
</head>

<body>
    <div class="container">
        <h1 id="titulo">Consultas Recibidas</h1>
        <form method="GET">
            <input type="text" name="buscar" placeholder="Buscar nombre, email, VIN..."
                value="<?= htmlspecialchars($busqueda, ENT_QUOTES, 'UTF-8') ?>">
            <button type="submit">Buscar</button>
            <a href="admin_requests.php" class="button">Limpiar</a>
            <a href="?buscar=<?= urlencode($busqueda) ?>&descargar=csv" class="button">Exportar a CSV</a>
            <a href="logout.php" class="button logout">Cerrar sesión</a>
        </form>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Email</th>
                    <th>Teléfono</th>
                    <th>Modelo</th>
                    <th>Mensaje</th>
                    <th>Fecha</th>
                    <th>Leido</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($consultas)): ?>
                    <?php foreach ($consultas as $r): ?>
                        <tr>
                            <td data-label="ID"><?= (int) $r['id_consulta'] ?></td>
                            <td data-label="Nombre"><?= htmlspecialchars($r['nombre'], ENT_QUOTES, 'UTF-8') ?></td>
                            <td data-label="Email"><?= htmlspecialchars($r['email'], ENT_QUOTES, 'UTF-8') ?></td>
                            <td data-label="Teléfono"><?= htmlspecialchars($r['telefono'], ENT_QUOTES, 'UTF-8') ?></td>
                            <td data-label="Modelo"><?= htmlspecialchars($r['modelo'], ENT_QUOTES, 'UTF-8') ?></td>
                            <td data-label="Mensaje"><?= nl2br(htmlspecialchars($r['mensaje'], ENT_QUOTES, 'UTF-8')) ?></td>
                            <td data-label="Fecha">
                                <small><?= htmlspecialchars($r['fecha'], ENT_QUOTES, 'UTF-8') ?></small>
                            </td>
                            <td data-label="Leido">
                                <?= htmlspecialchars($r['leido'] == 1 ? 'Sí' : 'No', ENT_QUOTES, 'UTF-8') ?>
                            </td>
                            <td data-label="Acciones">
                                <a href="javascript:marcarLeido(<?= (int) $r['id_consulta'] ?>)" class="make-read">Visto</a>
                                <a href="javascript:confirmarBorrado(<?= (int) $r['id_consulta'] ?>)" class="delete">Borrar</a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr>
                        <td colspan="12">No se encontraron resultados.</td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>

        <?php if ($paginas > 1): ?>
            <div class="pagination">
                <?php for ($i = 1; $i <= $paginas; $i++): ?>
                    <a href="?buscar=<?= urlencode($busqueda) ?>&p=<?= $i ?>"
                        class="<?= ($i == $pagina_actual) ? 'active' : '' ?>">
                        <?= $i ?>
                    </a>
                <?php endfor; ?>
            </div>
        <?php endif; ?>
    </div>
</body>

</html>