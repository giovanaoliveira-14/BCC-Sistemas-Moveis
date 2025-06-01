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
    echo json_encode(["success" => false, "message" => "Erro na conexão."]);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);
$userId = $data['user_id'] ?? null;

if (!$userId) {
    echo json_encode(["success" => false, "message" => "ID do usuário não fornecido."]);
    exit;
}

$stmt = $conn->prepare("SELECT tipo_treino, tempo_treino, data FROM treinos WHERE user_id = ? ORDER BY data DESC");
$stmt->bind_param("i", $userId);
$stmt->execute();
$result = $stmt->get_result();

$treinos = [];

while ($row = $result->fetch_assoc()) {
    $treinos[] = $row;
}

echo json_encode(["success" => true, "treinos" => $treinos]);

$stmt->close();
$conn->close();
?>
