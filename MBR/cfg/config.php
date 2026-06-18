<?php

/* BBDD Consultas */
define('DB_HOST', 'localhost');
define('DB_NAME', 'mbr');
define('DB_USER', 'example');
define('DB_PASS', 'example');

/* Admin User */
define('ADMIN_USER', 'admin');
define('ADMIN_PASS', 'example');

/* CloudFlare Keys */
define('CF_SITEKEY', '1x00000000000000000000AA');
define('CF_SECRET', '1x0000000000000000000000000000000AA');

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