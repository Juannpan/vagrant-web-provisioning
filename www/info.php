<?php
// info.php - Versión simplificada
header("Content-Type: text/html; charset=utf-8");

// Configuración - MODIFICA ESTOS VALORES
$db_host = "192.168.56.4";
$db_name = "mi_proyecto";
$db_user = "admin_proyecto";
$db_pass = "contraseñasegura123";

try {
    $pdo = new PDO("pgsql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    echo "<h2>Usuarios en la Base de Datos</h2>";

    $stmt = $pdo->query("SELECT * FROM usuarios ORDER BY id");
    $usuarios = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($usuarios) {
        echo "<table border='1'>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Email</th>
                    <th>Fecha Registro</th>
                </tr>";

        foreach ($usuarios as $usuario) {
            echo "<tr>
                    <td>{$usuario["id"]}</td>
                    <td>{$usuario["nombre"]}</td>
                    <td>{$usuario["email"]}</td>
                    <td>{$usuario["fecha_registro"]}</td>
                  </tr>";
        }
        echo "</table>";
    } else {
        echo "No hay usuarios en la base de datos";
    }
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
