<?php
$host = 'localhost';
$user = 'root';
$pass = '';
$db = 'academia_db';

$conn = new mysqli($host, $user, $pass, $db);

$nome = $_POST['nome'];
$email = $_POST['email'];
$senha = $_POST['senha'];
$peso = $_POST['peso'];
$altura = $_POST['altura'];
$genero = $_POST['genero'];
$objetivo = $_POST['objetivo'];

$sql = "INSERT INTO usuarios (nome, email, senha, peso, altura, genero, objetivo)
        VALUES ('$nome', '$email', '$senha', '$peso', '$altura', '$genero', '$objetivo')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['status' => 'error']);
}
?>
