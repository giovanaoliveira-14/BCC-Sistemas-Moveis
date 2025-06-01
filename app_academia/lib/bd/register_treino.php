<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Methods: POST, OPTIONS");


$host = "localhost";
$db = "app_academia";
$user = "root";
$pass = "";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Erro de conexão."]);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);

$userId = $data['user_id'] ?? null;
$tipo = $data['tipo_treino'] ?? '';
$tempo = $data['tempo_treino'] ?? '';

if (!$userId || !$tipo || !$tempo) {
    echo json_encode(["success" => false, "message" => "Campos obrigatórios."]);
    exit;
}

$stmt = $conn->prepare("INSERT INTO treinos (user_id, tipo_treino, tempo_treino) VALUES (?, ?, ?)");
$stmt->bind_param("iss", $userId, $tipo, $tempo);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "message" => "Erro ao registrar treino."]);
}

$stmt->close();
$conn->close();
?>
