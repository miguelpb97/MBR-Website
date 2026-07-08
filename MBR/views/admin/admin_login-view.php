<?php

/** @var string|null $error */
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>MBR - Login</title>
    <link rel="icon" href="../img/mbr_logo_new.ico" type="image/x-icon" />
    <link rel="mask-icon" href="../img/mbr_logo_new.svg" color="#000000" />
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/admin-panel_styles.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>

<body>
    <form method="POST">
        <h2 id="titulo">Panel de administración</h2>

        <input type="text" name="usuario" placeholder="Usuario" required>

        <div class="password-wrapper">
            <input type="password" id="password" name="password" placeholder="Contraseña" required>
            <i id="togglePassword" class="fa-solid fa-eye toggle-password"></i>
        </div>

        <button type="submit">Entrar</button>

        <?php if (!empty($error)): ?>
            <div class="error"><?= htmlspecialchars($error, ENT_QUOTES, 'UTF-8') ?></div>
        <?php endif; ?>
    </form>
</body>
<script>
    document.getElementById('togglePassword').addEventListener('click', function() {
        const input = document.getElementById('password');

        if (input.type === 'password') {
            input.type = 'text';
            this.classList.remove('fa-eye');
            this.classList.add('fa-eye-slash');
        } else {
            input.type = 'password';
            this.classList.remove('fa-eye-slash');
            this.classList.add('fa-eye');
        }
    });
</script>

</html>