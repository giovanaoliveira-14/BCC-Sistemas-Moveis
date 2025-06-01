<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Content-Type: application/json");

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
$periodo = $data['periodo'] ?? '';
$descricao = $data['descricao'] ?? '';

if (!$userId || empty($periodo) || empty($descricao)) {
    echo json_encode(["success" => false, "message" => "Dados incompletos."]);
    exit;
}

$stmt = $conn->prepare("INSERT INTO refeicoes (user_id, periodo, descricao) VALUES (?, ?, ?)");
$stmt->bind_param("iss", $userId, $periodo, $descricao);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "message" => "Erro ao registrar."]);
}

$stmt->close();
$conn->close();
?>
