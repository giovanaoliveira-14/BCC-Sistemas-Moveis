<?php
$host = 'localhost';
$user = 'root';
$pass = '';
$db = 'academia_db';

$conn = new mysqli($host, $user, $pass, $db);

$email = $_POST['email'];
$senha = $_POST['senha'];

$result = $conn->query("SELECT * FROM usuarios WHERE email = '$email' AND senha = '$senha'");

if ($result->num_rows > 0) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['status' => 'error']);
}
?>
