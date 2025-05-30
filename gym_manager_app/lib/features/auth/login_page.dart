import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';
import '../../services/api_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});


class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool loading = false;

  void fazerLogin() async {
    setState(() => loading = true);

    final email = emailController.text.trim();
    final senha = senhaController.text.trim();

    if (email.isEmpty || senha.isEmpty) {
      mostrarMensagem("Preencha todos os campos");
      setState(() => loading = false);
      return;
    }

    final resposta = await ApiService.login(email, senha);

    setState(() => loading = false);

    if (resposta.containsKey('id')) {
      // Login OK - pode salvar dados do usuário e ir para Home
      Navigator.pushReplacementNamed(context, '/home', arguments: resposta);
    } else {
      mostrarMensagem(resposta['mensagem'] ?? 'Erro no login');
    }
  }

  void mostrarMensagem(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título com emoji
            Text(
              "Seja Bem-Vindo!\nGestão e performance na academia 💪",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: AppColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            // Campo de e-mail
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Campo de senha
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Botão de entrar
            ElevatedButton(
              onPressed: () {
                // TODO: Ação de login
                print("Email: ${emailController.text}, Senha: ${senhaController.text}");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Entrar",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Link para cadastro
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cadastro');
              },
              child: Text(
                "Ainda não tem cadastro? Clique aqui 🚀",
                style: GoogleFonts.poppins(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
