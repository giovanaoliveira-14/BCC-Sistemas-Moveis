<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST, OPTIONS");

$host = "localhost";
$db = "app_academia";
$user = "root";
$pass = "";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Erro de conexão.']);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);

$email = trim($data['email'] ?? '');
$nome = trim($data['nome'] ?? '');
$peso = $data['peso'] ?? '';
$altura = $data['altura'] ?? '';
$genero = trim($data['genero'] ?? '');
$objetivo = trim($data['objetivo'] ?? '');

if (!$email || !$nome) {
    echo json_encode(['success' => false, 'message' => 'Campos obrigatórios ausentes.']);
    exit;
}

$stmt = $conn->prepare("UPDATE usuarios SET nome = ?, peso = ?, altura = ?, genero = ?, objetivo = ? WHERE email = ?");
$stmt->bind_param("ssssss", $nome, $peso, $altura, $genero, $objetivo, $email);

if ($stmt->execute()) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'message' => 'Erro ao atualizar.']);
}

$stmt->close();
$conn->close();
?>
