<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST, OPTIONS");

// Conexão com o banco de dados
$host = "localhost";
$db = "app_academia";
$user = "root";
$pass = "";
$conn = new mysqli($host, $user, $pass, $db);

// Verifica conexão
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Erro na conexão com o banco de dados.']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);

    if (!$data) {
        echo json_encode(['success' => false, 'message' => 'Dados inválidos.']);
        exit;
    }

    $nome     = trim($data['nome'] ?? '');
    $email    = trim($data['email'] ?? '');
    $senha    = $data['senha'] ?? '';
    $peso     = $data['peso'] ?? '';
    $altura   = $data['altura'] ?? '';
    $genero   = $data['genero'] ?? '';
    $objetivo = trim($data['objetivo'] ?? '');

    // Validações básicas
    if (!$nome || !$email || !$senha || !$peso || !$altura || !$genero || !$objetivo) {
        echo json_encode(['success' => false, 'message' => 'Todos os campos são obrigatórios.']);
        exit;
    }

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo json_encode(['success' => false, 'message' => 'Email inválido.']);
        exit;
    }

    if (!is_numeric($peso) || !is_numeric($altura)) {
        echo json_encode(['success' => false, 'message' => 'Peso e altura devem ser numéricos.']);
        exit;
    }

    // Verifica se o e-mail já está cadastrado
    $check = $conn->prepare("SELECT id FROM usuarios WHERE email = ?");
    $check->bind_param("s", $email);
    $check->execute();
    $result = $check->get_result();

    if ($result->num_rows > 0) {
        echo json_encode(['success' => false, 'message' => 'Email já cadastrado.']);
        exit;
    }

    // Criptografa a senha
    $senhaHash = password_hash($senha, PASSWORD_DEFAULT);

    // Inserção segura
    $stmt = $conn->prepare("INSERT INTO usuarios (nome, email, senha, peso, altura, genero, objetivo)
                            VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssssss", $nome, $email, $senhaHash, $peso, $altura, $genero, $objetivo);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Erro ao cadastrar usuário.']);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Método não permitido']);
}
?>
