import 'package:flutter/material.dart';
import 'package:app_academia/services/auth_service.dart';


// Tela de Login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Função de login
 void _login() async {
  String email = _emailController.text;
  String password = _passwordController.text;

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor, preencha todos os campos.')),
    );
    return;
  }

  bool success = await ApiService.login(email, password);
  if (success) {
    Navigator.pushReplacementNamed(context, '/home');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('E-mail ou senha inválidos.')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Cor de fundo
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar transparente
        elevation: 0, // Remove a sombra do AppBar
      ),
      resizeToAvoidBottomInset:
          true, // Garante que o conteúdo se ajuste ao teclado
      body: SingleChildScrollView(
        // Torna a tela rolável
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ), // Padding lateral
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza o conteúdo
          children: [
            const SizedBox(height: 20),
            // Texto de boas-vindas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'Seja Bem-Vindo! Gestão e performance na academia 💪',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Container com largura máxima para os campos
            Container(
              width: double.infinity, // Usa toda a largura disponível
              constraints: const BoxConstraints(
                maxWidth: 320,
              ), // Largura máxima de 320px
              child: Column(
                children: [
                  // Campo de E-mail com bordas arredondadas
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: const TextStyle(color: Color(0xFFF84600)),
                      hintText: 'Digite seu e-mail',
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        // Bordas arredondadas
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 12,
                      ), // Padding interno
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Campo de Senha com bordas arredondadas
                  TextField(
                    controller: _passwordController,
                    obscureText: true, // Oculta o texto da senha
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: const TextStyle(color: Color(0xFFF84600)),
                      hintText: 'Digite sua senha',
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        // Bordas arredondadas
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 12,
                      ), // Padding interno
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Botão de Login
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF84600), // Cor do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // Bordas arredondadas
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ), // Aumenta o padding vertical
                      minimumSize: const Size(
                        double.infinity,
                        50,
                      ), // Garante que o botão ocupe toda a largura
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            // Link para registrar novo usuário
            TextButton(
              onPressed: () {
                // DIRECIONAR
                print('Esqueci a senha');
              },
              child: const Text(
                'Esqueci a senha',
                style: TextStyle(color: Color(0xFFF84600)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Não tem uma conta ainda?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    'Cadastre-se',
                    style: TextStyle(color: Color(0xFFF84600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


