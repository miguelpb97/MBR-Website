<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="./img/mbr_logo_new.ico" type="image/x-icon" />
    <link rel="mask-icon" href="./img/mbr_logo_new.svg" color="#000000" />
    <title>Web en mantenimiento - MBR Almería</title>

    <!-- Fuente -->
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Cormorant Garamond', serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            color: #fff;
            background: #121417;
            position: relative;
        }

        /* Iluminación ambiental */
        body::before,
        body::after {
            content: '';
            position: absolute;
            border-radius: 50%;
            filter: blur(120px);
            opacity: .12;
            pointer-events: none;
        }

        body::before {
            width: 500px;
            height: 500px;
            background: #2563eb;
            top: -220px;
            left: -180px;
        }

        body::after {
            width: 450px;
            height: 450px;
            background: #3b82f6;
            bottom: -180px;
            right: -180px;
        }

        .container {
            position: relative;
            z-index: 2;
            width: min(90%, 760px);
            text-align: center;
            padding: 65px 55px;
            background: #1a1d21;
            border: 1px solid rgba(255, 255, 255, .06);
            border-radius: 22px;
            box-shadow:
                0 25px 60px rgba(0, 0, 0, .55),
                inset 0 0 0 1px rgba(255, 255, 255, .02);
        }

        .icon {
            font-size: 4rem;
            color: #4ea1ff;
            margin-bottom: 30px;
            animation: rotate 12s linear infinite;
        }

        h1 {
            font-size: 4rem;
            font-weight: 600;
            color: #ffffff;
            letter-spacing: 1px;
            margin-bottom: 18px;
        }

        .line {
            width: 90px;
            height: 2px;
            margin: 0 auto 35px;
            background: #3b82f6;
        }

        p {
            font-size: 1.45rem;
            line-height: 1.8;
            color: #b8c0ca;
            max-width: 620px;
            margin: 0 auto 40px;
        }

        strong {
            color: #ffffff;
        }

        .footer {
            font-size: 1.15rem;
            color: #5ea7ff;
            letter-spacing: .8px;
        }

        @keyframes rotate {
            from {
                transform: rotate(0deg);
            }

            to {
                transform: rotate(360deg);
            }
        }

        @media (max-width:768px) {

            .container {
                padding: 45px 28px;
            }

            h1 {
                font-size: 2.8rem;
            }

            p {
                font-size: 1.2rem;
            }

            .icon {
                font-size: 3rem;
            }

        }
    </style>
</head>

<body>

    <div class="container">

        <div class="icon">⚙</div>

        <h1>Estamos mejorando la web</h1>

        <div class="line"></div>

        <p>
            Estamos realizando tareas de actualización y mejora para ofrecer una experiencia
            más rápida, moderna y eficiente.
            <br><br>
            Volveremos a estar disponibles muy pronto.
        </p>

        <div class="footer">
            Gracias por tu paciencia.
        </div>

    </div>

</body>

</html>