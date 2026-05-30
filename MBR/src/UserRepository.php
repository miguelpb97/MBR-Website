<?php
require_once __DIR__ . '/../cfg/config.php';

class UserRepository
{
    private PDO $pdo;

    public function __construct()
    {
        $this->pdo = getDB();
    }

    public function emailExists(string $email): bool
    {
        $stmt = $this->pdo->prepare("SELECT COUNT(*) FROM users WHERE email = ?");
        $stmt->execute([$email]);
        return (int) $stmt->fetchColumn() > 0;
    }

    public function register(string $name, string $email, string $password): int
    {
        $hash = password_hash($password, PASSWORD_BCRYPT, ['cost' => 12]);
        $stmt = $this->pdo->prepare(
            "INSERT INTO users (name, email, password_hash) VALUES (?, ?, ?)"
        );
        $stmt->execute([$name, $email, $hash]);
        return (int) $this->pdo->lastInsertId();
    }

    /** Returns user array on success, null on wrong credentials. */
    public function login(string $email, string $password): ?array
    {
        $stmt = $this->pdo->prepare(
            "SELECT id_user, name, email, password_hash FROM users WHERE email = ? LIMIT 1"
        );
        $stmt->execute([$email]);
        $user = $stmt->fetch();
        if (!$user) return null;
        if (!password_verify($password, $user['password_hash'])) return null;
        return $user;
    }
}
