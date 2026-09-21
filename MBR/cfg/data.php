<?php
require_once __DIR__ . '/config.php';

function cargarModelos(string $lang): array
{
    $pdo = getDB();

    $sql = "
        SELECT 
            v.id_vehicle,
            COALESCE(vt.name, v.name) AS nombre,
            v.image_url AS imagen
        FROM vehicle v
        LEFT JOIN vehicle_translation vt ON vt.id_vehicle = v.id_vehicle AND vt.lang = ?
        ORDER BY nombre
    ";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([$lang]);
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

function cargarServicios(int $id_variant, string $lang): array
{
    $pdo = getDB();

    $sql = "
        SELECT 
            s.id_service AS id,
            COALESCE(st.name, s.name) AS titulo,
            s.name AS titulo_es,
            s.price AS precio,
            v.name AS variante
        FROM variant_has_service vhs
        JOIN service s ON s.id_service = vhs.service_id
        JOIN variant v ON v.id_variant = vhs.variant_id
        LEFT JOIN service_translation st ON st.id_service = s.id_service AND st.lang = ?
        WHERE vhs.variant_id = ? AND s.stock = 1
        ORDER BY titulo
    ";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([$lang, $id_variant]);
    $rows = $stmt->fetchAll();

    foreach ($rows as &$row) {
        $row['precio'] = $row['precio'] !== null ? (float) $row['precio'] : null;
        $row['slug'] = slugify($row['titulo_es']); // SIEMPRE del español, nunca de $lang
        unset($row['titulo_es']);
    }

    return $rows;
}

function buscarServicioPorSlug(string $slug_variante, string $slug_servicio, string $lang): ?array
{
    $pdo = getDB();

    $stmt = $pdo->prepare("
        SELECT
            s.id_service  AS id,
            COALESCE(st.name, s.name) AS titulo,
            COALESCE(st.description, s.description) AS descripcion,
            s.name        AS titulo_es,
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
        LEFT JOIN service_translation st ON st.id_service = s.id_service AND st.lang = ?
        WHERE s.stock = 1
        ORDER BY s.name ASC
    ");
    $stmt->execute([$lang]);
    $rows = $stmt->fetchAll();

    foreach ($rows as $row) {
        if (slugify($row['variante']) === $slug_variante && slugify($row['titulo_es']) === $slug_servicio) {
            $row['precio'] = $row['precio'] !== null ? (float) $row['precio'] : null;
            // OJO: ya NO se hace unset — lo necesitamos en servicio-view.php para el canónico
            return $row;
        }
    }

    return null;
}

function cargarModelo(int $id, string $lang): ?array
{
    $pdo = getDB();

    $stmt = $pdo->prepare("
        SELECT 
            v.id_vehicle,
            COALESCE(vt.name, v.name) AS nombre,
            v.image_url AS imagen
        FROM vehicle v
        LEFT JOIN vehicle_translation vt ON vt.id_vehicle = v.id_vehicle AND vt.lang = ?
        WHERE v.id_vehicle = ?
        LIMIT 1
    ");
    $stmt->execute([$lang, $id]);
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
        WHERE id_variant = ? AND visible = 1
        ORDER BY id
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

function cargarServicio(int $id, string $lang): ?array
{
    $pdo = getDB();

    $stmt = $pdo->prepare("
        SELECT 
            s.id_service,
            COALESCE(st.name, s.name) AS titulo,
            COALESCE(st.description, s.description) AS descripcion,
            s.price AS precio,
            s.image_url AS imagen,
            v.name AS modelo,
            va.name AS variante
        FROM service s
        LEFT JOIN variant_has_service vhs ON vhs.service_id = s.id_service
        LEFT JOIN variant va ON va.id_variant = vhs.variant_id
        LEFT JOIN vehicle v ON v.id_vehicle = va.vehicle_id
        LEFT JOIN service_translation st ON st.id_service = s.id_service AND st.lang = ?
        WHERE s.id_service = ?
        LIMIT 1
    ");
    $stmt->execute([$lang, $id]);
    $row = $stmt->fetch();

    if (!$row) return null;

    $row['precio'] = $row['precio'] !== null ? (float) $row['precio'] : null;

    return $row;
}

function cargarCompatibilidad(int $id_service, string $lang): array
{
    $pdo = getDB();

    $stmt = $pdo->prepare("
        SELECT
            vh.id_vehicle,
            COALESCE(vht.name, vh.name) AS modelo,
            v.id_variant,
            v.name AS variante
        FROM variant_has_service vhs
        JOIN variant v  ON v.id_variant = vhs.variant_id
        JOIN vehicle vh ON vh.id_vehicle = v.vehicle_id
        LEFT JOIN vehicle_translation vht ON vht.id_vehicle = vh.id_vehicle AND vht.lang = ?
        WHERE vhs.service_id = ?
        ORDER BY modelo ASC, v.name ASC
    ");
    $stmt->execute([$lang, $id_service]);
    $rows = $stmt->fetchAll();

    $agrupado = [];
    foreach ($rows as $row) {
        $agrupado[$row['modelo']][] = $row['variante'];
    }

    return $agrupado;
}

function slugify(string $text): string
{
    if (class_exists('Normalizer')) {
        // Descompone (Ö -> O + diéresis combinante) y elimina las marcas diacríticas
        $text = Normalizer::normalize($text, Normalizer::FORM_D);
        $text = preg_replace('/\p{Mn}/u', '', $text);
    } else {
        // Fallback manual si no está la extensión intl, ampliado a ES/DE/FR/IT
        $map = [
            'á' => 'a',
            'é' => 'e',
            'í' => 'i',
            'ó' => 'o',
            'ú' => 'u',
            'Á' => 'a',
            'É' => 'e',
            'Í' => 'i',
            'Ó' => 'o',
            'Ú' => 'u',
            'ñ' => 'n',
            'Ñ' => 'n',
            'ü' => 'u',
            'Ü' => 'u',
            'ç' => 'c',
            'Ç' => 'c',
            'ä' => 'a',
            'Ä' => 'a',
            'ö' => 'o',
            'Ö' => 'o',
            'ß' => 'ss',
            'à' => 'a',
            'â' => 'a',
            'è' => 'e',
            'ê' => 'e',
            'ë' => 'e',
            'î' => 'i',
            'ï' => 'i',
            'ô' => 'o',
            'ù' => 'u',
            'û' => 'u',
            'œ' => 'oe',
        ];
        $text = strtr($text, $map);
    }

    $text = strtolower($text);
    $text = preg_replace('/[^a-z0-9]+/', '-', $text);
    $text = trim($text, '-');

    return $text !== '' ? $text : 'servicio';
}
