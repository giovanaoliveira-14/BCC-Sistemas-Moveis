<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Content-Type: application/json");
header("Access-Control-Allow-Headers: Content-Type");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "app_academia";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Erro de conexão com o banco."]);
    exit();
}

$input = json_decode(file_get_contents("php://input"), true);

if (!isset($input['email']) || !isset($input['senha'])) {
    echo json_encode(["success" => false, "message" => "Email ou senha não fornecidos."]);
    exit();
}

$email = trim($input['email']);
$senha = $input['senha'];

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode(["success" => false, "message" => "Email inválido."]);
    exit();
}

$stmt = $conn->prepare("SELECT id, nome, senha, peso, altura, genero, objetivo FROM usuarios WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();

    if (password_verify($senha, $user['senha'])) {
        echo json_encode([
            "success" => true,
            "message" => "Login bem-sucedido!",
            "user" => [
                "id" => $user["id"],
                "nome" => $user["nome"],
                "email" => $email,
                "peso" => $user["peso"],
                "altura" => $user["altura"],
                "genero" => $user["genero"],
                "objetivo" => $user["objetivo"]
            ]
        ]);
    } else {
        echo json_encode(["success" => false, "message" => "Senha incorreta."]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Usuário não encontrado."]);
}

$stmt->close();
$conn->close();
?>
