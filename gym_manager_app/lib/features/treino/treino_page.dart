import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';

class TreinoPage extends StatefulWidget {
  const TreinoPage({super.key});

  @override
  State<TreinoPage> createState() => _TreinoPageState();
}

class _TreinoPageState extends State<TreinoPage> {
  final tipoTreinoController = TextEditingController();
  final duracaoController = TextEditingController();

  List<String> treinosSemana = [
    "Segunda: Peito e Tríceps",
    "Terça: Costas e Bíceps",
    "Quarta: Pernas e Ombro",
    "Quinta: Descanso 💤",
    "Sexta: Cardio e Core",
    "Sábado: Full Body",
    "Domingo: Descanso 🧘‍♂️",
  ];

  @override
  void dispose() {
    tipoTreinoController.dispose();
    duracaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Treinos da Semana 💪',
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Seu treino de hoje 🏋️",
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),

              // Tipo de treino
              _buildCampo("Tipo de treino realizado", tipoTreinoController),
              const SizedBox(height: 12),

              // Duração
              _buildCampo("Duração (em minutos)", duracaoController,
                  tipo: TextInputType.number),
              const SizedBox(height: 20),

              // Botão Registrar
              ElevatedButton(
                onPressed: () {
                  // TODO: salvar no backend
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Treino registrado com sucesso! ✅")),
                  );
                  tipoTreinoController.clear();
                  duracaoController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Registrar treino",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Text(
                "Treinos da semana 📅",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              // Lista de treinos
              for (var treino in treinosSemana)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(
                    treino,
                    style: GoogleFonts.poppins(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Campo de texto padrão
  Widget _buildCampo(String label, TextEditingController controller,
      {TextInputType tipo = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: tipo,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Popup de ajuda
  void _mostrarAjuda(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("❓ Dúvidas sobre treinos"),
        content: Text(
          "• Você pode registrar seu treino diariamente aqui.\n"
          "• A duração ajuda no cálculo de progresso.\n"
          "• A lista da semana é um exemplo — no futuro você poderá personalizar 🧠",
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
