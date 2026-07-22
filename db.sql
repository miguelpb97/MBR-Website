-- DESMARCA LA CASILLA "Habilite la revision de las claves foraneas"
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

-- Traducciones de vehículos (Clase A, Clase C...)
CREATE TABLE
    IF NOT EXISTS `vehicle_translation` (
        `id_vehicle` INT NOT NULL,
        `lang` VARCHAR(5) NOT NULL,
        `name` VARCHAR(80) NOT NULL,
        PRIMARY KEY (`id_vehicle`, `lang`),
        CONSTRAINT `fk_vt_vehicle` FOREIGN KEY (`id_vehicle`) REFERENCES `vehicle` (`id_vehicle`) ON DELETE CASCADE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

INSERT INTO
    vehicle_translation (id_vehicle, lang, name)
SELECT
    id_vehicle,
    'es',
    name
FROM
    vehicle;

-- Traducciones de servicios (nombre + descripción)
CREATE TABLE
    IF NOT EXISTS `service_translation` (
        `id_service` INT NOT NULL,
        `lang` VARCHAR(5) NOT NULL,
        `name` VARCHAR(150) NOT NULL,
        `description` TEXT NULL,
        PRIMARY KEY (`id_service`, `lang`),
        CONSTRAINT `fk_st_service` FOREIGN KEY (`id_service`) REFERENCES `service` (`id_service`) ON DELETE CASCADE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

INSERT INTO
    service_translation (id_service, lang, name, description)
SELECT
    id_service,
    'es',
    name,
    description
FROM
    service;

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

-- Vehiculos translation
INSERT INTO
    vehicle_translation (id_vehicle, lang, name)
VALUES
    -- Clase A
    (1, 'en', 'A-Class'),
    (1, 'de', 'A-Klasse'),
    (1, 'fr', 'Classe A'),
    (1, 'it', 'Classe A'),
    -- Clase B
    (2, 'en', 'B-Class'),
    (2, 'de', 'B-Klasse'),
    (2, 'fr', 'Classe B'),
    (2, 'it', 'Classe B'),
    -- Clase C
    (3, 'en', 'C-Class'),
    (3, 'de', 'C-Klasse'),
    (3, 'fr', 'Classe C'),
    (3, 'it', 'Classe C'),
    -- Clase CLA
    (4, 'en', 'CLA-Class'),
    (4, 'de', 'CLA-Klasse'),
    (4, 'fr', 'Classe CLA'),
    (4, 'it', 'Classe CLA'),
    -- Clase CLK
    (5, 'en', 'CLK-Class'),
    (5, 'de', 'CLK-Klasse'),
    (5, 'fr', 'Classe CLK'),
    (5, 'it', 'Classe CLK'),
    -- Clase CLS
    (6, 'en', 'CLS-Class'),
    (6, 'de', 'CLS-Klasse'),
    (6, 'fr', 'Classe CLS'),
    (6, 'it', 'Classe CLS'),
    -- Clase E
    (7, 'en', 'E-Class'),
    (7, 'de', 'E-Klasse'),
    (7, 'fr', 'Classe E'),
    (7, 'it', 'Classe E'),
    -- Clase G
    (8, 'en', 'G-Class'),
    (8, 'de', 'G-Klasse'),
    (8, 'fr', 'Classe G'),
    (8, 'it', 'Classe G'),
    -- Clase GLA
    (9, 'en', 'GLA-Class'),
    (9, 'de', 'GLA-Klasse'),
    (9, 'fr', 'Classe GLA'),
    (9, 'it', 'Classe GLA'),
    -- Clase M
    (10, 'en', 'M-Class'),
    (10, 'de', 'M-Klasse'),
    (10, 'fr', 'Classe M'),
    (10, 'it', 'Classe M'),
    -- Clase ML
    (11, 'en', 'ML-Class'),
    (11, 'de', 'ML-Klasse'),
    (11, 'fr', 'Classe ML'),
    (11, 'it', 'Classe ML'),
    -- Clase R
    (12, 'en', 'R-Class'),
    (12, 'de', 'R-Klasse'),
    (12, 'fr', 'Classe R'),
    (12, 'it', 'Classe R'),
    -- Clase S
    (13, 'en', 'S-Class'),
    (13, 'de', 'S-Klasse'),
    (13, 'fr', 'Classe S'),
    (13, 'it', 'Classe S'),
    -- Clase SLK
    (14, 'en', 'SLK-Class'),
    (14, 'de', 'SLK-Klasse'),
    (14, 'fr', 'Classe SLK'),
    (14, 'it', 'Classe SLK'),
    -- Clase SL
    (15, 'en', 'SL-Class'),
    (15, 'de', 'SL-Klasse'),
    (15, 'fr', 'Classe SL'),
    (15, 'it', 'Classe SL'),
    -- Clase V
    (16, 'en', 'V-Class'),
    (16, 'de', 'V-Klasse'),
    (16, 'fr', 'Classe V'),
    (16, 'it', 'Classe V');

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
        0
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

-- Servicios ENGLISH
INSERT INTO
    service_translation (id_service, lang, name, description)
VALUES
    (
        1,
        'en',
        'Coding Disable Automatic Start-Stop',
        'With this coding, your vehicle will no longer activate the automatic Start/Stop system every time you start the engine. We do this using the official method, without tampering with the original wiring or adding ''bypass'' devices.'
    ),
    (
        2,
        'en',
        'Coding EDW Perimeter Alarm',
        'We activate the EDW perimeter alarm for you. It triggers when it detects any door being opened while the vehicle is locked. 90% of the brand''s vehicles don''t include this extra as standard.'
    ),
    (
        3,
        'en',
        'Coding Tyre Pressure Display kPa to bar',
        'We change the tyre pressure measurement unit on your instrument cluster from kPa to bar.'
    ),
    (
        4,
        'en',
        'Coding Beep on Locking the Vehicle',
        'A brief beep when locking the vehicle. We activate the menu for this function in the instrument cluster so you can turn it on or off whenever you want.'
    ),
    (
        5,
        'en',
        'Coding Parktronic Sound in the Yellow Range',
        'We make your Parktronic system give an acoustic warning in the yellow range too. (By default it only beeps in the red range).'
    ),
    (
        6,
        'en',
        'Coding Turn Signal 3 to 6 Flashes',
        'When using the quick-flash turn signal function, instead of 3 flashes it will do 6 (customisable value).'
    ),
    (
        7,
        'en',
        'Coding Disable Seatbelt Acoustic Warning',
        'We disable the seatbelt acoustic warning emitted by the instrument cluster (the visual and acoustic warning remains active).'
    ),
    (
        8,
        'en',
        'Coding Needle Sweep Test on Instrument Cluster',
        'Needle sweep test on the instrument cluster when switching on the ignition. Some vehicles don''t have this function depending on equipment and/or year.'
    ),
    (
        9,
        'en',
        'Coding Fuel Cap Open Warning',
        'If you start driving with the fuel cap open, a warning will be shown on the instrument cluster.'
    ),
    (
        10,
        'en',
        'Top Speed Delimitation (Non-AMG)',
        'We remove the electronic top speed limiter from your vehicle.'
    ),
    (
        11,
        'en',
        'Top Speed Delimitation (AMG)',
        'We remove the 250 km/h electronic top speed limiter from your AMG vehicle.'
    ),
    (
        12,
        'en',
        'Coding Emotion Start (AMG)',
        'Brief pops and bangs on start-up, only when the engine is at operating temperature.'
    ),
    (
        13,
        'en',
        'Check Real Mileage',
        'Not sure if your vehicle''s mileage has been tampered with? We help you find out.'
    ),
    (
        14,
        'en',
        'Basic Diagnostics',
        'Fault code reading and/or clearing.'
    ),
    (
        15,
        'en',
        'Advanced Diagnostics',
        'Fault code reading and/or clearing, live data values, component tests, etc.'
    ),
    (
        16,
        'en',
        'Retrofit Assistance',
        'We help you with any retrofit that requires SCN Coding. The price may vary depending on its difficulty.'
    ),
    (
        17,
        'en',
        'Retrofit NTG5.0, NTG5S1 or Garmin',
        'If your vehicle has NTG 4.5 or 4.7, we help you retrofit NTG5.0, NTG5S1 or Garmin.'
    ),
    (
        18,
        'en',
        'Retrofit Original Rear View Camera',
        'We retrofit the original rear view camera, code SA 218.'
    ),
    (
        19,
        'en',
        'Retrofit Electrically Folding Mirrors',
        'We retrofit the electrically folding mirrors extra, code SA 500.'
    ),
    (
        20,
        'en',
        'Coding Apple CarPlay/Android Auto Activation',
        'We activate this function if your NTG unit is compatible.'
    ),
    (
        21,
        'en',
        'Coding Extend Welcome Lights Duration',
        'We extend the duration of this animation to 8 seconds (customisable time).'
    ),
    (
        22,
        'en',
        'Coding Activate Ambient Light Menu in Radio Unit',
        'If your vehicle is compatible, we activate this menu on the NTG unit and perform the required coding on the SAM unit.'
    ),
    (
        23,
        'en',
        'Retrofit Comand NTG5S1',
        'If your vehicle has NTG 5.0 or Garmin, we help you retrofit an NTG5S1 unit.'
    ),
    (
        24,
        'en',
        'Coding Low Beam Lights on Unlocking',
        'When you unlock the vehicle, the low beam lights will switch on.'
    ),
    (
        26,
        'en',
        'Coding Driving Mode Memory',
        'With this coding, your car will remember the last driving mode used for the next start-up, with no time limit (by default it only remembers for 4 hours).'
    ),
    (
        27,
        'en',
        'Coding Show Remaining Fuel in Litres',
        'The instrument cluster will show the amount of fuel remaining in the tank, in litres.'
    ),
    (
        28,
        'en',
        'Coding Show Remaining Range in km',
        'With this activation, the remaining range in km will always be shown instead of the refuel icon.'
    ),
    (
        29,
        'en',
        'Coding Parktronic Volume and Frequency Adjustment',
        'We change the volume and frequency of the acoustic warning of the Parktronic system.'
    ),
    (
        30,
        'en',
        'Coding Fog Lights as Cornering Lights',
        'When turning, the fog light on the corresponding side of the turn will switch on.'
    ),
    (
        31,
        'en',
        'Coding Extend Radio Unit Shutdown Delay',
        'We extend the time it takes for the unit to switch off after turning off the ignition.'
    ),
    (
        32,
        'en',
        'Coding Enable Video Playback While Driving',
        'We enable video playback while the vehicle is moving on your Comand unit.'
    ),
    (
        34,
        'en',
        'Retrofit Ambient Light Air Vents',
        'Retrofit of ambient light air vents with colours customisable from a smartphone app.'
    ),
    (
        35,
        'en',
        'Retrofit Ambient Light Air Vents',
        'Retrofit of ambient light air vents with colours customisable from the NTG radio unit.'
    ),
    (
        36,
        'en',
        'Retrofit Automatic Windscreen Wipers',
        'Requires sensor replacement, included in the price.'
    ),
    (
        38,
        'en',
        'Coding Automatic Turn Signal on Steering',
        'When turning the steering wheel, the corresponding turn signal activates automatically in the direction of the turn.'
    ),
    (
        39,
        'en',
        'Coding Automatic High Beam IHC',
        'If your vehicle has traffic sign recognition, we can additionally activate this function if it doesn''t already have it.'
    ),
    (
        40,
        'en',
        'Basic Coding Pack',
        'Basic coding pack for models where the number of available coding services is very limited.'
    ),
    (
        41,
        'en',
        'Advanced Coding Pack',
        'Advanced coding pack for models where the number of available coding services is wider.'
    ),
    (
        42,
        'en',
        'Coding Halogen to Bi-Xenon Headlights',
        'If you''re retrofitting these headlights, we help you code them.'
    ),
    (
        43,
        'en',
        'Coding Halogen to LED Headlights',
        'If you''re retrofitting these headlights, we help you code them.'
    ),
    (
        44,
        'en',
        'Coding Bi-Xenon to LED Headlights',
        'If you''re retrofitting these headlights, we help you code them.'
    ),
    (
        45,
        'en',
        'Coding Permanent A/C',
        'Whenever you turn on the climate control, A/C mode will activate automatically.'
    ),
    (
        46,
        'en',
        'Coding Permanent Air Recirculation',
        'Whenever you turn on the climate control, air recirculation will activate automatically.'
    ),
    (
        47,
        'en',
        'Coding Rear Daytime Running Lights',
        'With this coding, the rear lights will also switch on together with the daytime running lights.'
    ),
    (
        48,
        'en',
        'Coding Instrument Cluster Renewal',
        'If you''ve installed a used instrument cluster, we help you reset it to virgin state and pair it with the EZS.'
    ),
    (
        49,
        'en',
        'Coding AMG Menu in Instrument Cluster',
        'We code the AMG menu into your instrument cluster.'
    );

-- Servicios DEUTSCH
INSERT INTO
    service_translation (id_service, lang, name, description)
VALUES
    (
        1,
        'de',
        'Codierung Start-Stop-Automatik deaktivieren',
        'Mit dieser Codierung aktiviert Ihr Fahrzeug die Start-Stop-Automatik nicht mehr bei jedem Start. Wir führen dies nach der offiziellen Methode durch, ohne die Original-Verkabelung zu manipulieren oder "Bypass"-Geräte hinzuzufügen.'
    ),
    (
        2,
        'de',
        'Codierung EDW-Alarmanlage',
        'Wir aktivieren für Sie die EDW-Alarmanlage. Sie löst aus, wenn im verriegelten Zustand das Öffnen einer Fahrzeugtür erkannt wird. 90 % der Fahrzeuge der Marke verfügen serienmäßig nicht über dieses Extra.'
    ),
    (
        3,
        'de',
        'Codierung Reifendruckanzeige von kPa auf bar',
        'Wir ändern die Maßeinheit der Reifendruckanzeige in Ihrem Kombiinstrument von kPa auf bar.'
    ),
    (
        4,
        'de',
        'Codierung Signalton beim Verriegeln',
        'Kurzer Signalton beim Verriegeln des Fahrzeugs. Wir aktivieren das Menü für diese Funktion im Kombiinstrument, damit Sie sie jederzeit ein- oder ausschalten können.'
    ),
    (
        5,
        'de',
        'Codierung Parktronic-Ton im gelben Bereich',
        'Wir sorgen dafür, dass Ihr Parktronic auch im gelben Bereich akustisch warnt. (Serienmäßig piept es nur im roten Bereich).'
    ),
    (
        6,
        'de',
        'Codierung Blinker 3 auf 6 Blinkimpulse',
        'Bei Nutzung der Tippblinker-Funktion blinkt es statt 3-mal 6-mal (anpassbarer Wert).'
    ),
    (
        7,
        'de',
        'Codierung Gurtwarnton deaktivieren',
        'Wir deaktivieren den akustischen Gurtwarnton des Kombiinstruments (der visuelle und akustische Warnhinweis bleibt aktiv).'
    ),
    (
        8,
        'de',
        'Codierung Zeigertest im Kombiinstrument',
        'Zeigertest im Kombiinstrument beim Einschalten der Zündung. Je nach Ausstattung und/oder Baujahr verfügen manche Fahrzeuge nicht über diese Funktion.'
    ),
    (
        9,
        'de',
        'Codierung Warnung Tankdeckel offen',
        'Wenn Sie mit geöffnetem Tankdeckel losfahren, wird eine Warnung im Kombiinstrument angezeigt.'
    ),
    (
        10,
        'de',
        'Höchstgeschwindigkeit entdrosseln (nicht AMG)',
        'Wir entfernen die elektronische Höchstgeschwindigkeitsbegrenzung Ihres Fahrzeugs.'
    ),
    (
        11,
        'de',
        'Höchstgeschwindigkeit entdrosseln (AMG)',
        'Wir entfernen die elektronische 250-km/h-Höchstgeschwindigkeitsbegrenzung Ihres AMG-Fahrzeugs.'
    ),
    (
        12,
        'de',
        'Codierung Emotion Start (AMG)',
        'Kurze Pops and Bangs beim Start, nur bei betriebswarmem Motor.'
    ),
    (
        13,
        'de',
        'Echten Kilometerstand prüfen',
        'Zweifel, ob der Kilometerstand Ihres Fahrzeugs manipuliert wurde? Wir helfen Ihnen, es herauszufinden.'
    ),
    (
        14,
        'de',
        'Basisdiagnose',
        'Auslesen und/oder Löschen von Fehlercodes.'
    ),
    (
        15,
        'de',
        'Erweiterte Diagnose',
        'Auslesen und/oder Löschen von Fehlercodes, Istwerte, Bauteiltests usw.'
    ),
    (
        16,
        'de',
        'Retrofit-Unterstützung',
        'Wir unterstützen Sie bei jedem Retrofit, das eine SCN-Codierung erfordert. Der Preis kann je nach Schwierigkeitsgrad variieren.'
    ),
    (
        17,
        'de',
        'Retrofit NTG5.0, NTG5S1 oder Garmin',
        'Wenn Ihr Fahrzeug über NTG 4.5 oder 4.7 verfügt, helfen wir Ihnen bei der Nachrüstung auf NTG5.0, NTG5S1 oder Garmin.'
    ),
    (
        18,
        'de',
        'Retrofit Original-Rückfahrkamera',
        'Wir rüsten die Original-Rückfahrkamera nach, Code SA 218.'
    ),
    (
        19,
        'de',
        'Retrofit Elektrisch anklappbare Außenspiegel',
        'Wir rüsten das Extra elektrisch anklappbare Außenspiegel nach, Code SA 500.'
    ),
    (
        20,
        'de',
        'Codierung Aktivierung Apple CarPlay/Android Auto',
        'Wir aktivieren diese Funktion, sofern Ihr NTG-Gerät kompatibel ist.'
    ),
    (
        21,
        'de',
        'Codierung Begrüßungslicht-Dauer verlängern',
        'Wir verlängern die Dauer dieser Animation auf 8 Sekunden (anpassbare Zeit).'
    ),
    (
        22,
        'de',
        'Codierung Ambientelicht-Menü im Radio aktivieren',
        'Falls Ihr Fahrzeug kompatibel ist, aktivieren wir dieses Menü im NTG-Gerät und führen die erforderliche Codierung im SAM-Steuergerät durch.'
    ),
    (
        23,
        'de',
        'Retrofit Comand NTG5S1',
        'Wenn Ihr Fahrzeug über NTG 5.0 oder Garmin verfügt, helfen wir Ihnen bei der Nachrüstung eines NTG5S1-Geräts.'
    ),
    (
        24,
        'de',
        'Codierung Abblendlicht beim Entriegeln',
        'Beim Entriegeln des Fahrzeugs schaltet sich das Abblendlicht ein.'
    ),
    (
        26,
        'de',
        'Codierung Fahrmodus-Speicherung',
        'Mit dieser Codierung merkt sich Ihr Fahrzeug den zuletzt genutzten Fahrmodus für den nächsten Start, ohne zeitliche Begrenzung (standardmäßig nur 4 Stunden).'
    ),
    (
        27,
        'de',
        'Codierung Restkraftstoffmenge in Litern anzeigen',
        'Das Kombiinstrument zeigt die verbleibende Kraftstoffmenge im Tank in Litern an.'
    ),
    (
        28,
        'de',
        'Codierung Restreichweite in km anzeigen',
        'Mit dieser Aktivierung wird stets die Restreichweite in km statt des Tank-Symbols angezeigt.'
    ),
    (
        29,
        'de',
        'Codierung Parktronic Lautstärke und Frequenz anpassen',
        'Wir ändern die Lautstärke und Frequenz des akustischen Warnsignals des Parktronic-Systems.'
    ),
    (
        30,
        'de',
        'Codierung Nebelscheinwerfer als Kurvenlicht',
        'Beim Abbiegen schaltet sich der Nebelscheinwerfer auf der entsprechenden Abbiegeseite ein.'
    ),
    (
        31,
        'de',
        'Codierung Nachlaufzeit des Radios verlängern',
        'Wir verlängern die Zeit, bis sich das Gerät nach dem Abstellen der Zündung ausschaltet.'
    ),
    (
        32,
        'de',
        'Codierung Videowiedergabe während der Fahrt freischalten',
        'Wir aktivieren die Videowiedergabe während der Fahrt in Ihrem Comand-System.'
    ),
    (
        34,
        'de',
        'Retrofit Ambientelicht-Lüftungsdüsen',
        'Nachrüstung von Lüftungsdüsen mit Ambientebeleuchtung, farblich anpassbar über eine Smartphone-App.'
    ),
    (
        35,
        'de',
        'Retrofit Ambientelicht-Lüftungsdüsen',
        'Nachrüstung von Lüftungsdüsen mit Ambientebeleuchtung, farblich anpassbar über das NTG-Radiogerät.'
    ),
    (
        36,
        'de',
        'Retrofit Regensensor-Scheibenwischer',
        'Erfordert einen Sensortausch, im Preis inbegriffen.'
    ),
    (
        38,
        'de',
        'Codierung Automatischer Blinker beim Lenken',
        'Beim Einschlagen des Lenkrads aktiviert sich automatisch der entsprechende Blinker in Richtung der Kurve.'
    ),
    (
        39,
        'de',
        'Codierung Automatisches Fernlicht IHC',
        'Falls Ihr Fahrzeug über Verkehrszeichenerkennung verfügt, können wir diese Funktion zusätzlich aktivieren, sofern sie noch nicht vorhanden ist.'
    ),
    (
        40,
        'de',
        'Basis-Codierpaket',
        'Basis-Codierpaket für Modelle, bei denen die Anzahl verfügbarer Codierservices sehr begrenzt ist.'
    ),
    (
        41,
        'de',
        'Erweitertes Codierpaket',
        'Erweitertes Codierpaket für Modelle mit einer größeren Anzahl verfügbarer Codierservices.'
    ),
    (
        42,
        'de',
        'Codierung Halogen- auf Bi-Xenon-Scheinwerfer',
        'Wenn Sie diese Scheinwerfer nachrüsten, helfen wir Ihnen bei der Codierung.'
    ),
    (
        43,
        'de',
        'Codierung Halogen- auf LED-Scheinwerfer',
        'Wenn Sie diese Scheinwerfer nachrüsten, helfen wir Ihnen bei der Codierung.'
    ),
    (
        44,
        'de',
        'Codierung Bi-Xenon- auf LED-Scheinwerfer',
        'Wenn Sie diese Scheinwerfer nachrüsten, helfen wir Ihnen bei der Codierung.'
    ),
    (
        45,
        'de',
        'Codierung Dauerhafte Klimaanlage (A/C)',
        'Immer wenn Sie die Klimaanlage einschalten, aktiviert sich automatisch der A/C-Modus.'
    ),
    (
        46,
        'de',
        'Codierung Dauerhafte Luftumwälzung',
        'Immer wenn Sie die Klimaanlage einschalten, aktiviert sich automatisch die Luftumwälzung.'
    ),
    (
        47,
        'de',
        'Codierung Rückleuchten mit Tagfahrlicht',
        'Mit dieser Codierung schalten sich die Rückleuchten zusammen mit dem Tagfahrlicht ein.'
    ),
    (
        48,
        'de',
        'Codierung Kombiinstrument erneuern',
        'Wenn Sie ein gebrauchtes Kombiinstrument eingebaut haben, helfen wir Ihnen, es zu virginisieren und mit der EZS zu koppeln.'
    ),
    (
        49,
        'de',
        'Codierung AMG-Menü im Kombiinstrument',
        'Wir codieren das AMG-Menü in Ihrem Kombiinstrument.'
    );

-- Servicios FRANÇAIS
INSERT INTO
    service_translation (id_service, lang, name, description)
VALUES
    (
        1,
        'fr',
        'Codage Désactivation du Start-Stop automatique',
        'Grâce à ce codage, votre véhicule n''activera plus le Start/Stop automatique à chaque démarrage. Nous procédons selon la méthode officielle, sans manipuler le câblage d''origine ni ajouter de dispositifs de contournement (« bypass »).'
    ),
    (
        2,
        'fr',
        'Codage Alarme périmétrique EDW',
        'Nous activons pour vous l''alarme périmétrique EDW. Elle se déclenche lorsqu''elle détecte l''ouverture d''une porte du véhicule alors qu''il est verrouillé. 90 % des véhicules de la marque n''intègrent pas cet équipement de série.'
    ),
    (
        3,
        'fr',
        'Codage Affichage pression des pneus de kPa à bar',
        'Nous modifions l''unité de mesure de la pression des pneus affichée sur votre combiné d''instruments, de kPa à bar.'
    ),
    (
        4,
        'fr',
        'Codage Bip sonore au verrouillage du véhicule',
        'Bref bip sonore au verrouillage du véhicule. Nous activons le menu correspondant dans le combiné d''instruments afin que vous puissiez l''activer ou la désactiver à volonté.'
    ),
    (
        5,
        'fr',
        'Codage Signal sonore Parktronic dans la zone jaune',
        'Nous faisons en sorte que votre Parktronic émette également un avertissement sonore dans la zone jaune (de série, il ne « bipe » que dans la zone rouge).'
    ),
    (
        6,
        'fr',
        'Codage Clignotants 3 à 6 impulsions',
        'En utilisant la fonction clignotant rapide, au lieu de 3 impulsions, il en fera 6 (valeur personnalisable).'
    ),
    (
        7,
        'fr',
        'Codage Désactivation de l''alerte sonore de ceinture de sécurité',
        'Nous désactivons l''alerte sonore de ceinture de sécurité émise par le combiné d''instruments (l''alerte visuelle et sonore reste active).'
    ),
    (
        8,
        'fr',
        'Codage Test des aiguilles du combiné d''instruments',
        'Test de balayage des aiguilles du combiné d''instruments à la mise du contact. Certains véhicules ne disposent pas de cette fonction selon l''équipement et/ou l''année.'
    ),
    (
        9,
        'fr',
        'Codage Alerte trappe à carburant ouverte',
        'Si vous démarrez avec la trappe à carburant ouverte, une alerte s''affichera sur le combiné d''instruments.'
    ),
    (
        10,
        'fr',
        'Déblocage de la vitesse maximale (hors AMG)',
        'Nous supprimons la limitation électronique de vitesse maximale de votre véhicule.'
    ),
    (
        11,
        'fr',
        'Déblocage de la vitesse maximale (AMG)',
        'Nous supprimons la limitation électronique de vitesse maximale de 250 km/h de votre véhicule AMG.'
    ),
    (
        12,
        'fr',
        'Codage Emotion Start (AMG)',
        'Brefs pops and bangs au démarrage, uniquement lorsque le moteur est à température de fonctionnement.'
    ),
    (
        13,
        'fr',
        'Vérification du kilométrage réel',
        'Un doute sur une éventuelle manipulation du kilométrage de votre véhicule ? Nous vous aidons à le savoir.'
    ),
    (
        14,
        'fr',
        'Diagnostic de base',
        'Lecture et/ou effacement des codes défaut.'
    ),
    (
        15,
        'fr',
        'Diagnostic avancé',
        'Lecture et/ou effacement des codes défaut, valeurs réelles, tests de composants, etc.'
    ),
    (
        16,
        'fr',
        'Aide au Retrofit',
        'Nous vous aidons pour tout retrofit nécessitant un codage SCN. Le prix peut varier selon la difficulté de celui-ci.'
    ),
    (
        17,
        'fr',
        'Retrofit NTG5.0, NTG5S1 ou Garmin',
        'Si votre véhicule dispose du NTG 4.5 ou 4.7, nous vous aidons à le rééquiper en NTG5.0, NTG5S1 ou Garmin.'
    ),
    (
        18,
        'fr',
        'Retrofit Caméra de recul d''origine',
        'Nous rééquipons la caméra de recul d''origine, code SA 218.'
    ),
    (
        19,
        'fr',
        'Retrofit Rétroviseurs rabattables électriquement',
        'Nous rééquipons l''option rétroviseurs rabattables électriquement, code SA 500.'
    ),
    (
        20,
        'fr',
        'Codage Activation Apple CarPlay/Android Auto',
        'Nous activons cette fonction si votre unité NTG est compatible.'
    ),
    (
        21,
        'fr',
        'Codage Prolongation de la durée des feux de bienvenue',
        'Nous prolongeons la durée de cette animation à 8 secondes (durée personnalisable).'
    ),
    (
        22,
        'fr',
        'Codage Activation du menu éclairage d''ambiance dans l''autoradio',
        'Si votre véhicule est compatible, nous activons ce menu sur l''unité NTG et réalisons le codage requis sur le boîtier SAM.'
    ),
    (
        23,
        'fr',
        'Retrofit Comand NTG5S1',
        'Si votre véhicule dispose du NTG 5.0 ou du Garmin, nous vous aidons à le rééquiper d''une unité NTG5S1.'
    ),
    (
        24,
        'fr',
        'Codage Feux de croisement à l''ouverture du véhicule',
        'À l''ouverture du véhicule, les feux de croisement s''allumeront.'
    ),
    (
        26,
        'fr',
        'Codage Mémorisation du mode de conduite',
        'Avec ce codage, votre voiture mémorisera le dernier mode de conduite utilisé pour le prochain démarrage, sans limite de temps (par défaut, la mémorisation dure 4 heures).'
    ),
    (
        27,
        'fr',
        'Codage Affichage des litres de carburant restants',
        'Le combiné d''instruments affichera la quantité de carburant restante dans le réservoir, en litres.'
    ),
    (
        28,
        'fr',
        'Codage Affichage de l''autonomie restante en km',
        'Avec cette activation, l''autonomie restante en km sera toujours affichée à la place de l''icône de ravitaillement.'
    ),
    (
        29,
        'fr',
        'Codage Réglage du volume et de la fréquence du Parktronic',
        'Nous modifions le volume et la fréquence de l''alerte sonore du système Parktronic.'
    ),
    (
        30,
        'fr',
        'Codage Utilisation des antibrouillards en éclairage d''angle',
        'Lors des virages, l''antibrouillard correspondant au côté du virage s''allumera.'
    ),
    (
        31,
        'fr',
        'Codage Prolongation du délai d''extinction de l''autoradio',
        'Nous prolongeons le délai avant extinction de l''unité après la coupure du contact.'
    ),
    (
        32,
        'fr',
        'Codage Activation de la lecture vidéo en roulant',
        'Nous activons la lecture vidéo en mouvement sur votre unité Comand.'
    ),
    (
        34,
        'fr',
        'Retrofit Aérateurs à éclairage d''ambiance',
        'Rééquipement des aérateurs avec éclairage d''ambiance aux couleurs personnalisables via une application smartphone.'
    ),
    (
        35,
        'fr',
        'Retrofit Aérateurs à éclairage d''ambiance',
        'Rééquipement des aérateurs avec éclairage d''ambiance aux couleurs personnalisables via l''unité radio NTG.'
    ),
    (
        36,
        'fr',
        'Retrofit Essuie-glaces automatiques',
        'Nécessite le remplacement du capteur, inclus dans le prix.'
    ),
    (
        38,
        'fr',
        'Codage Clignotant automatique au braquage',
        'En braquant le volant, le clignotant correspondant s''active automatiquement dans le sens du virage.'
    ),
    (
        39,
        'fr',
        'Codage Feux de route automatiques IHC',
        'Si votre véhicule dispose de la reconnaissance des panneaux de signalisation, nous pouvons activer cette fonction supplémentaire si elle n''est pas encore présente.'
    ),
    (
        40,
        'fr',
        'Pack coding de base',
        'Pack de codage de base pour les modèles où le nombre de services de codage disponibles est très limité.'
    ),
    (
        41,
        'fr',
        'Pack coding avancé',
        'Pack de codage avancé pour les modèles où le nombre de services de codage disponibles est plus large.'
    ),
    (
        42,
        'fr',
        'Codage Phares halogènes vers bi-xénon',
        'Si vous rééquipez ces phares, nous vous aidons à les coder.'
    ),
    (
        43,
        'fr',
        'Codage Phares halogènes vers LED',
        'Si vous rééquipez ces phares, nous vous aidons à les coder.'
    ),
    (
        44,
        'fr',
        'Codage Phares bi-xénon vers LED',
        'Si vous rééquipez ces phares, nous vous aidons à les coder.'
    ),
    (
        45,
        'fr',
        'Codage Climatisation A/C permanente',
        'Chaque fois que vous allumez la climatisation, le mode A/C s''activera automatiquement.'
    ),
    (
        46,
        'fr',
        'Codage Recirculation d''air permanente',
        'Chaque fois que vous allumez la climatisation, la recirculation d''air s''activera automatiquement.'
    ),
    (
        47,
        'fr',
        'Codage Feux arrière diurnes',
        'Avec ce codage, les feux arrière s''allumeront également en même temps que les feux de jour.'
    ),
    (
        48,
        'fr',
        'Codage Renouvellement du combiné d''instruments',
        'Si vous avez installé un combiné d''instruments d''occasion, nous vous aidons à le réinitialiser à l''état vierge et à l''appairer avec l''EZS.'
    ),
    (
        49,
        'fr',
        'Codage Menu AMG dans le combiné d''instruments',
        'Nous codons le menu AMG dans votre combiné d''instruments.'
    );

-- Servicios ITALIANO
INSERT INTO
    service_translation (id_service, lang, name, description)
VALUES
    (
        1,
        'it',
        'Codifica Disattivazione Start-Stop automatico',
        'Con questa codifica, il tuo veicolo non attiverà più lo Start/Stop automatico ad ogni avviamento. Lo facciamo tramite il metodo ufficiale, senza manomettere il cablaggio originale né aggiungere dispositivi "bypass".'
    ),
    (
        2,
        'it',
        'Codifica Allarme perimetrale EDW',
        'Attiviamo per te l''allarme perimetrale EDW. Si attiva quando rileva l''apertura di una qualsiasi portiera del veicolo mentre è bloccato. Il 90% dei veicoli del marchio non include questo optional di serie.'
    ),
    (
        3,
        'it',
        'Codifica Visualizzazione pressione pneumatici da kPa a bar',
        'Cambiamo l''unità di misura della pressione degli pneumatici nel quadro strumenti da kPa a bar.'
    ),
    (
        4,
        'it',
        'Codifica Segnale acustico alla chiusura del veicolo',
        'Breve segnale acustico alla chiusura del veicolo. Attiviamo il menu per questa funzione nel quadro strumenti, così potrai attivarla o disattivarla quando vuoi.'
    ),
    (
        5,
        'it',
        'Codifica Segnale acustico Parktronic nella zona gialla',
        'Facciamo in modo che il tuo Parktronic emetta un avviso acustico anche nella zona gialla (di serie ''suona'' solo nella zona rossa).'
    ),
    (
        6,
        'it',
        'Codifica Frecce da 3 a 6 lampeggi',
        'Utilizzando la funzione rapida della freccia, invece di 3 lampeggi ne farà 6 (valore personalizzabile).'
    ),
    (
        7,
        'it',
        'Codifica Disattivazione avviso acustico cintura di sicurezza',
        'Disattiviamo l''avviso acustico della cintura di sicurezza emesso dal quadro strumenti (l''avviso visivo e acustico rimane attivo).'
    ),
    (
        8,
        'it',
        'Codifica Test lancette quadro strumenti',
        'Test di scorrimento delle lancette nel quadro strumenti all''accensione del quadro. Alcuni veicoli non dispongono di questa funzione a seconda dell''allestimento e/o dell''anno.'
    ),
    (
        9,
        'it',
        'Codifica Avviso sportello carburante aperto',
        'Se ti metti in marcia con lo sportello del carburante aperto, verrà mostrato un avviso nel quadro strumenti.'
    ),
    (
        10,
        'it',
        'Rimozione limitatore di velocità massima (non AMG)',
        'Rimuoviamo il limitatore elettronico di velocità massima del tuo veicolo.'
    ),
    (
        11,
        'it',
        'Rimozione limitatore di velocità massima (AMG)',
        'Rimuoviamo il limitatore elettronico di velocità massima di 250 km/h dal tuo veicolo AMG.'
    ),
    (
        12,
        'it',
        'Codifica Emotion Start (AMG)',
        'Brevi pops and bangs all''avviamento, solo a motore in temperatura di esercizio.'
    ),
    (
        13,
        'it',
        'Verifica chilometraggio reale',
        'Dubbi sul fatto che il chilometraggio del tuo veicolo sia stato manomesso? Ti aiutiamo a scoprirlo.'
    ),
    (
        14,
        'it',
        'Diagnosi di base',
        'Lettura e/o cancellazione degli errori.'
    ),
    (
        15,
        'it',
        'Diagnosi avanzata',
        'Lettura e/o cancellazione degli errori, valori reali, test dei componenti, ecc.'
    ),
    (
        16,
        'it',
        'Assistenza Retrofit',
        'Ti aiutiamo con qualsiasi retrofit che richieda una codifica SCN. Il prezzo può variare in base alla difficoltà dello stesso.'
    ),
    (
        17,
        'it',
        'Retrofit NTG5.0, NTG5S1 o Garmin',
        'Se il tuo veicolo ha l''NTG 4.5 o 4.7, ti aiutiamo a riequipaggiarlo con NTG5.0, NTG5S1 o Garmin.'
    ),
    (
        18,
        'it',
        'Retrofit Telecamera posteriore originale',
        'Riequipaggiamo la telecamera per la visione posteriore originale, codice SA 218.'
    ),
    (
        19,
        'it',
        'Retrofit Specchietti ripiegabili elettricamente',
        'Riequipaggiamo l''optional specchietti ripiegabili elettricamente, codice SA 500.'
    ),
    (
        20,
        'it',
        'Codifica Attivazione Apple CarPlay/Android Auto',
        'Attiviamo questa funzione se la tua unità NTG è compatibile.'
    ),
    (
        21,
        'it',
        'Codifica Estensione durata luci di benvenuto',
        'Estendiamo la durata di questa animazione a 8 secondi (tempo personalizzabile).'
    ),
    (
        22,
        'it',
        'Codifica Attivazione menu luci ambiente nell''autoradio',
        'Se il tuo veicolo è compatibile, attiviamo questo menu sull''unità NTG ed eseguiamo la codifica richiesta sulla centralina SAM.'
    ),
    (
        23,
        'it',
        'Retrofit Comand NTG5S1',
        'Se il tuo veicolo ha l''NTG 5.0 o Garmin, ti aiutiamo a riequipaggiarlo con un''unità NTG5S1.'
    ),
    (
        24,
        'it',
        'Codifica Anabbaglianti all''apertura del veicolo',
        'Sbloccando il veicolo, si accenderanno gli anabbaglianti.'
    ),
    (
        26,
        'it',
        'Codifica Memoria modalità di guida',
        'Con questa codifica, la tua auto memorizzerà l''ultima modalità di guida utilizzata per il successivo avviamento, senza limiti di tempo (di default la memorizza per 4 ore).'
    ),
    (
        27,
        'it',
        'Codifica Visualizzazione litri di carburante residui',
        'Il quadro strumenti mostrerà la quantità di carburante rimanente nel serbatoio, in litri.'
    ),
    (
        28,
        'it',
        'Codifica Visualizzazione autonomia residua in km',
        'Con questa attivazione verrà sempre mostrata l''autonomia residua in km al posto dell''icona di rifornimento.'
    ),
    (
        29,
        'it',
        'Codifica Regolazione volume e frequenza Parktronic',
        'Modifichiamo il volume e la frequenza dell''avviso acustico del sistema Parktronic.'
    ),
    (
        30,
        'it',
        'Codifica Fendinebbia come luci di svolta',
        'Durante le curve, si accenderà il fendinebbia corrispondente al lato della svolta.'
    ),
    (
        31,
        'it',
        'Codifica Estensione ritardo spegnimento autoradio',
        'Estendiamo il tempo che l''unità impiega a spegnersi dopo aver tolto il contatto.'
    ),
    (
        32,
        'it',
        'Codifica Abilitazione riproduzione video in movimento',
        'Attiviamo la riproduzione video durante la marcia sulla tua unità Comand.'
    ),
    (
        34,
        'it',
        'Retrofit Bocchette con luci ambiente',
        'Retrofit di bocchette d''aerazione con luci ambiente a colore personalizzabile tramite un''app per smartphone.'
    ),
    (
        35,
        'it',
        'Retrofit Bocchette con luci ambiente',
        'Retrofit di bocchette d''aerazione con luci ambiente a colore personalizzabile tramite l''unità radio NTG.'
    ),
    (
        36,
        'it',
        'Retrofit Tergicristalli automatici',
        'Richiede la sostituzione del sensore, inclusa nel prezzo.'
    ),
    (
        38,
        'it',
        'Codifica Freccia automatica in curva',
        'Sterzando il volante, si attiva automaticamente la freccia corrispondente nella direzione della curva.'
    ),
    (
        39,
        'it',
        'Codifica Abbaglianti automatici IHC',
        'Se il tuo veicolo dispone del riconoscimento dei segnali stradali, possiamo attivare anche questa funzione aggiuntiva se non è già presente.'
    ),
    (
        40,
        'it',
        'Pack codifica base',
        'Pacchetto di codifica base per i modelli in cui il numero di servizi di codifica disponibili è molto ridotto.'
    ),
    (
        41,
        'it',
        'Pack codifica avanzato',
        'Pacchetto di codifica avanzato per i modelli in cui il numero di servizi di codifica disponibili è più ampio.'
    ),
    (
        42,
        'it',
        'Codifica Fari alogeni a bi-xeno',
        'Se stai riequipaggiando questi fari, ti aiutiamo a codificarli.'
    ),
    (
        43,
        'it',
        'Codifica Fari alogeni a LED',
        'Se stai riequipaggiando questi fari, ti aiutiamo a codificarli.'
    ),
    (
        44,
        'it',
        'Codifica Fari bi-xeno a LED',
        'Se stai riequipaggiando questi fari, ti aiutiamo a codificarli.'
    ),
    (
        45,
        'it',
        'Codifica A/C permanente',
        'Ogni volta che accendi il climatizzatore, si attiverà automaticamente la modalità A/C.'
    ),
    (
        46,
        'it',
        'Codifica Ricircolo aria permanente',
        'Ogni volta che accendi il climatizzatore, si attiverà automaticamente il ricircolo dell''aria.'
    ),
    (
        47,
        'it',
        'Codifica Luci posteriori diurne',
        'Con questa codifica, anche i fari posteriori si accenderanno insieme alle luci diurne.'
    ),
    (
        48,
        'it',
        'Codifica Rinnovo quadro strumenti',
        'Se hai installato un quadro strumenti usato, ti aiutiamo a virginizzarlo e ad abbinarlo alla EZS.'
    ),
    (
        49,
        'it',
        'Codifica Menu AMG nel quadro strumenti',
        'Codifichiamo il menu AMG nel tuo quadro strumenti.'
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