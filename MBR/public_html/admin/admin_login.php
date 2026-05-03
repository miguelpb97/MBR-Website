<?php
require_once __DIR__ . '/../../src/Auth.php';

Auth::startSession();

$error = null;
$max_intentos = 3;
$tiempo_bloqueo = 600;


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

        if ($_SESSION['intentos'] >= $max_intentos) {
            $_SESSION['bloqueado_hasta'] = time() + $tiempo_bloqueo;
            $error = 'Demasiados intentos fallidos. Usuario bloqueado temporalmente.';
        } else {
            $restantes = $max_intentos - $_SESSION['intentos'];
            $error = "Usuario o contraseña incorrectos. Te quedan $restantes intentos.";
        }
    }
}

require_once __DIR__ . '/../../views/admin/admin_login-view.php';
