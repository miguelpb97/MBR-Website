<?php
require_once __DIR__ . '/../../src/Auth.php';
require_once __DIR__ . '/../../cfg/config.php';

Auth::startSession();

$error = null;

// Inicializar variables de sesión si no existen
if (!isset($_SESSION['intentos'])) {
    $_SESSION['intentos'] = 0;
}

if (!isset($_SESSION['bloqueado_hasta'])) {
    $_SESSION['bloqueado_hasta'] = 0;
}

// Verificar si está bloqueado
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $_SESSION['bloqueado_hasta'] <= time()) {
    $user = $_POST['usuario'] ?? '';
    $pass = $_POST['password'] ?? '';

    if (Auth::login($user, $pass)) {
        // Resetear intentos si login correcto
        $_SESSION['intentos'] = 0;
        $_SESSION['bloqueado_hasta'] = 0;

        header('Location: admin_requests.php');
        exit;
    } else {
        $_SESSION['intentos']++;

        if ($_SESSION['intentos'] >= MAX_INTENTOS) {
            $_SESSION['bloqueado_hasta'] = time() + TIEMPO_BLOQUEO;
            $error = 'Demasiados intentos fallidos. Usuario bloqueado temporalmente.';
        } else {
            $restantes = MAX_INTENTOS - $_SESSION['intentos'];
            $error = "Usuario o contraseña incorrectos. Te quedan $restantes intentos.";
        }
    }
}

require_once __DIR__ . '/../../views/admin/admin_login-view.php';
