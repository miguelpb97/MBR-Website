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
        `visible` TINYINT (1) DEFAULT 0,
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
    (1, 'pt', 'Classe A'),
    -- Clase B
    (2, 'en', 'B-Class'),
    (2, 'de', 'B-Klasse'),
    (2, 'fr', 'Classe B'),
    (2, 'it', 'Classe B'),
    (2, 'pt', 'Classe B'),
    -- Clase C
    (3, 'en', 'C-Class'),
    (3, 'de', 'C-Klasse'),
    (3, 'fr', 'Classe C'),
    (3, 'it', 'Classe C'),
    (3, 'pt', 'Classe C'),
    -- Clase CLA
    (4, 'en', 'CLA-Class'),
    (4, 'de', 'CLA-Klasse'),
    (4, 'fr', 'Classe CLA'),
    (4, 'it', 'Classe CLA'),
    (4, 'pt', 'Classe CLA'),
    -- Clase CLK
    (5, 'en', 'CLK-Class'),
    (5, 'de', 'CLK-Klasse'),
    (5, 'fr', 'Classe CLK'),
    (5, 'it', 'Classe CLK'),
    (5, 'pt', 'Classe CLK'),
    -- Clase CLS
    (6, 'en', 'CLS-Class'),
    (6, 'de', 'CLS-Klasse'),
    (6, 'fr', 'Classe CLS'),
    (6, 'it', 'Classe CLS'),
    (6, 'pt', 'Classe CLS'),
    -- Clase E
    (7, 'en', 'E-Class'),
    (7, 'de', 'E-Klasse'),
    (7, 'fr', 'Classe E'),
    (7, 'it', 'Classe E'),
    (7, 'pt', 'Classe E'),
    -- Clase G
    (8, 'en', 'G-Class'),
    (8, 'de', 'G-Klasse'),
    (8, 'fr', 'Classe G'),
    (8, 'it', 'Classe G'),
    (8, 'pt', 'Classe G'),
    -- Clase GLA
    (9, 'en', 'GLA-Class'),
    (9, 'de', 'GLA-Klasse'),
    (9, 'fr', 'Classe GLA'),
    (9, 'it', 'Classe GLA'),
    (9, 'pt', 'Classe GLA'),
    -- Clase M
    (10, 'en', 'M-Class'),
    (10, 'de', 'M-Klasse'),
    (10, 'fr', 'Classe M'),
    (10, 'it', 'Classe M'),
    (10, 'pt', 'Classe M'),
    -- Clase ML
    (11, 'en', 'ML-Class'),
    (11, 'de', 'ML-Klasse'),
    (11, 'fr', 'Classe ML'),
    (11, 'it', 'Classe ML'),
    (11, 'pt', 'Classe ML'),
    -- Clase R
    (12, 'en', 'R-Class'),
    (12, 'de', 'R-Klasse'),
    (12, 'fr', 'Classe R'),
    (12, 'it', 'Classe R'),
    (12, 'pt', 'Classe R'),
    -- Clase S
    (13, 'en', 'S-Class'),
    (13, 'de', 'S-Klasse'),
    (13, 'fr', 'Classe S'),
    (13, 'it', 'Classe S'),
    (13, 'pt', 'Classe S'),
    -- Clase SLK
    (14, 'en', 'SLK-Class'),
    (14, 'de', 'SLK-Klasse'),
    (14, 'fr', 'Classe SLK'),
    (14, 'it', 'Classe SLK'),
    (14, 'pt', 'Classe SLK'),
    -- Clase SL
    (15, 'en', 'SL-Class'),
    (15, 'de', 'SL-Klasse'),
    (15, 'fr', 'Classe SL'),
    (15, 'it', 'Classe SL'),
    (15, 'pt', 'Classe SL'),
    -- Clase V
    (16, 'en', 'V-Class'),
    (16, 'de', 'V-Klasse'),
    (16, 'fr', 'Classe V'),
    (16, 'it', 'Classe V'),
    (16, 'pt', 'Classe V');

-- Variantes (id_variant, name, image_url, vehicle_id, visible)
INSERT INTO
    `variant` (
        `id_variant`,
        `name`,
        `image_url`,
        `vehicle_id`,
        `visible`
    )
VALUES
    (1, 'W176 Pre-facelift', 'W176PF.png', 1, 1),
    (2, 'W176 Facelift', 'W176FL.png', 1, 1),
    (3, 'W177 Pre-facelift', 'W177PF.png', 1, 1),
    (4, 'W246 Pre-facelift', 'W246PF.png', 2, 1),
    (5, 'W246 Facelift', 'W246FL.png', 2, 1),
    (6, 'W247 Pre-facelift', 'W247PF.png', 2, 1),
    (7, 'W203/S203', 'W203.png', 3, 1),
    (8, 'W204/S204/X204', 'W204.png', 3, 1),
    (9, 'W204/S204/X204 Facelift', 'W204FL.png', 3, 1),
    (10, 'W205/S205/X253', 'W205.png', 3, 1),
    (11, 'C117/X117 Pre-facelift', 'C117PF.png', 4, 1),
    (12, 'C117/X117 Facelift', 'C117FL.png', 4, 1),
    (13, 'C118/X118 Pre-facelift', 'C118PF.png', 4, 1),
    (14, 'W209', 'W209.png', 5, 1),
    (15, 'W219/C219', 'W219.png', 6, 1),
    (16, 'W218/C218', 'W218.png', 6, 1),
    (17, 'W211/S211', 'W211.png', 7, 1),
    (18, 'W212/S212/A207/C207', 'W212.png', 7, 1),
    (19, 'W212 Facelift', 'W212FL.png', 7, 1),
    (20, 'W213', 'W213.png', 7, 1),
    (21, 'W213 Facelift', 'W213FL.png', 7, 0),
    (22, 'W463', 'W463.png', 8, 1),
    (23, 'X156 Pre-facelift', 'X156PF.png', 9, 1),
    (24, 'X156 Facelift', 'X156FL.png', 9, 1),
    (25, 'X157 Pre-facelift', 'X157PF.png', 9, 1),
    (26, 'W164/X164', 'X164.png', 10, 1),
    (27, 'W166/X166', 'W166.png', 11, 1),
    (28, 'W251', 'W251.png', 12, 1),
    (29, 'S221/W216', 'S221.png', 13, 1),
    (30, 'S222/W217', 'W222.png', 13, 1),
    (31, 'R171', 'R171.png', 14, 1),
    (32, 'R172', 'R172.png', 14, 1),
    (33, 'R230', 'R230.png', 15, 1),
    (34, 'R231', 'R231.png', 15, 1),
    (35, 'W447', 'W447.png', 16, 1);

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
        30.00,
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
        35.00,
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
        NULL,
        'service-img.png',
        1
    ),
    (
        21,
        'Coding Welcome Home',
        'Activamos la luz de bienvenida en vehículos con faros LED(luz de posicion de color azul durante X segundos al desbloquear) El tiempo es personalizable.',
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
        0
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
        NULL,
        'service-img.png',
        0
    ),
    (
        49,
        'Coding Menú AMG en cuadro de instrumentos',
        'Codificamos el menú AMG en tu cuadro de instrumentos.',
        NULL,
        'service-img.png',
        1
    ),
    (
        50,
        'Coding Visualizar Litros/galones de combustible',
        'Hacemos que tu cuadro de instrumentos visualice litros/galones de combustible en vez de porcentaje.',
        30.00,
        'service-img.png',
        1
    ),
    (
        51,
        'Coding Coming Home',
        'Al desbloquear el vehículo, se encienderán las luces cortas y de posición para una mejor visibilidad.',
        30.00,
        'service-img.png',
        1
    ),
    (
        52,
        'Coding Realidad aumentada permanente',
        'Hacemos que la realidad aumentada se muestre permanentemente.',
        50.00,
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
    ),
    (
        50,
        'en',
        'Coding Fuel Display Liters/Gallons',
        'We make your instrument cluster display fuel in liters/gallons instead of percentage.'
    ),
    (
        51,
        'en',
        'Coding Coming Home',
        'When unlocking the vehicle, the low beam and position lights will turn on for better visibility.'
    ),
    (
        52,
        'en',
        'Coding Permanent Augmented Reality',
        'We make the augmented reality display permanent.'
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
    ),
    (
        50,
        'de',
        'Codierung Anzeige Liter/Gallonen Kraftstoff',
        'Wir stellen dein Kombiinstrument so um, dass der Kraftstoff in Liter/Gallonen statt in Prozent angezeigt wird.'
    ),
    (
        51,
        'de',
        'Codierung Coming Home',
        'Beim Entriegeln des Fahrzeugs schalten sich das Abblendlicht und die Standlichter für eine bessere Sicht ein.'
    ),
    (
        52,
        'de',
        'Codierung Permanente Augmented Reality',
        'Wir stellen die Augmented-Reality-Anzeige so ein, dass sie dauerhaft angezeigt wird.'
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
    ),
    (
        50,
        'fr',
        'Codage Affichage Litres/Gallons de carburant',
        'Nous configurons votre tableau de bord pour afficher le carburant en litres/gallons au lieu du pourcentage.'
    ),
    (
        51,
        'fr',
        'Codage Coming Home',
        'Lors du déverrouillage du véhicule, les feux de croisement et de position s''allumeront pour une meilleure visibilité.'
    ),
    (
        52,
        'fr',
        'Codage Réalité augmentée permanente',
        'Nous configurons l''affichage de la réalité augmentée pour qu''il soit permanent.'
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
    ),
    (
        50,
        'it',
        'Codifica Visualizzazione Litri/Galloni carburante',
        'Facciamo in modo che il tuo cruscotto visualizzi il carburante in litri/galloni invece che in percentuale.'
    ),
    (
        51,
        'it',
        'Codifica Coming Home',
        'Allo sblocco del veicolo, si accenderanno gli anabbaglianti e le luci di posizione per una migliore visibilità.'
    ),
    (
        52,
        'it',
        'Codifica Realtà aumentata permanente',
        'Facciamo in modo che la realtà aumentata venga visualizzata permanentemente.'
    );

-- Servicios PORTUGUÊS
INSERT INTO
    service_translation (id_service, lang, name, description)
VALUES
    (
        1,
        'pt',
        'Codificação Desativar Start-Stop Automático',
        'Com esta codificação, o seu veículo deixará de ativar o sistema Start-Stop automático sempre que ligar o motor. Fazemo-lo através do método oficial, sem alterar a cablagem original nem instalar dispositivos "bypass".'
    ),
    (
        2,
        'pt',
        'Codificação Alarme Perimetral EDW',
        'Ativamos o alarme perimetral EDW. Este dispara quando deteta a abertura de qualquer porta com o veículo trancado. 90% dos veículos da marca não incluem este extra de série.'
    ),
    (
        3,
        'pt',
        'Codificação Pressão dos Pneus de kPa para bar',
        'Alteramos a unidade de medida da pressão dos pneus no seu quadro de instrumentos de kPa para bar.'
    ),
    (
        4,
        'pt',
        'Codificação Sinal Sonoro ao Trancar o Veículo',
        'Um breve sinal sonoro ao trancar o veículo. Ativamos o menu desta função no quadro de instrumentos para que possa ligá-la ou desligá-la sempre que quiser.'
    ),
    (
        5,
        'pt',
        'Codificação Som do Parktronic na Zona Amarela',
        'Fazemos com que o seu Parktronic emita também um aviso acústico na zona amarela. (Por norma, só apita na zona vermelha).'
    ),
    (
        6,
        'pt',
        'Codificação Pisca de 3 para 6 Piscadelas',
        'Ao usar a função de pisca rápido, em vez de 3 piscadelas fará 6 (valor personalizável).'
    ),
    (
        7,
        'pt',
        'Codificação Desativar Aviso Sonoro do Cinto de Segurança',
        'Desativamos o aviso sonoro do cinto de segurança emitido pelo quadro de instrumentos (o aviso visual e sonoro do sistema permanece ativo).'
    ),
    (
        8,
        'pt',
        'Codificação Teste de Varrimento dos Ponteiros no Quadro de Instrumentos',
        'Teste de varrimento dos ponteiros no quadro de instrumentos ao ligar a ignição. Alguns veículos não têm esta função consoante o equipamento e/ou o ano.'
    ),
    (
        9,
        'pt',
        'Codificação Aviso de Tampa do Depósito Aberta',
        'Se começar a conduzir com a tampa do depósito de combustível aberta, será exibido um aviso no quadro de instrumentos.'
    ),
    (
        10,
        'pt',
        'Desbloqueio de Velocidade Máxima (Não-AMG)',
        'Removemos o limitador eletrónico de velocidade máxima do seu veículo.'
    ),
    (
        11,
        'pt',
        'Desbloqueio de Velocidade Máxima (AMG)',
        'Removemos o limitador eletrónico de velocidade máxima de 250 km/h do seu veículo AMG.'
    ),
    (
        12,
        'pt',
        'Codificação Emotion Start (AMG)',
        'Pequenos estalos e "bangs" no arranque, apenas quando o motor está à temperatura de funcionamento.'
    ),
    (
        13,
        'pt',
        'Verificação da Quilometragem Real',
        'Não tem a certeza se a quilometragem do seu veículo foi adulterada? Ajudamo-lo a descobrir.'
    ),
    (
        14,
        'pt',
        'Diagnóstico Básico',
        'Leitura e/ou eliminação de códigos de avaria.'
    ),
    (
        15,
        'pt',
        'Diagnóstico Avançado',
        'Leitura e/ou eliminação de códigos de avaria, valores em tempo real, testes de componentes, etc.'
    ),
    (
        16,
        'pt',
        'Apoio em Retrofits',
        'Ajudamo-lo com qualquer retrofit que necessite de codificação SCN. O preço pode variar consoante a dificuldade.'
    ),
    (
        17,
        'pt',
        'Retrofit NTG5.0, NTG5S1 ou Garmin',
        'Se o seu veículo tem NTG 4.5 ou 4.7, ajudamo-lo a fazer o retrofit para NTG5.0, NTG5S1 ou Garmin.'
    ),
    (
        18,
        'pt',
        'Retrofit da Câmara de Marcha-Atrás Original',
        'Fazemos o retrofit da câmara de marcha-atrás original, código SA 218.'
    ),
    (
        19,
        'pt',
        'Retrofit de Espelhos com Fecho Elétrico',
        'Fazemos o retrofit do extra de espelhos com fecho elétrico, código SA 500.'
    ),
    (
        20,
        'pt',
        'Codificação Ativação Apple CarPlay/Android Auto',
        'Ativamos esta função se a sua unidade NTG for compatível.'
    ),
    (
        21,
        'pt',
        'Codificação Prolongar Duração das Luzes de Boas-Vindas',
        'Prolongamos a duração desta animação para 8 segundos (tempo personalizável).'
    ),
    (
        22,
        'pt',
        'Codificação Ativar Menu de Luz Ambiente na Unidade de Rádio',
        'Se o seu veículo for compatível, ativamos este menu na unidade NTG e realizamos a codificação necessária na unidade SAM.'
    ),
    (
        23,
        'pt',
        'Retrofit Comand NTG5S1',
        'Se o seu veículo tem NTG 5.0 ou Garmin, ajudamo-lo a fazer o retrofit de uma unidade NTG5S1.'
    ),
    (
        24,
        'pt',
        'Codificação Luzes de Cruzamento ao Destrancar',
        'Ao destrancar o veículo, as luzes de cruzamento acender-se-ão.'
    ),
    (
        26,
        'pt',
        'Codificação Memória do Modo de Condução',
        'Com esta codificação, o seu carro vai memorizar o último modo de condução utilizado para o próximo arranque, sem limite de tempo (por norma, só memoriza durante 4 horas).'
    ),
    (
        27,
        'pt',
        'Codificação Mostrar Combustível Restante em Litros',
        'O quadro de instrumentos mostrará a quantidade de combustível restante no depósito, em litros.'
    ),
    (
        28,
        'pt',
        'Codificação Mostrar Autonomia Restante em km',
        'Com esta ativação, será sempre mostrada a autonomia restante em km em vez do ícone de reabastecimento.'
    ),
    (
        29,
        'pt',
        'Codificação Ajuste de Volume e Frequência do Parktronic',
        'Alteramos o volume e a frequência do aviso sonoro do sistema Parktronic.'
    ),
    (
        30,
        'pt',
        'Codificação Faróis de Nevoeiro como Luzes de Curva',
        'Ao virar, o farol de nevoeiro do lado correspondente à curva acender-se-á.'
    ),
    (
        31,
        'pt',
        'Codificação Prolongar o Tempo de Desligamento da Unidade de Rádio',
        'Prolongamos o tempo que a unidade demora a desligar-se depois de desligar a ignição.'
    ),
    (
        32,
        'pt',
        'Codificação Ativar Reprodução de Vídeo em Movimento',
        'Ativamos a reprodução de vídeo com o veículo em movimento na sua unidade Comand.'
    ),
    (
        34,
        'pt',
        'Retrofit de Saídas de Ar com Luz Ambiente',
        'Retrofit de saídas de ar com luz ambiente, com cores personalizáveis através de uma app no smartphone.'
    ),
    (
        35,
        'pt',
        'Retrofit de Saídas de Ar com Luz Ambiente',
        'Retrofit de saídas de ar com luz ambiente, com cores personalizáveis a partir da unidade de rádio NTG.'
    ),
    (
        36,
        'pt',
        'Retrofit de Limpa Para-brisas Automático',
        'Requer substituição do sensor, incluída no preço.'
    ),
    (
        38,
        'pt',
        'Codificação Pisca Automático ao Virar o Volante',
        'Ao virar o volante, o pisca correspondente ativa-se automaticamente na direção da curva.'
    ),
    (
        39,
        'pt',
        'Codificação Máximos Automáticos IHC',
        'Se o seu veículo tiver reconhecimento de sinais de trânsito, podemos ativar adicionalmente esta função caso ainda não a tenha.'
    ),
    (
        40,
        'pt',
        'Pacote Básico de Codificação',
        'Pacote básico de codificação para modelos em que o número de serviços de codificação disponíveis é muito limitado.'
    ),
    (
        41,
        'pt',
        'Pacote Avançado de Codificação',
        'Pacote avançado de codificação para modelos em que o número de serviços de codificação disponíveis é mais alargado.'
    ),
    (
        42,
        'pt',
        'Codificação Faróis Halogéneo para Bi-Xénon',
        'Se está a fazer o retrofit destes faróis, ajudamo-lo a codificá-los.'
    ),
    (
        43,
        'pt',
        'Codificação Faróis Halogéneo para LED',
        'Se está a fazer o retrofit destes faróis, ajudamo-lo a codificá-los.'
    ),
    (
        44,
        'pt',
        'Codificação Faróis Bi-Xénon para LED',
        'Se está a fazer o retrofit destes faróis, ajudamo-lo a codificá-los.'
    ),
    (
        45,
        'pt',
        'Codificação Ar Condicionado Permanente',
        'Sempre que ligar o climatizador, o modo A/C ativar-se-á automaticamente.'
    ),
    (
        46,
        'pt',
        'Codificação Recirculação de Ar Permanente',
        'Sempre que ligar o climatizador, a recirculação de ar ativar-se-á automaticamente.'
    ),
    (
        47,
        'pt',
        'Codificação Luzes Diurnas Traseiras',
        'Com esta codificação, as luzes traseiras também se acenderão juntamente com as luzes diurnas.'
    ),
    (
        48,
        'pt',
        'Codificação Renovação do Quadro de Instrumentos',
        'Se instalou um quadro de instrumentos usado, ajudamo-lo a repô-lo para o estado virgem e a emparelhá-lo com o EZS.'
    ),
    (
        49,
        'pt',
        'Codificação Menu AMG no Quadro de Instrumentos',
        'Codificamos o menu AMG no seu quadro de instrumentos.'
    ),
    (
        50,
        'pt',
        'Codificação Visualização Litros/Galões de combustível',
        'Fazemos com que o seu quadro de instrumentos mostre o combustível em litros/galões em vez de percentagem.'
    ),
    (
        51,
        'pt',
        'Codificação Coming Home',
        'Ao destrancar o veículo, os máximos-mínimos e as luzes de presença acender-se-ão para uma melhor visibilidade.'
    ),
    (
        52,
        'pt',
        'Codificação Realidade aumentada permanente',
        'Fazemos com que a realidade aumentada seja exibida permanentemente.'
    );

-- Relaciones entre servicios/items y variantes (variant_id, service_id)
-- W176 prefacelift
INSERT INTO
    `variant_has_service` (`variant_id`, `service_id`)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (1, 29),
    (1, 6),
    (1, 7),
    (1, 8),
    (1, 9),
    (1, 10),
    (1, 11),
    (1, 12),
    (1, 13),
    (1, 14),
    (1, 15),
    (1, 16),
    (1, 17),
    (1, 18),
    (1, 19),
    (1, 34),
    (1, 36),
    (1, 39),
    (1, 40),
    (1, 41),
    (1, 42),
    (1, 44),
    (1, 45),
    (1, 46),
    (1, 48),
    (1, 49),
    (1, 20);

-- W176 facelift
INSERT INTO
    `variant_has_service` (`variant_id`, `service_id`)
VALUES
    (2, 1),
    (2, 2),
    (2, 3),
    (2, 4),
    (2, 5),
    (2, 29),
    (2, 6),
    (2, 7),
    (2, 8),
    (2, 9),
    (2, 10),
    (2, 11),
    (2, 12),
    (2, 13),
    (2, 14),
    (2, 15),
    (2, 16),
    (2, 21),
    (2, 23),
    (2, 18),
    (2, 19),
    (2, 35),
    (2, 36),
    (2, 39),
    (2, 40),
    (2, 41),
    (2, 43),
    (2, 45),
    (2, 46),
    (2, 49),
    (2, 20);

-- W177 prefacelift
INSERT INTO
    `variant_has_service`
VALUES
    (3, 1),
    (3, 2),
    (3, 3),
    (3, 24),
    (3, 26),
    (3, 6),
    (3, 7),
    (3, 9),
    (3, 10),
    (3, 11),
    (3, 13),
    (3, 14),
    (3, 15),
    (3, 16),
    (3, 39),
    (3, 40),
    (3, 41),
    (3, 48),
    (3, 49),
    (3, 20),
    (3, 51),
    (3, 52);

-- W246 prefacelift
INSERT INTO
    `variant_has_service`
VALUES
    (4, 1),
    (4, 2),
    (4, 3),
    (4, 4),
    (4, 5),
    (4, 29),
    (4, 6),
    (4, 7),
    (4, 8),
    (4, 9),
    (4, 10),
    (4, 13),
    (4, 14),
    (4, 15),
    (4, 16),
    (4, 17),
    (4, 18),
    (4, 19),
    (4, 36),
    (4, 39),
    (4, 40),
    (4, 41),
    (4, 42),
    (4, 44),
    (4, 45),
    (4, 46),
    (4, 48),
    (4, 49),
    (4, 20);

-- W246 facelift
INSERT INTO
    `variant_has_service`
VALUES
    (5, 1),
    (5, 2),
    (5, 3),
    (5, 4),
    (5, 5),
    (5, 29),
    (5, 6),
    (5, 7),
    (5, 8),
    (5, 9),
    (5, 10),
    (5, 13),
    (5, 14),
    (5, 15),
    (5, 16),
    (5, 23),
    (5, 21),
    (5, 18),
    (5, 19),
    (5, 36),
    (5, 39),
    (5, 40),
    (5, 41),
    (5, 43),
    (5, 45),
    (5, 46),
    (5, 48),
    (5, 49),
    (5, 20);

-- W247 prefacelift
INSERT INTO
    `variant_has_service`
VALUES
    (6, 1),
    (6, 2),
    (6, 3),
    (6, 24),
    (6, 26),
    (6, 6),
    (6, 7),
    (6, 9),
    (6, 10),
    (6, 13),
    (6, 14),
    (6, 15),
    (6, 16),
    (6, 39),
    (6, 40),
    (6, 41),
    (6, 51),
    (6, 52);

-- W203/S203
INSERT INTO
    `variant_has_service`
VALUES
    (7, 7),
    (7, 27),
    (7, 28),
    (7, 10),
    (7, 11),
    (7, 29),
    (7, 30),
    (7, 31),
    (7, 32),
    (7, 48);

-- W204/S204/X204
INSERT INTO
    `variant_has_service`
VALUES
    (8, 1),
    (8, 7),
    (8, 27),
    (8, 28),
    (8, 10),
    (8, 11),
    (8, 29),
    (8, 30),
    (8, 31),
    (8, 32),
    (8, 48),
    (8, 49);

-- W204/S204/X204 Facelift
INSERT INTO
    `variant_has_service`
VALUES
    (9, 1),
    (9, 7),
    (9, 27),
    (9, 28),
    (9, 10),
    (9, 11),
    (9, 29),
    (9, 30),
    (9, 31),
    (9, 32),
    (9, 33),
    (9, 48),
    (9, 49);

-- W205/S205/X253
INSERT INTO
    `variant_has_service`
VALUES
    (10, 1),
    (10, 2),
    (10, 20),
    (10, 3),
    (10, 6),
    (10, 7),
    (10, 9),
    (10, 27),
    (10, 28),
    (10, 10),
    (10, 11),
    (10, 29),
    (10, 30),
    (10, 31),
    (10, 32),
    (10, 33),
    (10, 39),
    (10, 40),
    (10, 41),
    (10, 48),
    (10, 49),
    (10, 51),
    (10, 21);

-- C117/X117 prefacelift
INSERT INTO
    `variant_has_service`
VALUES
    (11, 1),
    (11, 2),
    (11, 3),
    (11, 4),
    (11, 5),
    (11, 29),
    (11, 6),
    (11, 7),
    (11, 8),
    (11, 9),
    (11, 10),
    (11, 11),
    (11, 12),
    (11, 13),
    (11, 14),
    (11, 15),
    (11, 16),
    (11, 17),
    (11, 18),
    (11, 19),
    (11, 34),
    (11, 36),
    (11, 39),
    (11, 40),
    (11, 41),
    (11, 42),
    (11, 44),
    (11, 45),
    (11, 46),
    (11, 47),
    (11, 48),
    (11, 49),
    (11, 20);

-- C117/X117 facelift
INSERT INTO
    `variant_has_service`
VALUES
    (12, 1),
    (12, 2),
    (12, 3),
    (12, 4),
    (12, 5),
    (12, 29),
    (12, 6),
    (12, 7),
    (12, 8),
    (12, 9),
    (12, 10),
    (12, 11),
    (12, 12),
    (12, 13),
    (12, 14),
    (12, 15),
    (12, 16),
    (12, 23),
    (12, 21),
    (12, 18),
    (12, 19),
    (12, 35),
    (12, 36),
    (12, 39),
    (12, 40),
    (12, 41),
    (12, 43),
    (12, 45),
    (12, 46),
    (12, 47),
    (12, 48),
    (12, 49),
    (12, 20);

-- C118 prefacelift
INSERT INTO
    `variant_has_service`
VALUES
    (13, 1),
    (13, 2),
    (13, 3),
    (13, 24),
    (13, 26),
    (13, 6),
    (13, 7),
    (13, 9),
    (13, 10),
    (13, 11),
    (13, 13),
    (13, 14),
    (13, 15),
    (13, 16),
    (13, 39),
    (13, 40),
    (13, 41),
    (13, 48),
    (13, 49),
    (13, 51),
    (13, 52);

-- W209 
INSERT INTO
    `variant_has_service`
VALUES
    (14, 7),
    (14, 27),
    (14, 28),
    (14, 10),
    (14, 11),
    (14, 29),
    (14, 30),
    (14, 31),
    (14, 32),
    (14, 13),
    (14, 14),
    (14, 15),
    (14, 16),
    (14, 48),
    (14, 49);

-- W219/C219
INSERT INTO
    `variant_has_service`
VALUES
    (15, 7),
    (15, 27),
    (15, 28),
    (15, 10),
    (15, 11),
    (15, 29),
    (15, 30),
    (15, 31),
    (15, 32),
    (15, 13),
    (15, 14),
    (15, 15),
    (15, 16),
    (15, 48),
    (15, 49);

-- W218/X218
INSERT INTO
    `variant_has_service`
VALUES
    (16, 7),
    (16, 27),
    (16, 28),
    (16, 10),
    (16, 11),
    (16, 29),
    (16, 30),
    (16, 31),
    (16, 32),
    (16, 13),
    (16, 14),
    (16, 15),
    (16, 16),
    (16, 48),
    (16, 49);

-- W211/S211
INSERT INTO
    `variant_has_service`
VALUES
    (17, 7),
    (17, 27),
    (17, 28),
    (17, 10),
    (17, 11),
    (17, 29),
    (17, 30),
    (17, 31),
    (17, 32),
    (17, 13),
    (17, 14),
    (17, 15),
    (17, 16);

-- W212/S212/A207/C207
INSERT INTO
    `variant_has_service`
VALUES
    (18, 1),
    (18, 2),
    (18, 3),
    (18, 5),
    (18, 6),
    (18, 7),
    (18, 10),
    (18, 11),
    (18, 14),
    (18, 15),
    (18, 16);

-- W212 Facelift
INSERT INTO
    `variant_has_service`
VALUES
    (19, 1),
    (19, 7),
    (19, 27),
    (19, 28),
    (19, 10),
    (19, 11),
    (19, 13),
    (19, 14),
    (19, 15),
    (19, 16);

-- W213 Pre-facelift
INSERT INTO
    `variant_has_service`
VALUES
    (20, 1),
    (20, 7),
    (20, 9),
    (20, 28),
    (20, 10),
    (20, 11),
    (20, 13),
    (20, 14),
    (20, 15),
    (20, 16),
    (20, 39),
    (20, 40),
    (20, 41),
    (20, 48),
    (20, 49),
    (20, 50),
    (20, 51),
    (20, 2),
    (20, 20);

-- W213 Facelift
INSERT INTO
    `variant_has_service`
VALUES
    (21, 1),
    (21, 7),
    (21, 9),
    (21, 28),
    (21, 10),
    (21, 11),
    (21, 13),
    (21, 14),
    (21, 15),
    (21, 16),
    (21, 39),
    (21, 40),
    (21, 41),
    (21, 48),
    (21, 49),
    (21, 50),
    (21, 51),
    (21, 2),
    (21, 20),
    (21, 52);

-- W463
INSERT INTO
    `variant_has_service`
VALUES
    (22, 7),
    (22, 27),
    (22, 28),
    (22, 10),
    (22, 11),
    (22, 29),
    (22, 30),
    (22, 31),
    (22, 32),
    (22, 13),
    (22, 14),
    (22, 15),
    (22, 16);

-- X156 prefacelift 
INSERT INTO
    `variant_has_service`
VALUES
    (23, 1),
    (23, 2),
    (23, 3),
    (23, 4),
    (23, 5),
    (23, 29),
    (23, 6),
    (23, 7),
    (23, 8),
    (23, 9),
    (23, 10),
    (23, 11),
    (23, 12),
    (23, 13),
    (23, 14),
    (23, 15),
    (23, 16),
    (23, 17),
    (23, 18),
    (23, 19),
    (23, 34),
    (23, 36),
    (23, 39),
    (23, 40),
    (23, 41),
    (23, 42),
    (23, 44),
    (23, 45),
    (23, 46),
    (23, 48),
    (23, 49),
    (23, 20);

-- X156 facelift
INSERT INTO
    `variant_has_service`
VALUES
    (24, 1),
    (24, 2),
    (24, 3),
    (24, 4),
    (24, 5),
    (24, 29),
    (24, 6),
    (24, 7),
    (24, 8),
    (24, 9),
    (24, 10),
    (24, 11),
    (24, 12),
    (24, 13),
    (24, 14),
    (24, 15),
    (24, 16),
    (24, 21),
    (24, 23),
    (24, 18),
    (24, 19),
    (24, 35),
    (24, 36),
    (24, 39),
    (24, 40),
    (24, 41),
    (24, 43),
    (24, 45),
    (24, 46),
    (24, 48),
    (24, 49),
    (24, 20);

-- X157 prefacelift
INSERT INTO
    `variant_has_service`
VALUES
    (25, 1),
    (25, 2),
    (25, 3),
    (25, 24),
    (25, 26),
    (25, 6),
    (25, 9),
    (25, 10),
    (25, 11),
    (25, 13),
    (25, 14),
    (25, 15),
    (25, 16),
    (25, 40),
    (25, 41),
    (25, 48),
    (25, 49),
    (25, 51),
    (25, 52);

-- W164/X164
INSERT INTO
    `variant_has_service`
VALUES
    (26, 7),
    (26, 27),
    (26, 28),
    (26, 10),
    (26, 11),
    (26, 29),
    (26, 30),
    (26, 31),
    (26, 32),
    (26, 13),
    (26, 14),
    (26, 15),
    (26, 16);

-- W166/X166
INSERT INTO
    `variant_has_service`
VALUES
    (27, 7),
    (27, 27),
    (27, 28),
    (27, 10),
    (27, 11),
    (27, 29),
    (27, 30),
    (27, 31),
    (27, 32),
    (27, 13),
    (27, 14),
    (27, 15),
    (27, 16),
    (27, 48),
    (27, 49);

-- W251
INSERT INTO
    `variant_has_service`
VALUES
    (28, 7),
    (28, 27),
    (28, 28),
    (28, 10),
    (28, 11),
    (28, 29),
    (28, 30),
    (28, 31),
    (28, 32),
    (28, 13),
    (28, 14),
    (28, 15),
    (28, 16);

-- S221/W216
INSERT INTO
    `variant_has_service`
VALUES
    (29, 7),
    (29, 27),
    (29, 28),
    (29, 10),
    (29, 11),
    (29, 29),
    (29, 30),
    (29, 31),
    (29, 32),
    (29, 13),
    (29, 14),
    (29, 15),
    (29, 16);

-- S222/W217
INSERT INTO
    `variant_has_service`
VALUES
    (30, 1),
    (30, 7),
    (30, 27),
    (30, 28),
    (30, 10),
    (30, 11),
    (30, 13),
    (30, 14),
    (30, 15),
    (30, 16),
    (30, 48),
    (30, 49);

-- R171
INSERT INTO
    `variant_has_service`
VALUES
    (31, 7),
    (31, 27),
    (31, 28),
    (31, 10),
    (31, 11),
    (31, 29),
    (31, 30),
    (31, 31),
    (31, 32),
    (31, 13),
    (31, 14),
    (31, 15),
    (31, 16);

-- R172
INSERT INTO
    `variant_has_service`
VALUES
    (32, 1),
    (32, 7),
    (32, 27),
    (32, 10),
    (32, 11),
    (32, 38),
    (32, 2),
    (32, 31),
    (32, 32),
    (32, 5),
    (32, 13),
    (32, 14),
    (32, 15),
    (32, 16),
    (32, 48),
    (32, 49);

-- R230
INSERT INTO
    `variant_has_service`
VALUES
    (33, 7),
    (33, 27),
    (33, 28),
    (33, 10),
    (33, 11),
    (33, 29),
    (33, 30),
    (33, 31),
    (33, 32),
    (33, 13),
    (33, 14),
    (33, 15),
    (33, 16);

-- R231
INSERT INTO
    `variant_has_service`
VALUES
    (34, 1),
    (34, 7),
    (34, 27),
    (34, 10),
    (34, 11),
    (34, 38),
    (34, 2),
    (34, 31),
    (34, 32),
    (34, 5),
    (34, 13),
    (34, 14),
    (34, 15),
    (34, 16),
    (34, 48),
    (34, 49);

-- W447
INSERT INTO
    `variant_has_service`
VALUES
    (35, 1),
    (35, 2),
    (35, 7),
    (35, 27),
    (35, 3),
    (35, 10),
    (35, 11),
    (35, 13),
    (35, 14),
    (35, 15),
    (35, 16),
    (35, 48),
    (35, 49);

-- DESMARCA LA CASILLA "Habilite la revision de las claves foraneas"