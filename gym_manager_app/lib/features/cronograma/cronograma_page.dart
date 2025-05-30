import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';

class CronogramaPage extends StatefulWidget {
  const CronogramaPage({super.key});

  @override
  State<CronogramaPage> createState() => _CronogramaPageState();
}

class _CronogramaPageState extends State<CronogramaPage> {
  final refeicaoController = TextEditingController();
  final descricaoController = TextEditingController();

  List<Map<String, String>> listaRefeicoes = [];

  @override
  void dispose() {
    refeicaoController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  void _adicionarRefeicao() {
    final refeicao = refeicaoController.text.trim();
    final descricao = descricaoController.text.trim();

    if (refeicao.isNotEmpty && descricao.isNotEmpty) {
      setState(() {
        listaRefeicoes.add({
          'refeicao': refeicao,
          'descricao': descricao,
        });
      });

      refeicaoController.clear();
      descricaoController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Refeição adicionada com sucesso! ✅')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Alimentação 🍽️',
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () => _mostrarAjuda(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Seu cronograma alimentar 🥗",
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),

            // Campo Refeição
            _buildCampo("Tipo de refeição (Ex: Almoço)", refeicaoController),
            const SizedBox(height: 12),

            // Campo Descrição
            _buildCampo("O que será consumido?", descricaoController),
            const SizedBox(height: 20),

            // Botão adicionar
            ElevatedButton(
              onPressed: _adicionarRefeicao,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Adicionar refeição",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              "Refeições da semana 🍛",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: listaRefeicoes.length,
                itemBuilder: (_, index) {
                  final refeicao = listaRefeicoes[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.restaurant_menu),
                    title: Text(
                      refeicao['refeicao'] ?? '',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      refeicao['descricao'] ?? '',
                      style: GoogleFonts.poppins(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Campo de texto padrão
  Widget _buildCampo(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Ajuda popup
  void _mostrarAjuda(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("❓ Dúvidas sobre o cronograma"),
        content: Text(
          "• Aqui você pode cadastrar refeições importantes para sua dieta.\n"
          "• Use o campo de descrição para detalhar alimentos, porções, horários.\n"
          "• No futuro, poderá montar cronogramas por dia da semana 🧠",
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
}
