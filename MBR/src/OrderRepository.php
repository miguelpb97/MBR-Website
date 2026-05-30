<?php
require_once __DIR__ . '/../cfg/config.php';

class OrderRepository
{
    private PDO $pdo;

    public function __construct()
    {
        $this->pdo = getDB();
    }

    // ── Create a paid order (transactional) ───────────────────────
    public function createOrder(
        string  $name,
        string  $email,
        float   $total,
        string  $paypalOrderId,
        string  $paypalCaptureId,
        array   $items,
        ?int    $userId = null,
        ?string $ip     = null
    ): int {
        $this->pdo->beginTransaction();
        try {
            $stmt = $this->pdo->prepare(
                "INSERT INTO orders
                    (user_id, customer_name, customer_email, total, status,
                     paypal_order_id, paypal_capture_id, ip_address)
                 VALUES
                    (:user_id, :name, :email, :total, 'paid',
                     :paypal_order_id, :paypal_capture_id, :ip)"
            );
            $stmt->execute([
                ':user_id'          => $userId,
                ':name'             => $name,
                ':email'            => $email,
                ':total'            => $total,
                ':paypal_order_id'  => $paypalOrderId,
                ':paypal_capture_id'=> $paypalCaptureId,
                ':ip'               => $ip,
            ]);
            $orderId = (int) $this->pdo->lastInsertId();

            $stmtItem = $this->pdo->prepare(
                "INSERT INTO order_items (order_id, service_id, service_name, price, quantity)
                 VALUES (:order_id, :service_id, :name, :price, :quantity)"
            );
            foreach ($items as $item) {
                $stmtItem->execute([
                    ':order_id'   => $orderId,
                    ':service_id' => $item['id'],
                    ':name'       => $item['name'],
                    ':price'      => $item['price'],
                    ':quantity'   => $item['quantity'],
                ]);
            }

            $this->pdo->commit();
            return $orderId;
        } catch (Exception $e) {
            $this->pdo->rollBack();
            throw $e;
        }
    }

    // ── Guard against double-processing the same PayPal order ─────
    public function isAlreadyProcessed(string $paypalOrderId): bool
    {
        $stmt = $this->pdo->prepare(
            "SELECT COUNT(*) FROM orders WHERE paypal_order_id = ? AND status = 'paid'"
        );
        $stmt->execute([$paypalOrderId]);
        return (int) $stmt->fetchColumn() > 0;
    }

    // ── Order history by email ────────────────────────────────────
    public function getByEmail(string $email): array
    {
        $stmt = $this->pdo->prepare(
            "SELECT
                o.id_order,
                o.customer_name,
                o.total,
                o.status,
                o.created_at,
                GROUP_CONCAT(oi.service_name ORDER BY oi.id_item SEPARATOR ', ') AS servicios
             FROM orders o
             LEFT JOIN order_items oi ON oi.order_id = o.id_order
             WHERE o.customer_email = :email
             GROUP BY o.id_order
             ORDER BY o.created_at DESC
             LIMIT 50"
        );
        $stmt->execute([':email' => $email]);
        return $stmt->fetchAll();
    }

    // ── All orders (admin) ────────────────────────────────────────
    public function getAll(int $limit = 25, int $offset = 0): array
    {
        $stmt = $this->pdo->prepare(
            "SELECT
                o.id_order,
                o.customer_name,
                o.customer_email,
                o.total,
                o.status,
                o.created_at,
                COUNT(oi.id_item) AS num_items
             FROM orders o
             LEFT JOIN order_items oi ON oi.order_id = o.id_order
             GROUP BY o.id_order
             ORDER BY o.created_at DESC
             LIMIT :limit OFFSET :offset"
        );
        $stmt->bindValue(':limit',  $limit,  PDO::PARAM_INT);
        $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public function countAll(): int
    {
        return (int) $this->pdo->query("SELECT COUNT(*) FROM orders")->fetchColumn();
    }
}
