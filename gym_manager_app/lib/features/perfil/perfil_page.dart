import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final nomeController = TextEditingController(text: 'João Silva');
  final emailController = TextEditingController(text: 'joao@email.com');
  final generoController = TextEditingController(text: 'Masculino');
  final pesoController = TextEditingController(text: '70');
  final alturaController = TextEditingController(text: '1.75');
  final objetivoController = TextEditingController(text: 'Hipertrofia');

  void _salvarPerfil() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dados atualizados com sucesso ✅')),
    );
  }

  void _confirmarExclusao() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("⚠️ Deseja mesmo excluir sua conta?"),
        content: const Text(
            "Essa ação é irreversível e todos os seus dados serão perdidos."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Conta deletada com sucesso ❌')),
              );
              // Aqui você pode navegar para a tela de login ou sair do app
            },
            child: const Text("Excluir"),
          ),
        ],
      ),
    );
  }

  void _mostrarAjuda() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("❓ Dúvidas sobre o perfil"),
        content: Text(
          "• Aqui você pode editar seus dados pessoais.\n"
          "• Use o botão 'Sair' para deslogar do app.\n"
          "• A opção 'Excluir conta' remove permanentemente seus dados. 🚨",
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Fechar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Perfil 🧑',
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: _mostrarAjuda,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              "Seu Perfil 🧑",
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),

            _buildCampo("Nome", nomeController),
            _buildCampo("Email", emailController),
            _buildCampo("Gênero", generoController),
            _buildCampo("Peso (kg)", pesoController),
            _buildCampo("Altura (m)", alturaController),
            _buildCampo("Objetivo", objetivoController),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _salvarPerfil,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: Text("Salvar alterações", style: GoogleFonts.poppins(color: Colors.white)),
            ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: _confirmarExclusao,
              child: Text("Excluir conta", style: TextStyle(color: Colors.red.shade700)),
            ),

            const SizedBox(height: 8),

            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
              },
              child: const Text("Sair do aplicativo"),
            ),
          ],
        ),
      ),
    );
  }

  // Campo reutilizável
  Widget _buildCampo(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
