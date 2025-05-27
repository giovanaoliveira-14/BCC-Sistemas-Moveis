import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost/flutter_api'; 

  static Future<bool> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {
        'email': email,
        'senha': senha,
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['status'] == 'success';
    } else {
      throw Exception('Erro de conexão');
    }
  }

  static Future<bool> register(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register.php'),
      body: userData,
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['status'] == 'success';
    } else {
      throw Exception('Erro de conexão');
    }
  }
}
