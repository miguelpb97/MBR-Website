<?php
require_once __DIR__ . '/DatabaseRequests.php';

class ConsultaRepository
{
    private mysqli $conn;

    public function __construct()
    {
        $this->conn = Database::getInstance()->getConnection();
    }

    public function deleteById(int $id): bool
    {
        $stmt = $this->conn->prepare("DELETE FROM consultas WHERE id_consulta = ?");
        $stmt->bind_param('i', $id);
        return $stmt->execute();
    }

    public function toggleRead(int $id): bool
    {
        $stmt = $this->conn->prepare("
            UPDATE consultas 
            SET leido = NOT leido 
            WHERE id_consulta = ?
        ");
        $stmt->bind_param('i', $id);
        return $stmt->execute();
    }


    public function buscarConsultas(string $busqueda, int $pagina, int $porPagina): array
    {
        $offset = ($pagina - 1) * $porPagina;
        $params = [];
        $types = '';

        $where = '';
        if ($busqueda !== '') {
            $like = '%' . $busqueda . '%';
            $where = "WHERE nombre LIKE ? OR email LIKE ? OR telefono LIKE ? OR vin LIKE ?";
            $params = [$like, $like, $like, $like];
            $types = 'ssss';
        }

        // Total
        $sqlTotal = "SELECT COUNT(*) AS total FROM consultas $where";
        $stmtTotal = $this->conn->prepare($sqlTotal);
        if ($where !== '') {
            $stmtTotal->bind_param($types, ...$params);
        }
        $stmtTotal->execute();
        $resTotal = $stmtTotal->get_result()->fetch_assoc();
        $total = (int) $resTotal['total'];

        // Datos paginados
        $sql = "SELECT id_consulta, nombre, email, telefono, modelo, mensaje, leido, fecha
                FROM consultas
                $where
                ORDER BY id_consulta DESC
                LIMIT ? OFFSET ?";

        $params2 = $params;
        $types2 = $types . 'ii';
        $params2[] = $porPagina;
        $params2[] = $offset;

        $stmt = $this->conn->prepare($sql);
        if ($where !== '') {
            $stmt->bind_param($types2, ...$params2);
        } else {
            $stmt->bind_param('ii', $porPagina, $offset);
        }

        $stmt->execute();
        $result = $stmt->get_result();
        $consultas = $result->fetch_all(MYSQLI_ASSOC);

        return [
            'consultas' => $consultas,
            'total' => $total,
        ];
    }

    public function obtenerParaCsv(string $busqueda): mysqli_result
    {
        $params = [];
        $types = '';
        $where = '';

        if ($busqueda !== '') {
            $like = '%' . $busqueda . '%';
            $where = "WHERE nombre LIKE ? OR email LIKE ? OR telefono LIKE ? OR vin LIKE ?";
            $params = [$like, $like, $like, $like];
            $types = 'ssss';
        }

        $sql = "SELECT id_consulta, nombre, email, telefono, modelo, mensaje, leido, fecha
                FROM consultas
                $where
                ORDER BY id_consulta DESC";

        if ($where !== '') {
            $stmt = $this->conn->prepare($sql);
            $stmt->bind_param($types, ...$params);
            $stmt->execute();
            return $stmt->get_result();
        }

        return $this->conn->query($sql);
    }

    public function crearConsulta(string $nombre, string $email, string $telefono, string $modelo, string $mensaje): bool
    {
        $stmt = $this->conn->prepare(
            "INSERT INTO consultas (nombre, email, telefono, modelo, mensaje)
             VALUES (?, ?, ?, ?, ?)"
        );
        $stmt->bind_param('sssss', $nombre, $email, $telefono, $modelo, $mensaje);
        return $stmt->execute();
    }
}
