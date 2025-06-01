import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://localhost/flutter_api';

  /// Cadastro
  static Future<bool> register(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/register.php');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['success'] == true;
      }
    } catch (e) {
      print('[API] Erro no cadastro: $e');
    }

    return false;
  }

  /// Login
  static Future<bool> login(String email, String senha) async {
    final url = Uri.parse('$baseUrl/login.php');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "senha": senha}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final user = data['user'];
          final prefs = await SharedPreferences.getInstance();
          prefs.setInt('user_id', data['user']['id']);
          prefs.setString('email', data['user']['email']);
          prefs.setString('nome', data['user']['nome']);

          await prefs.setInt('user_id', user['id']);
          await prefs.setString('user_nome', user['nome']);
          await prefs.setString('user_email', user['email']);
          await prefs.setString('user_genero', user['genero'] ?? '');
          await prefs.setString('user_objetivo', user['objetivo'] ?? '');
          await prefs.setString('user_altura', user['altura'] ?? '');
          await prefs.setString('user_peso', user['peso'] ?? '');

          return true;
        } else {
          print('[API LOGIN] Erro: ${data['message']}');
        }
      } else {
        print('[API LOGIN] Erro HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('[API LOGIN] Erro de rede: $e');
    }

    return false;
  }

  /// Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Remove todos os dados salvos do usuário
  }

  /// Recuperar usuário atual
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('user_id')) return null;

    return {
      'id': prefs.getInt('user_id'),
      'nome': prefs.getString('user_nome'),
      'email': prefs.getString('user_email'),
      'genero': prefs.getString('user_genero'),
      'objetivo': prefs.getString('user_objetivo'),
      'altura': prefs.getString('user_altura'),
      'peso': prefs.getString('user_peso'),
    };
  }

  static Future<bool> updateUser(Map<String, dynamic> data) async {
  final url = Uri.parse('$baseUrl/update_user.php');

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    final body = jsonDecode(response.body);
    return body['success'] == true;
  } catch (e) {
    print('[API] Erro update: $e');
    return false;
  }
}

static Future<bool> deleteUser(String email) async {
  final url = Uri.parse('$baseUrl/delete_user.php');

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email}),
    );

    final body = jsonDecode(response.body);
    return body['success'] == true;
  } catch (e) {
    print('[API] Erro delete: $e');
    return false;
  }
}

static Future<bool> registrarTreino({
  required int userId,
  required String tipo,
  required String tempo,
}) async {
  final url = Uri.parse('$baseUrl/register_treino.php');

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "tipo_treino": tipo,
        "tempo_treino": tempo,
      }),
    );

    final data = jsonDecode(response.body);
    return data['success'] == true;
  } catch (e) {
    print('[API] Erro ao registrar treino: $e');
    return false;
  }
}

static Future<List<Map<String, dynamic>>> listarTreinos(int userId) async {
  final url = Uri.parse('$baseUrl/listar_treinos.php');

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId}),
    );

    final data = jsonDecode(response.body);

    if (data['success'] == true && data['treinos'] != null) {
      return List<Map<String, dynamic>>.from(data['treinos']);
    } else {
      return [];
    }
  } catch (e) {
    print('[API] Erro ao listar treinos: $e');
    return [];
  }
}

/// Registrar uma refeição
static Future<bool> registrarRefeicao({
  required int userId,
  required String periodo,
  required String descricao,
}) async {
  final url = Uri.parse('$baseUrl/register_refeicao.php');

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "periodo": periodo,
        "descricao": descricao,
      }),
    );

    final data = jsonDecode(response.body);
    return data['success'] == true;
  } catch (e) {
    print('[API] Erro ao registrar refeição: $e');
    return false;
  }
}

/// Listar refeições do usuário
static Future<List<Map<String, dynamic>>> listarRefeicoes(int userId) async {
  final url = Uri.parse('$baseUrl/listar_refeicoes.php');

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId}),
    );

    final data = jsonDecode(response.body);

    if (data['success'] == true && data['refeicoes'] != null) {
      return List<Map<String, dynamic>>.from(data['refeicoes']);
    } else {
      return [];
    }
  } catch (e) {
    print('[API] Erro ao listar refeições: $e');
    return [];
  }
}

static Future<List<String>> listarDatasTreino(int userId) async {
  final url = Uri.parse('$baseUrl/listar_datas_treino.php');

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId}),
    );

    final data = jsonDecode(response.body);

    if (data['success'] == true && data['datas'] != null) {
      return List<String>.from(data['datas']);
    } else {
      return [];
    }
  } catch (e) {
    print('[API] Erro ao listar datas de treino: $e');
    return [];
  }
}


}
