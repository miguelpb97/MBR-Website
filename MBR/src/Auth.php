<?php
require_once __DIR__ . '/../cfg/config.php';

class Auth
{
    public static function startSession(): void
    {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
    }

    public static function login(string $user, string $pass): bool
    {
        self::startSession();

        if ($user === ADMIN_USER && $pass === ADMIN_PASS) {

            // Seguridad extra
            session_regenerate_id(true);

            $_SESSION['admin_logged_in'] = true;
            return true;
        }

        return false;
    }

    public static function logout(): void
    {
        self::startSession();

        $_SESSION = [];

        if (ini_get("session.use_cookies")) {
            $params = session_get_cookie_params();
            setcookie(
                session_name(),
                '',
                time() - 42000,
                $params["path"],
                $params["domain"],
                $params["secure"],
                $params["httponly"]
            );
        }

        session_destroy();
    }

    public static function isLoggedIn(): bool
    {
        self::startSession();
        return !empty($_SESSION['admin_logged_in']);
    }

    public static function requireLogin(): void
    {
        self::startSession();

        if (empty($_SESSION['admin_logged_in'])) {
            header('Location: admin_login.php');
            exit;
        }

        // Evitar cache en páginas privadas
        header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
        header("Pragma: no-cache");
        header("Expires: 0");
    }
}
