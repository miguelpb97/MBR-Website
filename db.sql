-- DESMARCA LA CASILLA "Habilite la revision de las claves foraneas"
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Tabla consultas
CREATE TABLE
    IF NOT EXISTS `consultas` (
        `id_consulta` INT NOT NULL AUTO_INCREMENT,
        `fecha` DATETIME NOT NULL DEFAULT current_timestamp(),
        `nombre` VARCHAR(50) NOT NULL,
        `email` VARCHAR(50) NOT NULL,
        `telefono` VARCHAR(20),
        `modelo` VARCHAR(75),
        `mensaje` TEXT NOT NULL,
        `leido` TINYINT (1) DEFAULT 0,
        PRIMARY KEY (`id_consulta`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- Tabla service
CREATE TABLE
    IF NOT EXISTS `service` (
        `id_service` INT NOT NULL AUTO_INCREMENT,
        `name` VARCHAR(80) NOT NULL,
        `description` TEXT NULL,
        `price` DECIMAL(10, 2) NULL,
        `image_url` VARCHAR(100) NULL,
        `stock` TINYINT (1) DEFAULT 0,
        PRIMARY KEY (`id_service`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- Tabla vehicle
CREATE TABLE
    IF NOT EXISTS `vehicle` (
        `id_vehicle` INT NOT NULL AUTO_INCREMENT,
        `name` VARCHAR(80) NOT NULL,
        `image_url` VARCHAR(100) NULL,
        PRIMARY KEY (`id_vehicle`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- Tabla variant
CREATE TABLE
    IF NOT EXISTS `variant` (
        `id_variant` INT NOT NULL AUTO_INCREMENT,
        `name` VARCHAR(80) NOT NULL,
        `image_url` VARCHAR(100) NULL,
        `vehicle_id` INT NOT NULL,
        PRIMARY KEY (`id_variant`),
        INDEX (`vehicle_id`),
        CONSTRAINT `fk_variant_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id_vehicle`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- Tabla variant_has_service
CREATE TABLE
    IF NOT EXISTS `variant_has_service` (
        `variant_id` INT NOT NULL,
        `service_id` INT NOT NULL,
        PRIMARY KEY (`variant_id`, `service_id`),
        INDEX (`service_id`),
        CONSTRAINT `fk_vhi_service` FOREIGN KEY (`service_id`) REFERENCES `service` (`id_service`),
        CONSTRAINT `fk_vhi_variant` FOREIGN KEY (`variant_id`) REFERENCES `variant` (`id_variant`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- Vehiculos (id_vehicle, name, image_url)
INSERT INTO
    `vehicle` (`id_vehicle`, `name`, `image_url`)
VALUES
    (1, 'Clase A', 'W177FL.png'),
    (2, 'Clase B', 'W247PF.png'),
    (3, 'Clase C', 'W205.png'),
    (4, 'Clase CLA', 'C118PF.png'),
    (5, 'Clase CLK', 'W209.png'),
    (6, 'Clase CLS', 'W218.png'),
    (7, 'Clase E', 'W213.png'),
    (8, 'Clase G', 'W463.png'),
    (9, 'Clase GLA', 'X157PF.png'),
    (10, 'Clase M', 'X164.png'),
    (11, 'Clase ML', 'W166.png'),
    (12, 'Clase R', 'W251.png'),
    (13, 'Clase S', 'W222.png'),
    (14, 'Clase SLK', 'R172.png'),
    (15, 'Clase SL', 'R231.png'),
    (16, 'Clase V', 'W447.png');

-- Variantes (id_variant, name, image_url, vehicle_id)
INSERT INTO
    `variant` (`id_variant`, `name`, `image_url`, `vehicle_id`)
VALUES
    (176, 'W176 Pre-facelift', 'W176PF.png', 1),
    (1762, 'W176 Facelift', 'W176FL.png', 1),
    (177, 'W177 Pre-facelift', 'W177PF.png', 1),
    (246, 'W246 Pre-facelift', 'W246PF.png', 2),
    (2462, 'W246 Facelift', 'W246FL.png', 2),
    (247, 'W247 Pre-facelift', 'W247PF.png', 2),
    (203, 'W203/S203', 'W203.png', 3),
    (204, 'W204/S204/X204', 'W204.png', 3),
    (2042, 'W204/S204/X204 Facelift', 'W204FL.png', 3),
    (205, 'W205/S205/X253', 'W205.png', 3),
    (117, 'C117/X117 Pre-facelift', 'C117PF.png', 4),
    (1172, 'C117/X117 Facelift', 'C117FL.png', 4),
    (118, 'C118/X118 Pre-facelift', 'C118PF.png', 4),
    (209, 'W209', 'W209.png', 5),
    (219, 'W219/C219', 'W219.png', 6),
    (218, 'W218/C218', 'W218.png', 6),
    (211, 'W211/S211', 'W211.png', 7),
    (212, 'W212/S212/A207/C207', 'W212.png', 7),
    (2122, 'W212 Facelift', 'W212FL.png', 7),
    (213, 'W213', 'W213.png', 7),
    (2132, 'W213 Facelift', 'W213FL.png', 7),
    (463, 'W463', 'W463.png', 8),
    (156, 'X156 Pre-facelift', 'X156PF.png', 9),
    (1562, 'X156 Facelift', 'X156FL.png', 9),
    (157, 'X157 Pre-facelift', 'X157PF.png', 9),
    (164, 'W164/X164', 'X164.png', 10),
    (166, 'W166/X166', 'W166.png', 11),
    (251, 'W251', 'W251.png', 12),
    (221, 'S221/W216', 'S221.png', 13),
    (222, 'S222/W217', 'W222.png', 13),
    (171, 'R171', 'R171.png', 14),
    (172, 'R172', 'R172.png', 14),
    (230, 'R230', 'R230.png', 15),
    (231, 'R231', 'R231.png', 15),
    (447, 'W447', 'W447.png', 16);

-- Servicios (id_service, name, descripcion, price, image_url, stock) 
INSERT INTO
    `service` (
        `id_service`,
        `name`,
        `description`,
        `price`,
        `image_url`,
        `stock`
    )
VALUES
    (
        1,
        'Coding Desactivar Start-Stop automático',
        'Mediante este coding, su vehículo no activará el Start/Stop automático cada vez que arranque. Lo hacemos mediante el método oficial, sin manipular cableado original ni añadir aparatos "bypass".',
        50.00,
        'service-img.png',
        1
    ),
    (
        2,
        'Coding Alarma perimetral EDW',
        'Te activamos la alarma perimetral EDW. Se activa cuando detecta la apertura de cualquier puerta del vehículo estando bloqueado. El 90% de los vehículos de la marca no incorporan este extra de serie.',
        50.00,
        'service-img.png',
        1
    ),
    (
        3,
        'Coding Visualizar presión neumáticos de kPa a bar',
        'Cambiamos la unidad de medición de la presión de los neumáticos en tu cuadro de instrumentos de kPa a bar.',
        30.00,
        'service-img.png',
        1
    ),
    (
        4,
        'Coding Pitido al bloquear el vehículo',
        'Breve pitido al bloquear el vehículo. Te activamos el menú para dicha función en el cuadro de instrumentos para activarla o desactivarla cuando lo desees.',
        30.00,
        'service-img.png',
        0
    ),
    (
        5,
        'Coding Sonido de parktronic en el rango amarillo',
        'Hacemos que tu parktronic avise acústicamente en el rango amarillo. (De serie solo "pita" en el rango rojo).',
        30.00,
        'service-img.png',
        0
    ),
    (
        6,
        'Coding Intermitentes 3 a 6 pulsaciones',
        'Al usar la función rápida del intermitente, en vez de 3 pulsaciones, hará 6 (valor personalizable).',
        30.00,
        'service-img.png',
        1
    ),
    (
        7,
        'Coding Desactivar aviso acústico del cinturón de seguridad',
        'Desactivamos el aviso acústico del cinturón de seguridad emitido por el cuadro de instrumentos (el aviso visual y acústico permanece activo).',
        30.00,
        'service-img.png',
        1
    ),
    (
        8,
        'Coding Test de agujas en cuadro de instrumentos',
        'Test de agujas en el cuadro de instrumentos al poner el contacto. Algunos vehículos no disponen de dicha función dependiendo del equipamiento y/o año.',
        30.00,
        'service-img.png',
        1
    ),
    (
        9,
        'Coding Aviso tapa combustible abierta',
        'Si inicia la marcha con la tapa de combustible abierta, se mostrará un aviso en el cuadro de instrumentos.',
        30.00,
        'service-img.png',
        1
    ),
    (
        10,
        'Deslimitar velocidad máxima (No AMG)',
        'Eliminamos la limitación electrónica de velocidad máxima de su vehículo.',
        100.00,
        'service-img.png',
        1
    ),
    (
        11,
        'Deslimitar velocidad máxima (AMG)',
        'Eliminamos la limitación electrónica de velocidad máxima de su vehículo AMG de 250 km/h.',
        100.00,
        'service-img.png',
        1
    ),
    (
        12,
        'Coding Emotion Start (AMG)',
        'Breves pops and bangs al arrancar, solo con el motor a temperatura de servicio.',
        70.00,
        'service-img.png',
        1
    ),
    (
        13,
        'Comprobar kilometraje real',
        '¿Dudas sobre si el kilometraje de su vehículo ha sido manipulado? Te ayudamos a descubrirlo.',
        50.00,
        'service-img.png',
        1
    ),
    (
        14,
        'Diagnóstico básico',
        'Lectura y/o borrado de fallos.',
        30.00,
        'service-img.png',
        1
    ),
    (
        15,
        'Diagnóstico avanzado',
        'Lectura y/o borrado de fallos, valores reales, test de componentes, etc.',
        NULL,
        'service-img.png',
        1
    ),
    (
        16,
        'Ayuda con Retrofit',
        'Te ayudamos con cualquier retrofit que requiera SCN Coding. El precio puede variar en función de la dificultad del mismo.',
        NULL,
        'service-img.png',
        1
    ),
    (
        17,
        'Retrofit NTG5.0, NTG5S1 o Garmin',
        'Si tu vehículo tiene NTG 4.5 o 4.7, te ayudamos a reequipar NTG5.0, NTG5S1 o Garmin.',
        NULL,
        'service-img.png',
        1
    ),
    (
        18,
        'Retrofit Cámara visión trasera original',
        'Reequipamos la cámara de visión trasera original, código SA 218.',
        NULL,
        'service-img.png',
        1
    ),
    (
        19,
        'Retrofit Espejos plegables eléctricamente',
        'Reequipamos el extra de espejos plegables eléctricamente, código SA 500.',
        NULL,
        'service-img.png',
        1
    ),
    (
        20,
        'Coding Activación de Apple CarPlay/Android Auto',
        'Activamos dicha función si tu unidad NTG es compatible.',
        50.00,
        'service-img.png',
        1
    ),
    (
        21,
        'Coding Alargar tiempo luces de bienvenida',
        'Alargamos la duración de dicha animación a 8 segundos (tiempo personalizable).',
        30.00,
        'service-img.png',
        1
    ),
    (
        22,
        'Coding Activar menú de luces ambiente en radio',
        'Si tu vehículo es compatible, activamos dicho menú en la unidad NTG y realizamos el coding requerido en la unidad SAM.',
        30.00,
        'service-img.png',
        1
    ),
    (
        23,
        'Retrofit Comand NTG5S1',
        'Si tu vehículo tiene NTG 5.0 o Garmin, te ayudamos a reequipar una unidad NTG5S1.',
        NULL,
        'service-img.png',
        1
    ),
    (
        24,
        'Coding Luces cortas al abrir el vehículo',
        'Al desbloquear el vehículo, se encenderán las luces cortas.',
        30.00,
        'service-img.png',
        0
    ),
    (
        26,
        'Coding Memoria de modo de conducción',
        'Con este coding, tu coche memorizará el último modo de conducción utilizado para el siguiente arranque, sin límite de tiempo (por defecto, memoriza durante 4 horas).',
        50.00,
        'service-img.png',
        1
    ),
    (
        27,
        'Coding Mostrar litros de combustible restantes',
        'El cuadro de instrumentos mostrará la cantidad de litros de combustible restantes en el depósito.',
        30.00,
        'service-img.png',
        1
    ),
    (
        28,
        'Coding Mostrar rango de km restantes',
        'Con esta activación siempre se mostrará el rango restante en km en lugar del icono de repostar.',
        30.00,
        'service-img.png',
        0
    ),
    (
        29,
        'Coding Cambio de volumen y frecuencia del parktronic',
        'Cambiamos el volumen y la frecuencia del aviso acústico del sistema Parktronic.',
        30.00,
        'service-img.png',
        1
    ),
    (
        30,
        'Coding Usar luces de niebla para los giros',
        'Al realizar giros, se encenderá la luz antiniebla correspondiente al lado del giro.',
        30.00,
        'service-img.png',
        0
    ),
    (
        31,
        'Coding Alargar tiempo retardo de apagado unidad radio',
        'Alargamos el tiempo que tarda la unidad en apagarse después de quitar el contacto.',
        30.00,
        'service-img.png',
        0
    ),
    (
        32,
        'Coding Permitir reproducción de vídeo en movimiento en la unidad radio',
        'Activamos la reproducción de vídeo en movimiento en tu unidad Comand.',
        30.00,
        'service-img.png',
        0
    ),
    (
        34,
        'Retrofit Aireadores con luces ambiente',
        'Retrofit de aireadores con luces ambiente a color personalizables desde una app para smartphone.',
        NULL,
        'service-img.png',
        1
    ),
    (
        35,
        'Retrofit Aireadores con luces ambiente',
        'Retrofit de aireadores con luces ambiente a color personalizables desde la unidad de radio NTG.',
        NULL,
        'service-img.png',
        1
    ),
    (
        36,
        'Retrofit Limpiaparabrisas automático',
        'Requiere cambio de sensor, incluido en el precio.',
        NULL,
        'service-img.png',
        1
    ),
    (
        38,
        'Coding Intermitente al realizar giro',
        'Al realizar un giro, se activa automáticamente el intermitente correspondiente en la dirección del giro.',
        30.00,
        'service-img.png',
        0
    ),
    (
        39,
        'Coding Luces largas automáticas IHC',
        'Si tu vehículo dispone de reconocimiento de señales de tráfico, podemos activar esta función adicionalmente si no dispone de ella.',
        70.00,
        'service-img.png',
        1
    ),
    (
        40,
        'Pack coding básico',
        'Pack de coding básico para modelos en los que la cantidad de servicios de coding es muy reducida.',
        150.00,
        'service-img.png',
        0
    ),
    (
        41,
        'Pack coding avanzado',
        'Pack de coding avanzado para modelos en los que la cantidad de servicios de coding es más amplia.',
        200.00,
        'service-img.png',
        0
    ),
    (
        42,
        'Coding Faros halógenos a bixenón',
        'Si vas a reequipar dichos faros, te ayudamos a codificarlos.',
        NULL,
        'service-img.png',
        1
    ),
    (
        43,
        'Coding Faros halógenos a LED',
        'Si vas a reequipar dichos faros, te ayudamos a codificarlos.',
        NULL,
        'service-img.png',
        1
    ),
    (
        44,
        'Coding Faros bixenón a LED',
        'Si vas a reequipar dichos faros, te ayudamos a codificarlos.',
        NULL,
        'service-img.png',
        1
    ),
    (
        45,
        'Coding A/C permanente',
        'Siempre que enciendas la climatización, se activará automáticamente el modo A/C.',
        30.00,
        'service-img.png',
        1
    ),
    (
        46,
        'Coding Recirculación de aire permanente',
        'Siempre que enciendas la climatización, se activará automáticamente la recirculación de aire.',
        30.00,
        'service-img.png',
        1
    ),
    (
        47,
        'Coding Luces traseras diurnas',
        'Con este coding, los faros traseros también se encenderán junto con las luces diurnas.',
        30.00,
        'service-img.png',
        1
    ),
    (
        48,
        'Coding Renovar cuadro de instrumentos',
        'Si has instalado un cuadro de instrumentos usado, te ayudamos a virginizarlo y emparejarlo con la EZS.',
        130.00,
        'service-img.png',
        1
    ),
    (
        49,
        'Coding Menú AMG en cuadro de instrumentos',
        'Codificamos el menú AMG en tu cuadro de instrumentos.',
        100.00,
        'service-img.png',
        1
    );

-- Relaciones entre servicios/items y variantes (variant_id, service_id)
-- W176 prefacelift
INSERT INTO
    `variant_has_service` (`variant_id`, `service_id`)
VALUES
    (176, 1),
    (176, 2),
    (176, 3),
    (176, 4),
    (176, 5),
    (176, 29),
    (176, 6),
    (176, 7),
    (176, 8),
    (176, 9),
    (176, 10),
    (176, 11),
    (176, 12),
    (176, 13),
    (176, 14),
    (176, 15),
    (176, 16),
    (176, 17),
    (176, 18),
    (176, 19),
    (176, 34),
    (176, 36),
    (176, 39),
    (176, 40),
    (176, 41),
    (176, 42),
    (176, 44),
    (176, 45),
    (176, 46),
    (176, 48),
    (176, 49),
    (176, 20);

-- W176 facelift
INSERT INTO
    `variant_has_service` (`variant_id`, `service_id`)
VALUES
    (1762, 1),
    (1762, 2),
    (1762, 3),
    (1762, 4),
    (1762, 5),
    (1762, 29),
    (1762, 6),
    (1762, 7),
    (1762, 8),
    (1762, 9),
    (1762, 10),
    (1762, 11),
    (1762, 12),
    (1762, 13),
    (1762, 14),
    (1762, 15),
    (1762, 16),
    (1762, 21),
    (1762, 23),
    (1762, 18),
    (1762, 19),
    (1762, 35),
    (1762, 36),
    (1762, 39),
    (1762, 40),
    (1762, 41),
    (1762, 43),
    (1762, 45),
    (1762, 46),
    (1762, 49),
    (1762, 20);

-- W177 prefacelift
INSERT INTO
    `variant_has_service`
VALUES
    (177, 1),
    (177, 2),
    (177, 3),
    (177, 24),
    (177, 26),
    (177, 6),
    (177, 7),
    (177, 9),
    (177, 10),
    (177, 11),
    (177, 13),
    (177, 14),
    (177, 15),
    (177, 16),
    (177, 39),
    (177, 40),
    (177, 41),
    (177, 48),
    (177, 49),
    (177, 20);

-- W246 prefacelift
INSERT INTO
    `variant_has_service`
VALUES
    (246, 1),
    (246, 2),
    (246, 3),
    (246, 4),
    (246, 5),
    (246, 29),
    (246, 6),
    (246, 7),
    (246, 8),
    (246, 9),
    (246, 10),
    (246, 13),
    (246, 14),
    (246, 15),
    (246, 16),
    (246, 17),
    (246, 18),
    (246, 19),
    (246, 36),
    (246, 39),
    (246, 40),
    (246, 41),
    (246, 42),
    (246, 44),
    (246, 45),
    (246, 46),
    (246, 48),
    (246, 49),
    (246, 20);

-- W246 facelift
INSERT INTO
    `variant_has_service`
VALUES
    (2462, 1),
    (2462, 2),
    (2462, 3),
    (2462, 4),
    (2462, 5),
    (2462, 29),
    (2462, 6),
    (2462, 7),
    (2462, 8),
    (2462, 9),
    (2462, 10),
    (2462, 13),
    (2462, 14),
    (2462, 15),
    (2462, 16),
    (2462, 23),
    (2462, 21),
    (2462, 18),
    (2462, 19),
    (2462, 36),
    (2462, 39),
    (2462, 40),
    (2462, 41),
    (2462, 43),
    (2462, 45),
    (2462, 46),
    (2462, 48),
    (2462, 49),
    (2462, 20);

-- W247 prefacelift
INSERT INTO
    `variant_has_service`
VALUES
    (247, 1),
    (247, 2),
    (247, 3),
    (247, 24),
    (247, 26),
    (247, 6),
    (247, 7),
    (247, 9),
    (247, 10),
    (247, 13),
    (247, 14),
    (247, 15),
    (247, 16),
    (247, 39),
    (247, 40),
    (247, 41);

-- W203/S203
INSERT INTO
    `variant_has_service`
VALUES
    (203, 7),
    (203, 27),
    (203, 28),
    (203, 10),
    (203, 11),
    (203, 29),
    (203, 30),
    (203, 31),
    (203, 32),
    (203, 48);

-- W204/S204/X204
INSERT INTO
    `variant_has_service`
VALUES
    (204, 1),
    (204, 7),
    (204, 27),
    (204, 28),
    (204, 10),
    (204, 11),
    (204, 29),
    (204, 30),
    (204, 31),
    (204, 32),
    (204, 48),
    (204, 49);

-- W204/S204/X204 Facelift
INSERT INTO
    `variant_has_service`
VALUES
    (2042, 1),
    (2042, 7),
    (2042, 27),
    (2042, 28),
    (2042, 10),
    (2042, 11),
    (2042, 29),
    (2042, 30),
    (2042, 31),
    (2042, 32),
    (2042, 33),
    (2042, 48),
    (2042, 49);

-- W205/S205/X253
INSERT INTO
    `variant_has_service`
VALUES
    (205, 1),
    (205, 2),
    (205, 20),
    (205, 3),
    (205, 6),
    (205, 7),
    (205, 27),
    (205, 28),
    (205, 10),
    (205, 11),
    (205, 29),
    (205, 30),
    (205, 31),
    (205, 32),
    (205, 33),
    (205, 39),
    (205, 40),
    (205, 41),
    (205, 48),
    (205, 49);

-- C117/X117 prefacelift
INSERT INTO
    `variant_has_service`
VALUES
    (117, 1),
    (117, 2),
    (117, 3),
    (117, 4),
    (117, 5),
    (117, 29),
    (117, 6),
    (117, 7),
    (117, 8),
    (117, 9),
    (117, 10),
    (117, 11),
    (117, 12),
    (117, 13),
    (117, 14),
    (117, 15),
    (117, 16),
    (117, 17),
    (117, 18),
    (117, 19),
    (117, 34),
    (117, 36),
    (117, 39),
    (117, 40),
    (117, 41),
    (117, 42),
    (117, 44),
    (117, 45),
    (117, 46),
    (117, 47),
    (117, 48),
    (117, 49),
    (117, 20);

-- C117/X117 facelift
INSERT INTO
    `variant_has_service`
VALUES
    (1172, 1),
    (1172, 2),
    (1172, 3),
    (1172, 4),
    (1172, 5),
    (1172, 29),
    (1172, 6),
    (1172, 7),
    (1172, 8),
    (1172, 9),
    (1172, 10),
    (1172, 11),
    (1172, 12),
    (1172, 13),
    (1172, 14),
    (1172, 15),
    (1172, 16),
    (1172, 23),
    (1172, 21),
    (1172, 18),
    (1172, 19),
    (1172, 35),
    (1172, 36),
    (1172, 39),
    (1172, 40),
    (1172, 41),
    (1172, 43),
    (1172, 45),
    (1172, 46),
    (1172, 47),
    (1172, 48),
    (1172, 49),
    (1172, 20);

-- C118 prefacelift
INSERT INTO
    `variant_has_service`
VALUES
    (118, 1),
    (118, 2),
    (118, 3),
    (118, 24),
    (118, 26),
    (118, 6),
    (118, 7),
    (118, 9),
    (118, 10),
    (118, 11),
    (118, 13),
    (118, 14),
    (118, 15),
    (118, 16),
    (118, 39),
    (118, 40),
    (118, 41),
    (118, 48),
    (118, 49);

-- W209 
INSERT INTO
    `variant_has_service`
VALUES
    (209, 7),
    (209, 27),
    (209, 28),
    (209, 10),
    (209, 11),
    (209, 29),
    (209, 30),
    (209, 31),
    (209, 32),
    (209, 13),
    (209, 14),
    (209, 15),
    (209, 16),
    (209, 48),
    (209, 49);

-- W219/C219
INSERT INTO
    `variant_has_service`
VALUES
    (219, 7),
    (219, 27),
    (219, 28),
    (219, 10),
    (219, 11),
    (219, 29),
    (219, 30),
    (219, 31),
    (219, 32),
    (219, 13),
    (219, 14),
    (219, 15),
    (219, 16),
    (219, 48),
    (219, 49);

-- W218/X218
INSERT INTO
    `variant_has_service`
VALUES
    (218, 7),
    (218, 27),
    (218, 28),
    (218, 10),
    (218, 11),
    (218, 29),
    (218, 30),
    (218, 31),
    (218, 32),
    (218, 13),
    (218, 14),
    (218, 15),
    (218, 16),
    (218, 48),
    (218, 49);

-- W211/S211
INSERT INTO
    `variant_has_service`
VALUES
    (211, 7),
    (211, 27),
    (211, 28),
    (211, 10),
    (211, 11),
    (211, 29),
    (211, 30),
    (211, 31),
    (211, 32),
    (211, 13),
    (211, 14),
    (211, 15),
    (211, 16);

-- W212/S212/A207/C207
INSERT INTO
    `variant_has_service`
VALUES
    (212, 1),
    (212, 2),
    (212, 3),
    (212, 5),
    (212, 6),
    (212, 7),
    (212, 10),
    (212, 11),
    (212, 14),
    (212, 15),
    (212, 16);

-- W212 Facelift
INSERT INTO
    `variant_has_service`
VALUES
    (2122, 1),
    (2122, 7),
    (2122, 27),
    (2122, 28),
    (2122, 10),
    (2122, 11),
    (2122, 13),
    (2122, 14),
    (2122, 15),
    (2122, 16);

-- W213 Pre-facelift
INSERT INTO
    `variant_has_service`
VALUES
    (213, 1),
    (213, 7),
    (213, 27),
    (213, 28),
    (213, 10),
    (213, 11),
    (213, 13),
    (213, 14),
    (213, 15),
    (213, 16),
    (213, 39),
    (213, 40),
    (213, 41),
    (213, 48),
    (213, 49);

-- W213 Facelift
INSERT INTO
    `variant_has_service`
VALUES
    (2132, 1),
    (2132, 7),
    (2132, 27),
    (2132, 28),
    (2132, 10),
    (2132, 11),
    (2132, 13),
    (2132, 14),
    (2132, 15),
    (2132, 16),
    (2132, 39),
    (2132, 40),
    (2132, 41),
    (2132, 48),
    (2132, 49);

-- W463
INSERT INTO
    `variant_has_service`
VALUES
    (463, 7),
    (463, 27),
    (463, 28),
    (463, 10),
    (463, 11),
    (463, 29),
    (463, 30),
    (463, 31),
    (463, 32),
    (463, 13),
    (463, 14),
    (463, 15),
    (463, 16);

-- X156 prefacelift 
INSERT INTO
    `variant_has_service`
VALUES
    (156, 1),
    (156, 2),
    (156, 3),
    (156, 4),
    (156, 5),
    (156, 29),
    (156, 6),
    (156, 7),
    (156, 8),
    (156, 9),
    (156, 10),
    (156, 11),
    (156, 12),
    (156, 13),
    (156, 14),
    (156, 15),
    (156, 16),
    (156, 17),
    (156, 18),
    (156, 19),
    (156, 34),
    (156, 36),
    (156, 39),
    (156, 40),
    (156, 41),
    (156, 42),
    (156, 44),
    (156, 45),
    (156, 46),
    (156, 48),
    (156, 49),
    (156, 20);

-- X156 facelift
INSERT INTO
    `variant_has_service`
VALUES
    (1562, 1),
    (1562, 2),
    (1562, 3),
    (1562, 4),
    (1562, 5),
    (1562, 29),
    (1562, 6),
    (1562, 7),
    (1562, 8),
    (1562, 9),
    (1562, 10),
    (1562, 11),
    (1562, 12),
    (1562, 13),
    (1562, 14),
    (1562, 15),
    (1562, 16),
    (1562, 21),
    (1562, 23),
    (1562, 18),
    (1562, 19),
    (1562, 35),
    (1562, 36),
    (1562, 39),
    (1562, 40),
    (1562, 41),
    (1562, 43),
    (1562, 45),
    (1562, 46),
    (1562, 48),
    (1562, 49),
    (1562, 20);

-- X157 prefacelift
INSERT INTO
    `variant_has_service`
VALUES
    (157, 1),
    (157, 2),
    (157, 3),
    (157, 24),
    (157, 26),
    (157, 6),
    (157, 9),
    (157, 10),
    (157, 11),
    (157, 13),
    (157, 14),
    (157, 15),
    (157, 16),
    (157, 40),
    (157, 41),
    (157, 48),
    (157, 49);

-- W164/X164
INSERT INTO
    `variant_has_service`
VALUES
    (164, 7),
    (164, 27),
    (164, 28),
    (164, 10),
    (164, 11),
    (164, 29),
    (164, 30),
    (164, 31),
    (164, 32),
    (164, 13),
    (164, 14),
    (164, 15),
    (164, 16);

-- W166/X166
INSERT INTO
    `variant_has_service`
VALUES
    (166, 7),
    (166, 27),
    (166, 28),
    (166, 10),
    (166, 11),
    (166, 29),
    (166, 30),
    (166, 31),
    (166, 32),
    (166, 13),
    (166, 14),
    (166, 15),
    (166, 16),
    (166, 48),
    (166, 49);

-- W251
INSERT INTO
    `variant_has_service`
VALUES
    (251, 7),
    (251, 27),
    (251, 28),
    (251, 10),
    (251, 11),
    (251, 29),
    (251, 30),
    (251, 31),
    (251, 32),
    (251, 13),
    (251, 14),
    (251, 15),
    (251, 16);

-- S221/W216
INSERT INTO
    `variant_has_service`
VALUES
    (221, 7),
    (221, 27),
    (221, 28),
    (221, 10),
    (221, 11),
    (221, 29),
    (221, 30),
    (221, 31),
    (221, 32),
    (221, 13),
    (221, 14),
    (221, 15),
    (221, 16);

-- S222/W217
INSERT INTO
    `variant_has_service`
VALUES
    (222, 1),
    (222, 7),
    (222, 27),
    (222, 28),
    (222, 10),
    (222, 11),
    (222, 13),
    (222, 14),
    (222, 15),
    (222, 16),
    (222, 48),
    (222, 49);

-- R171
INSERT INTO
    `variant_has_service`
VALUES
    (171, 7),
    (171, 27),
    (171, 28),
    (171, 10),
    (171, 11),
    (171, 29),
    (171, 30),
    (171, 31),
    (171, 32),
    (171, 13),
    (171, 14),
    (171, 15),
    (171, 16);

-- R172
INSERT INTO
    `variant_has_service`
VALUES
    (172, 1),
    (172, 7),
    (172, 27),
    (172, 10),
    (172, 11),
    (172, 38),
    (172, 2),
    (172, 31),
    (172, 32),
    (172, 5),
    (172, 13),
    (172, 14),
    (172, 15),
    (172, 16),
    (172, 48),
    (172, 49);

-- R230
INSERT INTO
    `variant_has_service`
VALUES
    (230, 7),
    (230, 27),
    (230, 28),
    (230, 10),
    (230, 11),
    (230, 29),
    (230, 30),
    (230, 31),
    (230, 32),
    (230, 13),
    (230, 14),
    (230, 15),
    (230, 16);

-- R231
INSERT INTO
    `variant_has_service`
VALUES
    (231, 1),
    (231, 7),
    (231, 27),
    (231, 10),
    (231, 11),
    (231, 38),
    (231, 2),
    (231, 31),
    (231, 32),
    (231, 5),
    (231, 13),
    (231, 14),
    (231, 15),
    (231, 16),
    (231, 48),
    (231, 49);

-- W447
INSERT INTO
    `variant_has_service`
VALUES
    (447, 1),
    (447, 2),
    (447, 7),
    (447, 27),
    (447, 3),
    (447, 10),
    (447, 11),
    (447, 13),
    (447, 14),
    (447, 15),
    (447, 16),
    (447, 48),
    (447, 49);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;