<?php

class CartManager
{
    private static function start(): void
    {
        if (session_status() === PHP_SESSION_NONE) {
            session_set_cookie_params([
                'lifetime' => 0,
                'path'     => '/',
                'secure'   => true,
                'httponly' => true,
                'samesite' => 'Lax',
            ]);
            session_start();
        }
        if (!isset($_SESSION['cart'])) {
            $_SESSION['cart'] = [];
        }
    }

    public static function add(int $id, string $name, float $price, int $qty = 1): void
    {
        self::start();
        if (isset($_SESSION['cart'][$id])) {
            $_SESSION['cart'][$id]['quantity'] += $qty;
        } else {
            $_SESSION['cart'][$id] = [
                'id'       => $id,
                'name'     => $name,
                'price'    => $price,
                'quantity' => $qty,
            ];
        }
    }

    public static function remove(int $id): void
    {
        self::start();
        unset($_SESSION['cart'][$id]);
    }

    public static function clear(): void
    {
        self::start();
        $_SESSION['cart'] = [];
    }

    public static function get(): array
    {
        self::start();
        return array_values($_SESSION['cart']);
    }

    public static function total(): float
    {
        self::start();
        return (float) array_reduce(
            $_SESSION['cart'],
            fn($carry, $item) => $carry + ($item['price'] * $item['quantity']),
            0.0
        );
    }

    public static function count(): int
    {
        self::start();
        return (int) array_sum(array_column($_SESSION['cart'], 'quantity'));
    }

    public static function isEmpty(): bool
    {
        self::start();
        return empty($_SESSION['cart']);
    }
}
