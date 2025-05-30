import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final generoController = TextEditingController();
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  final objetivoController = TextEditingController();

  void fazerCadastro() async {
    setState(() => loading = true);

    Map<String, dynamic> dados = {
      "nome": nomeController.text.trim(),
      "email": emailController.text.trim(),
      "senha": senhaController.text.trim(),
      "genero": generoSelecionado,
      "peso": double.tryParse(pesoController.text.trim()) ?? 0,
      "altura": double.tryParse(alturaController.text.trim()) ?? 0,
      "objetivo": objetivoController.text.trim(),
    };

    if (dados.values.any((e) => e == null || e == '' || e == 0)) {
      mostrarMensagem("Preencha todos os campos corretamente");
      setState(() => loading = false);
      return;
    }

    final resposta = await ApiService.cadastrarUsuario(dados);

    setState(() => loading = false);

    if (resposta['mensagem'] == "Usuário cadastrado com sucesso") {
      mostrarMensagem("Cadastro realizado! Faça login.");
      Navigator.pop(context); // Voltar para login
    } else {
      mostrarMensagem(resposta['mensagem'] ?? "Erro no cadastro");
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    generoController.dispose();
    pesoController.dispose();
    alturaController.dispose();
    objetivoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Cadastro',
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título
            Text(
              'Faça seu cadastro 🚀',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 24,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            // Campo Nome
            _buildCampo("Nome completo", nomeController),
            const SizedBox(height: 15),

            // Campo E-mail
            _buildCampo("E-mail", emailController),
            const SizedBox(height: 15),

            // Campo Senha
            _buildCampo("Senha", senhaController, isSenha: true),
            const SizedBox(height: 15),

            // Campo Gênero
            _buildCampo("Gênero", generoController),
            const SizedBox(height: 15),

            // Campo Peso
            _buildCampo(
              "Peso (kg)",
              pesoController,
              tipo: TextInputType.number,
            ),
            const SizedBox(height: 15),

            // Campo Altura
            _buildCampo(
              "Altura (cm)",
              alturaController,
              tipo: TextInputType.number,
            ),
            const SizedBox(height: 15),

            // Campo Objetivo
            _buildCampo("Qual seu objetivo na academia?", objetivoController),
            const SizedBox(height: 30),

            // Botão de cadastro
            ElevatedButton(
              onPressed: () {
                // TODO: salvar dados no backend
                print("Usuário cadastrado:");
                print("Nome: ${nomeController.text}");
                print("Email: ${emailController.text}");
                // etc...
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Cadastrar",
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método reutilizável para os campos de texto
  Widget _buildCampo(
    String label,
    TextEditingController controller, {
    bool isSenha = false,
    TextInputType tipo = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isSenha,
      keyboardType: tipo,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
