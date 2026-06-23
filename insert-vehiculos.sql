SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Vehiculos (id_vehicle, name, image_url)
INSERT INTO `vehicle` (`id_vehicle`, `name`, `image_url`) VALUES
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
INSERT INTO `variant` (`id_variant`, `name`, `image_url`, `vehicle_id`) VALUES
(1, 'W176 Pre-facelift', 'W176PF.png', 1),
(2, 'W176 Facelift', 'W176FL.png', 1),
(3, 'W177 Pre-facelift', 'W177PF.png', 1),
(5, 'W246 Pre-facelift', 'W246PF.png', 2),
(6, 'W246 Facelift', 'W246FL.png', 2),
(7, 'W247 Pre-facelift', 'W247PF.png', 2),
(8, 'W203/S203', 'W203.png', 3),
(9, 'W204/S204/X204', 'W204.png', 3),
(10, 'W204/S204/X204 Facelift', 'W204FL.png', 3),
(11, 'W205/S205/X253', 'W205.png', 3),
(12, 'C117/X117 Pre-facelift', 'C117PF.png', 4),
(13, 'C117/X117 Facelift', 'C117FL.png', 4),
(14, 'C118/X118 Pre-facelift', 'C118PF.png', 4),
(15, 'W209', 'W209.png', 5),
(16, 'W219/C219', 'W219.png', 6),
(17, 'W218/C218', 'W218.png', 6),
(18, 'W211/S211', 'W211.png', 7),
(19, 'W212/S212/A207/C207', 'W212.png', 7),
(20, 'W212 Facelift', 'W212FL.png', 7),
(21, 'W213', 'W213.png', 7),
(22, 'W463', 'W463.png', 8),
(23, 'X156 Pre-facelift', 'X156PF.png', 9),
(24, 'X156 Facelift', 'X156FL.png', 9),
(25, 'X157 Pre-facelift', 'X157PF.png', 9),
(26, 'W164/X164', 'X164.png', 10),
(27, 'W166/X166', 'W166.png', 11),
(28, 'W251', 'W251.png', 12),
(29, 'S221/W216', 'S221.png', 13),
(30, 'S222/W217', 'W222.png', 13),
(31, 'R171', 'R171.png', 14),
(32, 'R172', 'R172.png', 14),
(33, 'R230', 'R230.png', 15),
(34, 'R231', 'R231.png', 15),
(35, 'W447', 'W447.png', 16);


-- Servicios (id_service, name, descripcion, price, image_url, stock) 
INSERT INTO service (id_service, name, description, price, image_url, stock) VALUES
(1, 'Coding Desactivar Start-Stop automático', 'Mediante este coding, su vehículo no activará el Start/Stop automático cada vez que arranque. Lo hacemos mediante el método oficial, sin manipular cableado original ni añadir aparatos "bypass".', 50.00, 'startStop.png', 1),
(2, 'Coding Alarma perimetral EDW', 'Te activamos la alarma perimetral EDW. Se activa cuando detecta la apertura de cualquier puerta del vehículo estando bloqueado. El 90% de los vehículos de la marca no incorporan este extra de serie.', 50.00, 'EDW.png', 1),
(3, 'Coding Visualizar presión neumáticos de kPa a bar', 'Cambiamos la unidad de medición de la presión de los neumáticos en tu cuadro de instrumentos de kPa a bar.', 30.00, 'kpaBar.png', 1),
(4, 'Coding Pitido al bloquear el vehículo', 'Breve pitido al bloquear el vehículo. Te activamos el menú para dicha función en el cuadro de instrumentos para activarla o desactivarla cuando lo desees.', 30.00, 'pitidoDesbloquearVehiculo.png', 0),
(5, 'Coding Sonido de parktronic en el rango amarillo', 'Hacemos que tu parktronic avise acústicamente en el rango amarillo. (De serie solo "pita" en el rango rojo).', 30.00, 'sonidoParktronicRangoAmarillo.png', 0),
(6, 'Coding Intermitentes 3 a 6 pulsaciones', 'Al usar la función rápida del intermitente, en vez de 3 pulsaciones, hará 6 (valor personalizable).', 30.00, 'intermitentes.png', 1),
(7, 'Coding Desactivar aviso acústico del cinturón de seguridad', 'Desactivamos el aviso acústico del cinturón de seguridad emitido por el cuadro de instrumentos (el aviso visual y acústico permanece activo).', 30.00, 'avisoAcusticoCinturon.png', 1),
(8, 'Coding Test de agujas al dar contacto', 'Algunos vehículos no disponen de dicha función dependiendo del equipamiento y/o año. Compatible con la plataforma MFA de 2013 a 2018 y otros modelos.', 30.00, 'testAgujas.png', 1),
(9, 'Coding Aviso tapa combustible abierta', 'Si inicia la marcha con la tapa de combustible abierta, se mostrará un aviso en el cuadro de instrumentos.', 30.00, 'avisoTapaCombustible.png', 1),
(10, 'Deslimitar velocidad máxima (No AMG)', 'Eliminamos la limitación electrónica de velocidad máxima de su vehículo.', 100.00, 'noLimit.png', 1),
(11, 'Deslimitar velocidad máxima (AMG)', 'Eliminamos la limitación electrónica de velocidad máxima de su vehículo AMG de 250 km/h.', 100.00, 'noLimitAMG.pmg', 1),
(12, 'Coding Emotion Start (AMG)', 'Breves pops and bangs al arrancar, solo con el motor a temperatura de servicio.', 70.00, 'emotionStart.png', 1),
(13, 'Comprobar kilometraje real', '¿Dudas sobre si el kilometraje de su vehículo ha sido manipulado? Te ayudamos a descubrirlo.', 50.00, 'comprobarKmReales.png', 1),
(14, 'Diagnóstico básico', 'Lectura y/o borrado de fallos.', 30.00, 'diagBasico.png', 1),
(15, 'Diagnóstico avanzado', 'Lectura y/o borrado de fallos, valores reales, test de componentes, etc.', NULL, 'diagAvanzado.png', 1),
(16, 'Ayuda con Retrofit', 'Te ayudamos con cualquier retrofit que requiera SCN Coding. El precio puede variar en función de la dificultad del mismo.', NULL, 'ayudaRetrofit.png', 1),
(17, 'Retrofit NTG5.0, NTG5S1 o Garmin', 'Si tu vehículo tiene NTG 4.5 o 4.7, te ayudamos a reequipar NTG5.0, NTG5S1 o Garmin.', NULL, 'retrofitNTG4aNTG5MFA.png', 1),
(18, 'Retrofit Cámara visión trasera original', 'Reequipamos la cámara de visión trasera original, código SA 218.', NULL, 'camaraTraseraMFA.png', 1),
(19, 'Retrofit Espejos plegables eléctricamente', 'Reequipamos el extra de espejos plegables eléctricamente, código SA 500.', NULL, 'espejosElectricos.png', 1),
(20, 'Coding Activación de Apple CarPlay/Android Auto', 'Activamos dicha función si tu unidad NTG es compatible.', 50.00, 'carPlay.png', 1),
(21, 'Coding Alargar tiempo luces de bienvenida', 'Alargamos la duración de dicha animación a 8 segundos (tiempo personalizable).', 30.00, 'lucesBienvenida.png', 1),
(22, 'Coding Activar menú de luces ambiente en radio', 'Si tu vehículo es compatible, activamos dicho menú en la unidad NTG y realizamos el coding requerido en la unidad SAM.', 30.00, 'menuLucesAmbiente.png', 1),
(23, 'Retrofit Comand NTG5S1', 'Si tu vehículo tiene NTG 5.0 o Garmin, te ayudamos a reequipar una unidad NTG5S1.', NULL, 'retrofitComandNTG5.png', 1),
(24, 'Coding Luces cortas al abrir el vehículo', 'Al desbloquear el vehículo, se encenderán las luces cortas.', 30.00, 'lucesCortasAbrirVehiculo.png', 0),
(26, 'Coding Memoria de modo de conducción', 'Con este coding, tu coche memorizará el último modo de conducción utilizado para el siguiente arranque, sin límite de tiempo (por defecto, memoriza durante 4 horas).', 50.00, 'memoriaModoConduccion.png', 1),
(27, 'Coding Mostrar litros de combustible restantes', 'El cuadro de instrumentos mostrará la cantidad de litros de combustible restantes en el depósito.', 30.00, 'litrosRestantes.png', 1),
(28, 'Coding Mostrar rango de km restantes', 'Con esta activación siempre se mostrará el rango restante en km en lugar del icono de repostar.', 30.00, 'rangoKmRestantes.png', 0),
(29, 'Coding Cambio de volumen y frecuencia del parktronic', 'Cambiamos el volumen y la frecuencia del aviso acústico del sistema Parktronic.', 30.00, 'volumenParktronic.png', 1),
(30, 'Coding Usar luces de niebla para los giros', 'Al realizar giros, se encenderá la luz antiniebla correspondiente al lado del giro.', 30.00, 'luzNieblaGiros.png', 0),
(31, 'Coding Alargar tiempo retardo de apagado unidad radio', 'Alargamos el tiempo que tarda la unidad en apagarse después de quitar el contacto.', 30.00, 'retardoApagadoComand.png', 0),
(32, 'Coding Permitir reproducción de vídeo en movimiento en la unidad radio', 'Activamos la reproducción de vídeo en movimiento en tu unidad Comand.', 30.00, 'videoMovimientoComand.png', 0),
(34, 'Retrofit Aireadores con luces ambiente', 'Retrofit de aireadores con luces ambiente personalizables desde una app.', NULL, 'aireadoresLuzAmbienteNTG.png', 1),
(35, 'Retrofit Aireadores con luces ambiente', 'Retrofit de aireadores con luces ambiente personalizables desde la unidad de radio NTG.', NULL, 'aireadoresLuzAmbienteBluetooth.png', 1),
(36, 'Retrofit Limpiaparabrisas automático', 'Requiere cambio de sensor, incluido en el precio.', NULL, 'limpiaAuto.png', 1),
(38, 'Coding Intermitente al realizar giro', 'Al realizar un giro, se activa automáticamente el intermitente correspondiente en la dirección del giro.', 30.00, 'intermitenteRealizarGiro.png', 0),
(39, 'Coding Luces largas automáticas IHC', 'Si tu vehículo dispone de reconocimiento de señales de tráfico, podemos activar esta función adicionalmente si no dispone de ella.', 70.00, 'IHC.png', 1),
(40, 'Pack coding básico', 'Pack de coding básico para modelos en los que la cantidad de servicios de coding es muy reducida.', 150.00, 'packCodingBasico.png', 0),
(41, 'Pack coding avanzado', 'Pack de coding avanzado para modelos en los que la cantidad de servicios de coding es más amplia.', 200.00, 'packCodingAvanzado.png', 0),
(42, 'Coding Faros halógenos a bixenón', 'Si vas a reequipar dichos faros, te ayudamos a codificarlos.', NULL, 'halogenosaXenon.png', 1),
(43, 'Coding Faros halógenos a LED', 'Si vas a reequipar dichos faros, te ayudamos a codificarlos.', NULL, 'halogenosaLED.png', 1),
(44, 'Coding Faros bixenón a LED', 'Si vas a reequipar dichos faros, te ayudamos a codificarlos.', NULL, 'bixenonaLED.png', 1),
(45, 'Coding A/C permanente', 'Siempre que enciendas la climatización, se activará automáticamente el modo A/C.', 30.00, 'ACauto.png', 1),
(46, 'Coding Recirculación de aire permanente', 'Siempre que enciendas la climatización, se activará automáticamente la recirculación de aire.', 30.00, 'recirculacionAire.png', 1),
(47, 'Coding Luces traseras diurnas', 'Con este coding, los faros traseros también se encenderán junto con las luces diurnas.', 30.00, 'lucesTraserasEncendidasEnDiurno.png', 1),
(48, 'Coding Renovar cuadro de instrumentos', 'Si has instalado un cuadro de instrumentos usado, te ayudamos a virginizarlo y emparejarlo con la EZS.', 130.00, 'renovarIC.png', 1),
(49, 'Coding Menú AMG en cuadro de instrumentos', 'Codificamos el menú AMG en tu cuadro de instrumentos.', 100.00, 'menuAMGCluster.png', 1);


-- Relaciones entre servicios/items y variantes (variant_id, service_id)
-- W176 prefacelift
INSERT INTO `variant_has_service` VALUES(1,1);
INSERT INTO `variant_has_service` VALUES(1,2);
INSERT INTO `variant_has_service` VALUES(1,3);
INSERT INTO `variant_has_service` VALUES(1,4);
INSERT INTO `variant_has_service` VALUES(1,5);
INSERT INTO `variant_has_service` VALUES(1,29);
INSERT INTO `variant_has_service` VALUES(1,6);
INSERT INTO `variant_has_service` VALUES(1,7);
INSERT INTO `variant_has_service` VALUES(1,8);
INSERT INTO `variant_has_service` VALUES(1,9);
INSERT INTO `variant_has_service` VALUES(1,10);
INSERT INTO `variant_has_service` VALUES(1,11);
INSERT INTO `variant_has_service` VALUES(1,12);
INSERT INTO `variant_has_service` VALUES(1,13);
INSERT INTO `variant_has_service` VALUES(1,14);
INSERT INTO `variant_has_service` VALUES(1,15);
INSERT INTO `variant_has_service` VALUES(1,16);
INSERT INTO `variant_has_service` VALUES(1,17);
INSERT INTO `variant_has_service` VALUES(1,18);
INSERT INTO `variant_has_service` VALUES(1,19);
INSERT INTO `variant_has_service` VALUES(1,34);
INSERT INTO `variant_has_service` VALUES(1,36);
INSERT INTO `variant_has_service` VALUES(1,39);
INSERT INTO `variant_has_service` VALUES(1,40);
INSERT INTO `variant_has_service` VALUES(1,41);
INSERT INTO `variant_has_service` VALUES(1,42);
INSERT INTO `variant_has_service` VALUES(1,44);
INSERT INTO `variant_has_service` VALUES(1,45);
INSERT INTO `variant_has_service` VALUES(1,46);
INSERT INTO `variant_has_service` VALUES(1,48);
INSERT INTO `variant_has_service` VALUES(1,49);
INSERT INTO `variant_has_service` VALUES(1,20);

-- W176 facelift
INSERT INTO `variant_has_service` VALUES(2,1);
INSERT INTO `variant_has_service` VALUES(2,2);
INSERT INTO `variant_has_service` VALUES(2,3);
INSERT INTO `variant_has_service` VALUES(2,4);
INSERT INTO `variant_has_service` VALUES(2,5);
INSERT INTO `variant_has_service` VALUES(2,29);
INSERT INTO `variant_has_service` VALUES(2,6);
INSERT INTO `variant_has_service` VALUES(2,7);
INSERT INTO `variant_has_service` VALUES(2,8);
INSERT INTO `variant_has_service` VALUES(2,9);
INSERT INTO `variant_has_service` VALUES(2,10);
INSERT INTO `variant_has_service` VALUES(2,11);
INSERT INTO `variant_has_service` VALUES(2,12);
INSERT INTO `variant_has_service` VALUES(2,13);
INSERT INTO `variant_has_service` VALUES(2,14);
INSERT INTO `variant_has_service` VALUES(2,15);
INSERT INTO `variant_has_service` VALUES(2,16);
INSERT INTO `variant_has_service` VALUES(2,21);
INSERT INTO `variant_has_service` VALUES(2,23);
INSERT INTO `variant_has_service` VALUES(2,18);
INSERT INTO `variant_has_service` VALUES(2,19);
INSERT INTO `variant_has_service` VALUES(2,35);
INSERT INTO `variant_has_service` VALUES(2,36);
INSERT INTO `variant_has_service` VALUES(2,39);
INSERT INTO `variant_has_service` VALUES(2,40);
INSERT INTO `variant_has_service` VALUES(2,41);
INSERT INTO `variant_has_service` VALUES(2,43);
INSERT INTO `variant_has_service` VALUES(2,45);
INSERT INTO `variant_has_service` VALUES(2,46);
INSERT INTO `variant_has_service` VALUES(2,49);
INSERT INTO `variant_has_service` VALUES(2,20);

-- W177 prefacelift
INSERT INTO `variant_has_service` VALUES(3,1);
INSERT INTO `variant_has_service` VALUES(3,2);
INSERT INTO `variant_has_service` VALUES(3,3);
INSERT INTO `variant_has_service` VALUES(3,24);
INSERT INTO `variant_has_service` VALUES(3,26);
INSERT INTO `variant_has_service` VALUES(3,6);
INSERT INTO `variant_has_service` VALUES(3,7);
INSERT INTO `variant_has_service` VALUES(3,9);
INSERT INTO `variant_has_service` VALUES(3,10);
INSERT INTO `variant_has_service` VALUES(3,11);
INSERT INTO `variant_has_service` VALUES(3,13);
INSERT INTO `variant_has_service` VALUES(3,14);
INSERT INTO `variant_has_service` VALUES(3,15);
INSERT INTO `variant_has_service` VALUES(3,16);
INSERT INTO `variant_has_service` VALUES(3,39);
INSERT INTO `variant_has_service` VALUES(3,40);
INSERT INTO `variant_has_service` VALUES(3,41);
INSERT INTO `variant_has_service` VALUES(3,48);
INSERT INTO `variant_has_service` VALUES(3,49);
INSERT INTO `variant_has_service` VALUES(3,20);


-- W246 prefacelift
INSERT INTO `variant_has_service` VALUES(5,1);
INSERT INTO `variant_has_service` VALUES(5,2);
INSERT INTO `variant_has_service` VALUES(5,3);
INSERT INTO `variant_has_service` VALUES(5,4);
INSERT INTO `variant_has_service` VALUES(5,5);
INSERT INTO `variant_has_service` VALUES(5,29);
INSERT INTO `variant_has_service` VALUES(5,6);
INSERT INTO `variant_has_service` VALUES(5,7);
INSERT INTO `variant_has_service` VALUES(5,8);
INSERT INTO `variant_has_service` VALUES(5,9);
INSERT INTO `variant_has_service` VALUES(5,10);
INSERT INTO `variant_has_service` VALUES(5,13);
INSERT INTO `variant_has_service` VALUES(5,14);
INSERT INTO `variant_has_service` VALUES(5,15);
INSERT INTO `variant_has_service` VALUES(5,16);
INSERT INTO `variant_has_service` VALUES(5,17);
INSERT INTO `variant_has_service` VALUES(5,18);
INSERT INTO `variant_has_service` VALUES(5,19);
INSERT INTO `variant_has_service` VALUES(5,36);
INSERT INTO `variant_has_service` VALUES(5,39);
INSERT INTO `variant_has_service` VALUES(5,40);
INSERT INTO `variant_has_service` VALUES(5,41);
INSERT INTO `variant_has_service` VALUES(5,42);
INSERT INTO `variant_has_service` VALUES(5,44);
INSERT INTO `variant_has_service` VALUES(5,45);
INSERT INTO `variant_has_service` VALUES(5,46);
INSERT INTO `variant_has_service` VALUES(5,48);
INSERT INTO `variant_has_service` VALUES(5,49);
INSERT INTO `variant_has_service` VALUES(5,20);

-- W246 facelift
INSERT INTO `variant_has_service` VALUES(6,1);
INSERT INTO `variant_has_service` VALUES(6,2);
INSERT INTO `variant_has_service` VALUES(6,3);
INSERT INTO `variant_has_service` VALUES(6,4);
INSERT INTO `variant_has_service` VALUES(6,5);
INSERT INTO `variant_has_service` VALUES(6,29);
INSERT INTO `variant_has_service` VALUES(6,6);
INSERT INTO `variant_has_service` VALUES(6,7);
INSERT INTO `variant_has_service` VALUES(6,8);
INSERT INTO `variant_has_service` VALUES(6,9);
INSERT INTO `variant_has_service` VALUES(6,10);
INSERT INTO `variant_has_service` VALUES(6,13);
INSERT INTO `variant_has_service` VALUES(6,14);
INSERT INTO `variant_has_service` VALUES(6,15);
INSERT INTO `variant_has_service` VALUES(6,16);
INSERT INTO `variant_has_service` VALUES(6,23);
INSERT INTO `variant_has_service` VALUES(6,21);
INSERT INTO `variant_has_service` VALUES(6,18);
INSERT INTO `variant_has_service` VALUES(6,19);
INSERT INTO `variant_has_service` VALUES(6,36);
INSERT INTO `variant_has_service` VALUES(6,39);
INSERT INTO `variant_has_service` VALUES(6,40);
INSERT INTO `variant_has_service` VALUES(6,41);
INSERT INTO `variant_has_service` VALUES(6,43);
INSERT INTO `variant_has_service` VALUES(6,45);
INSERT INTO `variant_has_service` VALUES(6,46);
INSERT INTO `variant_has_service` VALUES(6,48);
INSERT INTO `variant_has_service` VALUES(6,49);
INSERT INTO `variant_has_service` VALUES(6,20);

-- W247 prefacelift
INSERT INTO `variant_has_service` VALUES(7,1);
INSERT INTO `variant_has_service` VALUES(7,2);
INSERT INTO `variant_has_service` VALUES(7,3);
INSERT INTO `variant_has_service` VALUES(7,24);
INSERT INTO `variant_has_service` VALUES(7,26);
INSERT INTO `variant_has_service` VALUES(7,6);
INSERT INTO `variant_has_service` VALUES(7,7);
INSERT INTO `variant_has_service` VALUES(7,9);
INSERT INTO `variant_has_service` VALUES(7,10);
INSERT INTO `variant_has_service` VALUES(7,13);
INSERT INTO `variant_has_service` VALUES(7,14);
INSERT INTO `variant_has_service` VALUES(7,15);
INSERT INTO `variant_has_service` VALUES(7,16);
INSERT INTO `variant_has_service` VALUES(7,39);
INSERT INTO `variant_has_service` VALUES(7,40);
INSERT INTO `variant_has_service` VALUES(7,41);

-- W203/S203
INSERT INTO `variant_has_service` VALUES(8,7);
INSERT INTO `variant_has_service` VALUES(8,27);
INSERT INTO `variant_has_service` VALUES(8,28);
INSERT INTO `variant_has_service` VALUES(8,10);
INSERT INTO `variant_has_service` VALUES(8,11);
INSERT INTO `variant_has_service` VALUES(8,29);
INSERT INTO `variant_has_service` VALUES(8,30);
INSERT INTO `variant_has_service` VALUES(8,31);
INSERT INTO `variant_has_service` VALUES(8,32);
INSERT INTO `variant_has_service` VALUES(8,48);

-- W204/S204/X204
INSERT INTO `variant_has_service` VALUES(9,1);
INSERT INTO `variant_has_service` VALUES(9,7);
INSERT INTO `variant_has_service` VALUES(9,27);
INSERT INTO `variant_has_service` VALUES(9,28);
INSERT INTO `variant_has_service` VALUES(9,10);
INSERT INTO `variant_has_service` VALUES(9,11);
INSERT INTO `variant_has_service` VALUES(9,29);
INSERT INTO `variant_has_service` VALUES(9,30);
INSERT INTO `variant_has_service` VALUES(9,31);
INSERT INTO `variant_has_service` VALUES(9,32);
INSERT INTO `variant_has_service` VALUES(9,48);
INSERT INTO `variant_has_service` VALUES(9,49);

-- W204/S204/X204 Facelift
INSERT INTO `variant_has_service` VALUES(10,1);
INSERT INTO `variant_has_service` VALUES(10,7);
INSERT INTO `variant_has_service` VALUES(10,27);
INSERT INTO `variant_has_service` VALUES(10,28);
INSERT INTO `variant_has_service` VALUES(10,10);
INSERT INTO `variant_has_service` VALUES(10,11);
INSERT INTO `variant_has_service` VALUES(10,29);
INSERT INTO `variant_has_service` VALUES(10,30);
INSERT INTO `variant_has_service` VALUES(10,31);
INSERT INTO `variant_has_service` VALUES(10,32);
INSERT INTO `variant_has_service` VALUES(10,33);
INSERT INTO `variant_has_service` VALUES(10,48);
INSERT INTO `variant_has_service` VALUES(10,49);

-- W205/S205/X253
INSERT INTO `variant_has_service` VALUES(11,1);
INSERT INTO `variant_has_service` VALUES(11,2);
INSERT INTO `variant_has_service` VALUES(11,20);
INSERT INTO `variant_has_service` VALUES(11,3);
INSERT INTO `variant_has_service` VALUES(11,6);
INSERT INTO `variant_has_service` VALUES(11,7);
INSERT INTO `variant_has_service` VALUES(11,27);
INSERT INTO `variant_has_service` VALUES(11,28);
INSERT INTO `variant_has_service` VALUES(11,10);
INSERT INTO `variant_has_service` VALUES(11,11);
INSERT INTO `variant_has_service` VALUES(11,29);
INSERT INTO `variant_has_service` VALUES(11,30);
INSERT INTO `variant_has_service` VALUES(11,31);
INSERT INTO `variant_has_service` VALUES(11,32);
INSERT INTO `variant_has_service` VALUES(11,33);
INSERT INTO `variant_has_service` VALUES(11,39);
INSERT INTO `variant_has_service` VALUES(11,40);
INSERT INTO `variant_has_service` VALUES(11,41);
INSERT INTO `variant_has_service` VALUES(11,48);
INSERT INTO `variant_has_service` VALUES(11,49);

-- C117/X117 prefacelift
INSERT INTO `variant_has_service` VALUES(12,1);
INSERT INTO `variant_has_service` VALUES(12,2);
INSERT INTO `variant_has_service` VALUES(12,3);
INSERT INTO `variant_has_service` VALUES(12,4);
INSERT INTO `variant_has_service` VALUES(12,5);
INSERT INTO `variant_has_service` VALUES(12,29);
INSERT INTO `variant_has_service` VALUES(12,6);
INSERT INTO `variant_has_service` VALUES(12,7);
INSERT INTO `variant_has_service` VALUES(12,8);
INSERT INTO `variant_has_service` VALUES(12,9);
INSERT INTO `variant_has_service` VALUES(12,10);
INSERT INTO `variant_has_service` VALUES(12,11);
INSERT INTO `variant_has_service` VALUES(12,12);
INSERT INTO `variant_has_service` VALUES(12,13);
INSERT INTO `variant_has_service` VALUES(12,14);
INSERT INTO `variant_has_service` VALUES(12,15);
INSERT INTO `variant_has_service` VALUES(12,16);
INSERT INTO `variant_has_service` VALUES(12,17);
INSERT INTO `variant_has_service` VALUES(12,18);
INSERT INTO `variant_has_service` VALUES(12,19);
INSERT INTO `variant_has_service` VALUES(12,34);
INSERT INTO `variant_has_service` VALUES(12,36);
INSERT INTO `variant_has_service` VALUES(12,39);
INSERT INTO `variant_has_service` VALUES(12,40);
INSERT INTO `variant_has_service` VALUES(12,41);
INSERT INTO `variant_has_service` VALUES(12,42);
INSERT INTO `variant_has_service` VALUES(12,44);
INSERT INTO `variant_has_service` VALUES(12,45);
INSERT INTO `variant_has_service` VALUES(12,46);
INSERT INTO `variant_has_service` VALUES(12,47);
INSERT INTO `variant_has_service` VALUES(12,48);
INSERT INTO `variant_has_service` VALUES(12,49);
INSERT INTO `variant_has_service` VALUES(12,20);

-- C117/X117 facelift
INSERT INTO `variant_has_service` VALUES(13,1);
INSERT INTO `variant_has_service` VALUES(13,2);
INSERT INTO `variant_has_service` VALUES(13,3);
INSERT INTO `variant_has_service` VALUES(13,4);
INSERT INTO `variant_has_service` VALUES(13,5);
INSERT INTO `variant_has_service` VALUES(13,29);
INSERT INTO `variant_has_service` VALUES(13,6);
INSERT INTO `variant_has_service` VALUES(13,7);
INSERT INTO `variant_has_service` VALUES(13,8);
INSERT INTO `variant_has_service` VALUES(13,9);
INSERT INTO `variant_has_service` VALUES(13,10);
INSERT INTO `variant_has_service` VALUES(13,11);
INSERT INTO `variant_has_service` VALUES(13,12);
INSERT INTO `variant_has_service` VALUES(13,13);
INSERT INTO `variant_has_service` VALUES(13,14);
INSERT INTO `variant_has_service` VALUES(13,15);
INSERT INTO `variant_has_service` VALUES(13,16);
INSERT INTO `variant_has_service` VALUES(13,23);
INSERT INTO `variant_has_service` VALUES(13,21);
INSERT INTO `variant_has_service` VALUES(13,18);
INSERT INTO `variant_has_service` VALUES(13,19);
INSERT INTO `variant_has_service` VALUES(13,35);
INSERT INTO `variant_has_service` VALUES(13,36);
INSERT INTO `variant_has_service` VALUES(13,39);
INSERT INTO `variant_has_service` VALUES(13,40);
INSERT INTO `variant_has_service` VALUES(13,41);
INSERT INTO `variant_has_service` VALUES(13,43);
INSERT INTO `variant_has_service` VALUES(13,45);
INSERT INTO `variant_has_service` VALUES(13,46);
INSERT INTO `variant_has_service` VALUES(13,47);
INSERT INTO `variant_has_service` VALUES(13,48);
INSERT INTO `variant_has_service` VALUES(13,49);
INSERT INTO `variant_has_service` VALUES(13,20);

-- C118 prefacelift
INSERT INTO `variant_has_service` VALUES(14,1);
INSERT INTO `variant_has_service` VALUES(14,2);
INSERT INTO `variant_has_service` VALUES(14,3);
INSERT INTO `variant_has_service` VALUES(14,24);
INSERT INTO `variant_has_service` VALUES(14,26);
INSERT INTO `variant_has_service` VALUES(14,6);
INSERT INTO `variant_has_service` VALUES(14,7);
INSERT INTO `variant_has_service` VALUES(14,9);
INSERT INTO `variant_has_service` VALUES(14,10);
INSERT INTO `variant_has_service` VALUES(14,11);
INSERT INTO `variant_has_service` VALUES(14,13);
INSERT INTO `variant_has_service` VALUES(14,14);
INSERT INTO `variant_has_service` VALUES(14,15);
INSERT INTO `variant_has_service` VALUES(14,16);
INSERT INTO `variant_has_service` VALUES(14,39);
INSERT INTO `variant_has_service` VALUES(14,40);
INSERT INTO `variant_has_service` VALUES(14,41);
INSERT INTO `variant_has_service` VALUES(14,48);
INSERT INTO `variant_has_service` VALUES(14,49);

-- W209 
INSERT INTO `variant_has_service` VALUES(15,7);
INSERT INTO `variant_has_service` VALUES(15,27);
INSERT INTO `variant_has_service` VALUES(15,28);
INSERT INTO `variant_has_service` VALUES(15,10);
INSERT INTO `variant_has_service` VALUES(15,11);
INSERT INTO `variant_has_service` VALUES(15,29);
INSERT INTO `variant_has_service` VALUES(15,30);
INSERT INTO `variant_has_service` VALUES(15,31);
INSERT INTO `variant_has_service` VALUES(15,32);
INSERT INTO `variant_has_service` VALUES(15,13);
INSERT INTO `variant_has_service` VALUES(15,14);
INSERT INTO `variant_has_service` VALUES(15,15);
INSERT INTO `variant_has_service` VALUES(15,16);
INSERT INTO `variant_has_service` VALUES(15,48);
INSERT INTO `variant_has_service` VALUES(15,49);

-- W219/C219
INSERT INTO `variant_has_service` VALUES(16,7);
INSERT INTO `variant_has_service` VALUES(16,27);
INSERT INTO `variant_has_service` VALUES(16,28);
INSERT INTO `variant_has_service` VALUES(16,10);
INSERT INTO `variant_has_service` VALUES(16,11);
INSERT INTO `variant_has_service` VALUES(16,29);
INSERT INTO `variant_has_service` VALUES(16,30);
INSERT INTO `variant_has_service` VALUES(16,31);
INSERT INTO `variant_has_service` VALUES(16,32);
INSERT INTO `variant_has_service` VALUES(16,13);
INSERT INTO `variant_has_service` VALUES(16,14);
INSERT INTO `variant_has_service` VALUES(16,15);
INSERT INTO `variant_has_service` VALUES(16,16);
INSERT INTO `variant_has_service` VALUES(16,48);
INSERT INTO `variant_has_service` VALUES(16,49);

-- W218/X218
INSERT INTO `variant_has_service` VALUES(17,7);
INSERT INTO `variant_has_service` VALUES(17,27);
INSERT INTO `variant_has_service` VALUES(17,28);
INSERT INTO `variant_has_service` VALUES(17,10);
INSERT INTO `variant_has_service` VALUES(17,11);
INSERT INTO `variant_has_service` VALUES(17,29);
INSERT INTO `variant_has_service` VALUES(17,30);
INSERT INTO `variant_has_service` VALUES(17,31);
INSERT INTO `variant_has_service` VALUES(17,32);
INSERT INTO `variant_has_service` VALUES(17,13);
INSERT INTO `variant_has_service` VALUES(17,14);
INSERT INTO `variant_has_service` VALUES(17,15);
INSERT INTO `variant_has_service` VALUES(17,16);
INSERT INTO `variant_has_service` VALUES(17,48);
INSERT INTO `variant_has_service` VALUES(17,49);

-- W211/S211
INSERT INTO `variant_has_service` VALUES(18,7);
INSERT INTO `variant_has_service` VALUES(18,27);
INSERT INTO `variant_has_service` VALUES(18,28);
INSERT INTO `variant_has_service` VALUES(18,10);
INSERT INTO `variant_has_service` VALUES(18,11);
INSERT INTO `variant_has_service` VALUES(18,29);
INSERT INTO `variant_has_service` VALUES(18,30);
INSERT INTO `variant_has_service` VALUES(18,31);
INSERT INTO `variant_has_service` VALUES(18,32);
INSERT INTO `variant_has_service` VALUES(18,13);
INSERT INTO `variant_has_service` VALUES(18,14);
INSERT INTO `variant_has_service` VALUES(18,15);
INSERT INTO `variant_has_service` VALUES(18,16);

-- W212/S212/A207/C207
INSERT INTO `variant_has_service` VALUES(19,1);
INSERT INTO `variant_has_service` VALUES(19,2);
INSERT INTO `variant_has_service` VALUES(19,3);
INSERT INTO `variant_has_service` VALUES(19,5);
INSERT INTO `variant_has_service` VALUES(19,6);
INSERT INTO `variant_has_service` VALUES(19,7);
INSERT INTO `variant_has_service` VALUES(19,10);
INSERT INTO `variant_has_service` VALUES(19,11);
INSERT INTO `variant_has_service` VALUES(19,14);
INSERT INTO `variant_has_service` VALUES(19,15);
INSERT INTO `variant_has_service` VALUES(19,16);

-- W212 Facelift
INSERT INTO `variant_has_service` VALUES(20,1);
INSERT INTO `variant_has_service` VALUES(20,7);
INSERT INTO `variant_has_service` VALUES(20,27);
INSERT INTO `variant_has_service` VALUES(20,28);
INSERT INTO `variant_has_service` VALUES(20,10);
INSERT INTO `variant_has_service` VALUES(20,11);
INSERT INTO `variant_has_service` VALUES(20,13);
INSERT INTO `variant_has_service` VALUES(20,14);
INSERT INTO `variant_has_service` VALUES(20,15);
INSERT INTO `variant_has_service` VALUES(20,16);

-- W213 Facelift
INSERT INTO `variant_has_service` VALUES(21,1);
INSERT INTO `variant_has_service` VALUES(21,7);
INSERT INTO `variant_has_service` VALUES(21,27);
INSERT INTO `variant_has_service` VALUES(21,28);
INSERT INTO `variant_has_service` VALUES(21,10);
INSERT INTO `variant_has_service` VALUES(21,11);
INSERT INTO `variant_has_service` VALUES(21,13);
INSERT INTO `variant_has_service` VALUES(21,14);
INSERT INTO `variant_has_service` VALUES(21,15);
INSERT INTO `variant_has_service` VALUES(21,16);
INSERT INTO `variant_has_service` VALUES(21,39);
INSERT INTO `variant_has_service` VALUES(21,40);
INSERT INTO `variant_has_service` VALUES(21,41);
INSERT INTO `variant_has_service` VALUES(21,48);
INSERT INTO `variant_has_service` VALUES(21,49);

-- W463
INSERT INTO `variant_has_service` VALUES(22,7);
INSERT INTO `variant_has_service` VALUES(22,27);
INSERT INTO `variant_has_service` VALUES(22,28);
INSERT INTO `variant_has_service` VALUES(22,10);
INSERT INTO `variant_has_service` VALUES(22,11);
INSERT INTO `variant_has_service` VALUES(22,29);
INSERT INTO `variant_has_service` VALUES(22,30);
INSERT INTO `variant_has_service` VALUES(22,31);
INSERT INTO `variant_has_service` VALUES(22,32);
INSERT INTO `variant_has_service` VALUES(22,13);
INSERT INTO `variant_has_service` VALUES(22,14);
INSERT INTO `variant_has_service` VALUES(22,15);
INSERT INTO `variant_has_service` VALUES(22,16);

-- X156 prefacelift 
INSERT INTO `variant_has_service` VALUES(23,1);
INSERT INTO `variant_has_service` VALUES(23,2);
INSERT INTO `variant_has_service` VALUES(23,3);
INSERT INTO `variant_has_service` VALUES(23,4);
INSERT INTO `variant_has_service` VALUES(23,5);
INSERT INTO `variant_has_service` VALUES(23,29);
INSERT INTO `variant_has_service` VALUES(23,6);
INSERT INTO `variant_has_service` VALUES(23,7);
INSERT INTO `variant_has_service` VALUES(23,8);
INSERT INTO `variant_has_service` VALUES(23,9);
INSERT INTO `variant_has_service` VALUES(23,10);
INSERT INTO `variant_has_service` VALUES(23,11);
INSERT INTO `variant_has_service` VALUES(23,12);
INSERT INTO `variant_has_service` VALUES(23,13);
INSERT INTO `variant_has_service` VALUES(23,14);
INSERT INTO `variant_has_service` VALUES(23,15);
INSERT INTO `variant_has_service` VALUES(23,16);
INSERT INTO `variant_has_service` VALUES(23,17);
INSERT INTO `variant_has_service` VALUES(23,18);
INSERT INTO `variant_has_service` VALUES(23,19);
INSERT INTO `variant_has_service` VALUES(23,34);
INSERT INTO `variant_has_service` VALUES(23,36);
INSERT INTO `variant_has_service` VALUES(23,39);
INSERT INTO `variant_has_service` VALUES(23,40);
INSERT INTO `variant_has_service` VALUES(23,41);
INSERT INTO `variant_has_service` VALUES(23,42);
INSERT INTO `variant_has_service` VALUES(23,44);
INSERT INTO `variant_has_service` VALUES(23,45);
INSERT INTO `variant_has_service` VALUES(23,46);
INSERT INTO `variant_has_service` VALUES(23,48);
INSERT INTO `variant_has_service` VALUES(23,49);
INSERT INTO `variant_has_service` VALUES(23,20);

-- X156 facelift
INSERT INTO `variant_has_service` VALUES(24,1);
INSERT INTO `variant_has_service` VALUES(24,2);
INSERT INTO `variant_has_service` VALUES(24,3);
INSERT INTO `variant_has_service` VALUES(24,4);
INSERT INTO `variant_has_service` VALUES(24,5);
INSERT INTO `variant_has_service` VALUES(24,29);
INSERT INTO `variant_has_service` VALUES(24,6);
INSERT INTO `variant_has_service` VALUES(24,7);
INSERT INTO `variant_has_service` VALUES(24,8);
INSERT INTO `variant_has_service` VALUES(24,9);
INSERT INTO `variant_has_service` VALUES(24,10);
INSERT INTO `variant_has_service` VALUES(24,11);
INSERT INTO `variant_has_service` VALUES(24,12);
INSERT INTO `variant_has_service` VALUES(24,13);
INSERT INTO `variant_has_service` VALUES(24,14);
INSERT INTO `variant_has_service` VALUES(24,15);
INSERT INTO `variant_has_service` VALUES(24,16);
INSERT INTO `variant_has_service` VALUES(24,21);
INSERT INTO `variant_has_service` VALUES(24,23);
INSERT INTO `variant_has_service` VALUES(24,18);
INSERT INTO `variant_has_service` VALUES(24,19);
INSERT INTO `variant_has_service` VALUES(24,35);
INSERT INTO `variant_has_service` VALUES(24,36);
INSERT INTO `variant_has_service` VALUES(24,39);
INSERT INTO `variant_has_service` VALUES(24,40);
INSERT INTO `variant_has_service` VALUES(24,41);
INSERT INTO `variant_has_service` VALUES(24,43);
INSERT INTO `variant_has_service` VALUES(24,45);
INSERT INTO `variant_has_service` VALUES(24,46);
INSERT INTO `variant_has_service` VALUES(24,48);
INSERT INTO `variant_has_service` VALUES(24,49);
INSERT INTO `variant_has_service` VALUES(24,20);

-- X157 prefacelift
INSERT INTO `variant_has_service` VALUES(25,1);
INSERT INTO `variant_has_service` VALUES(25,2);
INSERT INTO `variant_has_service` VALUES(25,3);
INSERT INTO `variant_has_service` VALUES(25,24);
INSERT INTO `variant_has_service` VALUES(25,26);
INSERT INTO `variant_has_service` VALUES(25,6);
INSERT INTO `variant_has_service` VALUES(25,7);
INSERT INTO `variant_has_service` VALUES(25,9);
INSERT INTO `variant_has_service` VALUES(25,10);
INSERT INTO `variant_has_service` VALUES(25,11);
INSERT INTO `variant_has_service` VALUES(25,13);
INSERT INTO `variant_has_service` VALUES(25,14);
INSERT INTO `variant_has_service` VALUES(25,15);
INSERT INTO `variant_has_service` VALUES(25,16);
INSERT INTO `variant_has_service` VALUES(25,39);
INSERT INTO `variant_has_service` VALUES(25,40);
INSERT INTO `variant_has_service` VALUES(25,41);
INSERT INTO `variant_has_service` VALUES(25,48);
INSERT INTO `variant_has_service` VALUES(25,49);

-- W164/X164
INSERT INTO `variant_has_service` VALUES(26,7);
INSERT INTO `variant_has_service` VALUES(26,27);
INSERT INTO `variant_has_service` VALUES(26,28);
INSERT INTO `variant_has_service` VALUES(26,10);
INSERT INTO `variant_has_service` VALUES(26,11);
INSERT INTO `variant_has_service` VALUES(26,29);
INSERT INTO `variant_has_service` VALUES(26,30);
INSERT INTO `variant_has_service` VALUES(26,31);
INSERT INTO `variant_has_service` VALUES(26,32);
INSERT INTO `variant_has_service` VALUES(26,13);
INSERT INTO `variant_has_service` VALUES(26,14);
INSERT INTO `variant_has_service` VALUES(26,15);
INSERT INTO `variant_has_service` VALUES(26,16);

-- W166/X166
INSERT INTO `variant_has_service` VALUES(27,7);
INSERT INTO `variant_has_service` VALUES(27,27);
INSERT INTO `variant_has_service` VALUES(27,28);
INSERT INTO `variant_has_service` VALUES(27,10);
INSERT INTO `variant_has_service` VALUES(27,11);
INSERT INTO `variant_has_service` VALUES(27,29);
INSERT INTO `variant_has_service` VALUES(27,30);
INSERT INTO `variant_has_service` VALUES(27,31);
INSERT INTO `variant_has_service` VALUES(27,32);
INSERT INTO `variant_has_service` VALUES(27,13);
INSERT INTO `variant_has_service` VALUES(27,14);
INSERT INTO `variant_has_service` VALUES(27,15);
INSERT INTO `variant_has_service` VALUES(27,16);
INSERT INTO `variant_has_service` VALUES(27,48);
INSERT INTO `variant_has_service` VALUES(27,49);

-- W251
INSERT INTO `variant_has_service` VALUES(28,7);
INSERT INTO `variant_has_service` VALUES(28,27);
INSERT INTO `variant_has_service` VALUES(28,28);
INSERT INTO `variant_has_service` VALUES(28,10);
INSERT INTO `variant_has_service` VALUES(28,11);
INSERT INTO `variant_has_service` VALUES(28,29);
INSERT INTO `variant_has_service` VALUES(28,30);
INSERT INTO `variant_has_service` VALUES(28,31);
INSERT INTO `variant_has_service` VALUES(28,32);
INSERT INTO `variant_has_service` VALUES(28,13);
INSERT INTO `variant_has_service` VALUES(28,14);
INSERT INTO `variant_has_service` VALUES(28,15);
INSERT INTO `variant_has_service` VALUES(28,16);

-- S221/W216
INSERT INTO `variant_has_service` VALUES(29,7);
INSERT INTO `variant_has_service` VALUES(29,27);
INSERT INTO `variant_has_service` VALUES(29,28);
INSERT INTO `variant_has_service` VALUES(29,10);
INSERT INTO `variant_has_service` VALUES(29,11);
INSERT INTO `variant_has_service` VALUES(29,29);
INSERT INTO `variant_has_service` VALUES(29,30);
INSERT INTO `variant_has_service` VALUES(29,31);
INSERT INTO `variant_has_service` VALUES(29,32);
INSERT INTO `variant_has_service` VALUES(29,13);
INSERT INTO `variant_has_service` VALUES(29,14);
INSERT INTO `variant_has_service` VALUES(29,15);
INSERT INTO `variant_has_service` VALUES(29,16);

-- S222/W217
INSERT INTO `variant_has_service` VALUES(30,1);
INSERT INTO `variant_has_service` VALUES(30,7);
INSERT INTO `variant_has_service` VALUES(30,27);
INSERT INTO `variant_has_service` VALUES(30,28);
INSERT INTO `variant_has_service` VALUES(30,10);
INSERT INTO `variant_has_service` VALUES(30,11);
INSERT INTO `variant_has_service` VALUES(30,13);
INSERT INTO `variant_has_service` VALUES(30,14);
INSERT INTO `variant_has_service` VALUES(30,15);
INSERT INTO `variant_has_service` VALUES(30,16);
INSERT INTO `variant_has_service` VALUES(30,48);
INSERT INTO `variant_has_service` VALUES(30,49);

-- R171
INSERT INTO `variant_has_service` VALUES(31,7);
INSERT INTO `variant_has_service` VALUES(31,27);
INSERT INTO `variant_has_service` VALUES(31,28);
INSERT INTO `variant_has_service` VALUES(31,10);
INSERT INTO `variant_has_service` VALUES(31,11);
INSERT INTO `variant_has_service` VALUES(31,29);
INSERT INTO `variant_has_service` VALUES(31,30);
INSERT INTO `variant_has_service` VALUES(31,31);
INSERT INTO `variant_has_service` VALUES(31,32);
INSERT INTO `variant_has_service` VALUES(31,13);
INSERT INTO `variant_has_service` VALUES(31,14);
INSERT INTO `variant_has_service` VALUES(31,15);
INSERT INTO `variant_has_service` VALUES(31,16);

-- R172
INSERT INTO `variant_has_service` VALUES(32,1);
INSERT INTO `variant_has_service` VALUES(32,7);
INSERT INTO `variant_has_service` VALUES(32,27);
INSERT INTO `variant_has_service` VALUES(32,10);
INSERT INTO `variant_has_service` VALUES(32,11);
INSERT INTO `variant_has_service` VALUES(32,38);
INSERT INTO `variant_has_service` VALUES(32,2);
INSERT INTO `variant_has_service` VALUES(32,31);
INSERT INTO `variant_has_service` VALUES(32,32);
INSERT INTO `variant_has_service` VALUES(32,5);
INSERT INTO `variant_has_service` VALUES(32,13);
INSERT INTO `variant_has_service` VALUES(32,14);
INSERT INTO `variant_has_service` VALUES(32,15);
INSERT INTO `variant_has_service` VALUES(32,16);
INSERT INTO `variant_has_service` VALUES(32,48);
INSERT INTO `variant_has_service` VALUES(32,49);

-- R230
INSERT INTO `variant_has_service` VALUES(33,7);
INSERT INTO `variant_has_service` VALUES(33,27);
INSERT INTO `variant_has_service` VALUES(33,28);
INSERT INTO `variant_has_service` VALUES(33,10);
INSERT INTO `variant_has_service` VALUES(33,11);
INSERT INTO `variant_has_service` VALUES(33,29);
INSERT INTO `variant_has_service` VALUES(33,30);
INSERT INTO `variant_has_service` VALUES(33,31);
INSERT INTO `variant_has_service` VALUES(33,32);
INSERT INTO `variant_has_service` VALUES(33,13);
INSERT INTO `variant_has_service` VALUES(33,14);
INSERT INTO `variant_has_service` VALUES(33,15);
INSERT INTO `variant_has_service` VALUES(33,16);

-- R231
INSERT INTO `variant_has_service` VALUES(34,1);
INSERT INTO `variant_has_service` VALUES(34,7);
INSERT INTO `variant_has_service` VALUES(34,27);
INSERT INTO `variant_has_service` VALUES(34,10);
INSERT INTO `variant_has_service` VALUES(34,11);
INSERT INTO `variant_has_service` VALUES(34,38);
INSERT INTO `variant_has_service` VALUES(34,2);
INSERT INTO `variant_has_service` VALUES(34,31);
INSERT INTO `variant_has_service` VALUES(34,32);
INSERT INTO `variant_has_service` VALUES(34,5);
INSERT INTO `variant_has_service` VALUES(34,13);
INSERT INTO `variant_has_service` VALUES(34,14);
INSERT INTO `variant_has_service` VALUES(34,15);
INSERT INTO `variant_has_service` VALUES(34,16);
INSERT INTO `variant_has_service` VALUES(34,48);
INSERT INTO `variant_has_service` VALUES(34,49);

-- W447
INSERT INTO `variant_has_service` VALUES(35,1);
INSERT INTO `variant_has_service` VALUES(35,2);
INSERT INTO `variant_has_service` VALUES(35,7);
INSERT INTO `variant_has_service` VALUES(35,27);
INSERT INTO `variant_has_service` VALUES(35,3);
INSERT INTO `variant_has_service` VALUES(35,10);
INSERT INTO `variant_has_service` VALUES(35,11);
INSERT INTO `variant_has_service` VALUES(35,13);
INSERT INTO `variant_has_service` VALUES(35,14);
INSERT INTO `variant_has_service` VALUES(35,15);
INSERT INTO `variant_has_service` VALUES(35,16);
INSERT INTO `variant_has_service` VALUES(35,48);
INSERT INTO `variant_has_service` VALUES(35,49);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
