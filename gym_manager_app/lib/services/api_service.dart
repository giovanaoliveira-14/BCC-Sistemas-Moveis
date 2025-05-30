import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost/gestao_app_api';

  // Cadastro de usuário
  static Future<Map<String, dynamic>> cadastrarUsuario(Map<String, dynamic> dados) async {
    final url = Uri.parse('$baseUrl/usuario/cadastrar.php');
    final response = await http.post(
      url,
      body: jsonEncode(dados),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  // Login
  static Future<Map<String, dynamic>> login(String email, String senha) async {
    final url = Uri.parse('$baseUrl/usuario/login.php');
    final response = await http.post(
      url,
      body: jsonEncode({"email": email, "senha": senha}),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }
}
