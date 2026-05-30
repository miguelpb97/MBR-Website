-- ============================================================
--  MBR Almería — Tablas de la tienda
--  Ejecutar en phpMyAdmin sobre la misma BD que el proyecto
-- ============================================================

-- Usuarios (registro opcional; el historial también funciona como invitado)
CREATE TABLE IF NOT EXISTS `users` (
  `id_user`       INT          NOT NULL AUTO_INCREMENT,
  `name`          VARCHAR(80)  NOT NULL,
  `email`         VARCHAR(100) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `created_at`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `uq_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Pedidos
CREATE TABLE IF NOT EXISTS `orders` (
  `id_order`         INT           NOT NULL AUTO_INCREMENT,
  `user_id`          INT           NULL,
  `customer_name`    VARCHAR(80)   NOT NULL,
  `customer_email`   VARCHAR(100)  NOT NULL,
  `total`            DECIMAL(10,2) NOT NULL,
  `status`           ENUM('pending','paid','cancelled','refunded') NOT NULL DEFAULT 'pending',
  `paypal_order_id`  VARCHAR(50)   NULL,
  `paypal_capture_id`VARCHAR(50)   NULL,
  `created_at`       DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_address`       VARCHAR(45)   NULL,
  PRIMARY KEY (`id_order`),
  INDEX `idx_email`         (`customer_email`),
  INDEX `idx_paypal_order`  (`paypal_order_id`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`)
    REFERENCES `users`(`id_user`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Líneas de pedido
CREATE TABLE IF NOT EXISTS `order_items` (
  `id_item`      INT           NOT NULL AUTO_INCREMENT,
  `order_id`     INT           NOT NULL,
  `service_id`   INT           NOT NULL,
  `service_name` VARCHAR(80)   NOT NULL,
  `price`        DECIMAL(10,2) NOT NULL,
  `quantity`     INT           NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_item`),
  INDEX `idx_order` (`order_id`),
  CONSTRAINT `fk_item_order`   FOREIGN KEY (`order_id`)   REFERENCES `orders`(`id_order`)  ON DELETE CASCADE,
  CONSTRAINT `fk_item_service` FOREIGN KEY (`service_id`) REFERENCES `service`(`id_service`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
