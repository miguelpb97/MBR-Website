<?php
require_once __DIR__ . '/config.php';

function getDB(): PDO {
    static $pdo = null;
    if ($pdo === null) {
        try {
            $pdo = new PDO(
                'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4',
                DB_USER,
                DB_PASS,
                [
                    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES   => false,
                ]
            );
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(['error' => $e->getMessage()]);
            exit;
        }
    }
    return $pdo;
}

function cargarModelos(): array
{
    $pdo = getDB();

    $sql = "SELECT id_vehicle, name AS nombre, image_url AS imagen 
            FROM vehicle 
            ORDER BY name";

    $stmt = $pdo->query($sql);
    $rows = $stmt->fetchAll();

    $modelos = [];
    foreach ($rows as $row) {
        $modelos[$row['id_vehicle']] = [
            'id_vehicle' => $row['id_vehicle'],
            'nombre' => $row['nombre'],
            'imagen' => $row['imagen']
        ];
    }

    return $modelos;
}

function cargarVariantes(int $id_vehicle): array
{
    $pdo = getDB();

    $sql = "SELECT id_variant, name AS nombre, image_url AS imagen
            FROM variant
            WHERE vehicle_id = ?
            ORDER BY id_variant";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([$id_vehicle]);
    $rows = $stmt->fetchAll();

    $variantes = [];
    foreach ($rows as $row) {
        $variantes[$row['id_variant']] = [
            'id_variant' => $row['id_variant'],
            'nombre' => $row['nombre'],
            'imagen' => $row['imagen']
        ];
    }

    return $variantes;
}

function cargarServicios(int $id_variant): array
{
    $pdo = getDB();

    $stmt = $pdo->prepare("
        SELECT 
            s.id_service AS id,
            s.name AS titulo,
            s.price AS precio,
            v.name AS variante
        FROM variant_has_service vhs
        JOIN service s ON s.id_service = vhs.service_id
        JOIN variant v ON v.id_variant = vhs.variant_id
        WHERE vhs.variant_id = ? AND s.stock = 1
        ORDER BY s.name
    ");
    $stmt->execute([$id_variant]);
    $rows = $stmt->fetchAll();

    foreach ($rows as &$row) {
        $row['precio'] = $row['precio'] !== null ? (float) $row['precio'] : null;
    }

    return $rows;
}

function cargarModelo(int $id): ?array
{
    $pdo = getDB();

    $stmt = $pdo->prepare("
        SELECT id_vehicle, name AS nombre, image_url AS imagen
        FROM vehicle
        WHERE id_vehicle = ?
        LIMIT 1
    ");
    $stmt->execute([$id]);
    $row = $stmt->fetch();

    if (!$row) return null;

    return [
        'id' => $row['id_vehicle'],
        'nombre' => $row['nombre'],
        'imagen' => $row['imagen']
    ];
}

function cargarVariante(int $id_variant): ?array
{
    $pdo = getDB();

    $stmt = $pdo->prepare("
        SELECT id_variant, name AS nombre, image_url AS imagen, vehicle_id
        FROM variant
        WHERE id_variant = ?
        LIMIT 1
    ");
    $stmt->execute([$id_variant]);
    $row = $stmt->fetch();

    if (!$row) return null;

    return [
        'id' => $row['id_variant'],
        'nombre' => $row['nombre'],
        'imagen' => $row['imagen'],
        'id_vehicle' => $row['vehicle_id']
    ];
}

function cargarServicio(int $id): ?array
{
    $pdo = getDB();

    $stmt = $pdo->prepare("
        SELECT 
            s.id_service,
            s.name AS titulo,
            s.description AS descripcion,
            s.price AS precio,
            s.image_url AS imagen,
            v.name AS modelo,
            va.name AS variante
        FROM service s
        LEFT JOIN variant_has_service vhs ON vhs.service_id = s.id_service
        LEFT JOIN variant va ON va.id_variant = vhs.variant_id
        LEFT JOIN vehicle v ON v.id_vehicle = va.vehicle_id
        WHERE s.id_service = ?
        LIMIT 1
    ");
    $stmt->execute([$id]);
    $row = $stmt->fetch();

    if (!$row) return null;

    $row['precio'] = $row['precio'] !== null ? (float) $row['precio'] : null;

    return $row;
}

function cargarCompatibilidad(int $id_service): array
{
    $pdo = getDB();

    $stmt = $pdo->prepare("
        SELECT
            vh.id_vehicle,
            vh.name AS modelo,
            v.id_variant,
            v.name AS variante
        FROM variant_has_service vhs
        JOIN variant v  ON v.id_variant = vhs.variant_id
        JOIN vehicle vh ON vh.id_vehicle = v.vehicle_id
        WHERE vhs.service_id = ?
        ORDER BY vh.name ASC, v.name ASC
    ");
    $stmt->execute([$id_service]);
    $rows = $stmt->fetchAll();

    // Agrupa variantes por modelo: ['Clase A' => ['W176', 'W177'], ...]
    $agrupado = [];
    foreach ($rows as $row) {
        $agrupado[$row['modelo']][] = $row['variante'];
    }

    return $agrupado;
}

function slugify(string $text): string
{
    // Sustitución manual de acentos y caracteres especiales (sin depender de iconv/locale)
    $map = [
        'á' => 'a', 'é' => 'e', 'í' => 'i', 'ó' => 'o', 'ú' => 'u',
        'Á' => 'a', 'É' => 'e', 'Í' => 'i', 'Ó' => 'o', 'Ú' => 'u',
        'ñ' => 'n', 'Ñ' => 'n',
        'ü' => 'u', 'Ü' => 'u',
        'ç' => 'c', 'Ç' => 'c',
    ];

    $text = strtr($text, $map);
    $text = strtolower($text);
    $text = preg_replace('/[^a-z0-9]+/', '-', $text);
    $text = trim($text, '-');

    return $text !== '' ? $text : 'servicio';
}

function buscarServicioPorSlug(string $slug_variante, string $slug_servicio): ?array
{
    $pdo = getDB();

    $stmt = $pdo->prepare("
        SELECT
            s.id_service  AS id,
            s.name        AS titulo,
            s.description AS descripcion,
            s.price       AS precio,
            s.image_url   AS imagen,
            v.id_variant  AS id_variante,
            v.name        AS variante,
            vh.id_vehicle AS id_modelo,
            vh.name       AS modelo
        FROM service s
        JOIN variant_has_service vhs ON vhs.service_id = s.id_service
        JOIN variant             v   ON v.id_variant   = vhs.variant_id
        JOIN vehicle             vh  ON vh.id_vehicle  = v.vehicle_id
        WHERE s.stock = 1
        ORDER BY s.name ASC
    ");
    $stmt->execute();
    $rows = $stmt->fetchAll();

    foreach ($rows as $row) {
        if (slugify($row['variante']) === $slug_variante && slugify($row['titulo']) === $slug_servicio) {
            $row['precio'] = $row['precio'] !== null ? (float) $row['precio'] : null;
            return $row;
        }
    }

    return null;
}
