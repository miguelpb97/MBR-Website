SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Tabla consultas
CREATE TABLE IF NOT EXISTS `consultas` (
  `id_consulta` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL DEFAULT current_timestamp(),
  `nombre` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(20),
  `modelo` VARCHAR(75),
  `mensaje` TEXT NOT NULL,
  `leido` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`id_consulta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla service
CREATE TABLE IF NOT EXISTS `service` (
  `id_service` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `description` VARCHAR(200) NULL,
  `price` DECIMAL(10,2) NULL,
  `image_url` VARCHAR(100) NULL,
  `stock` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`id_service`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla vehicle
CREATE TABLE IF NOT EXISTS `vehicle` (
  `id_vehicle` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `image_url` VARCHAR(100) NULL,
  PRIMARY KEY (`id_vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla variant
CREATE TABLE IF NOT EXISTS `variant` (
  `id_variant` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `image_url` VARCHAR(100) NULL,
  `vehicle_id` INT NOT NULL,
  PRIMARY KEY (`id_variant`),
  INDEX (`vehicle_id`),
  CONSTRAINT `fk_variant_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle`(`id_vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla variant_has_service
CREATE TABLE IF NOT EXISTS `variant_has_service` (
  `variant_id` INT NOT NULL,
  `service_id` INT NOT NULL,
  PRIMARY KEY (`variant_id`, `service_id`),
  INDEX (`service_id`),
  CONSTRAINT `fk_vhi_service` FOREIGN KEY (`service_id`) REFERENCES `service`(`id_service`),
  CONSTRAINT `fk_vhi_variant` FOREIGN KEY (`variant_id`) REFERENCES `variant`(`id_variant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
