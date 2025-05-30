import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import '../../core/constants/colors.dart';

class HomePage extends StatelessWidget {
  final String nomeUsuario;

  HomePage({super.key, this.nomeUsuario = 'Usuário'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Início 🏠",
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _mostrarAjuda(context);
            },
            icon: const Icon(Icons.help_outline, color: Colors.white),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Treino",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: "Alimentação",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
        onTap: (index) {
          // TODO: Navegar entre as telas
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Saudação com nome
            Text(
              "Seja bem-vindo, $nomeUsuario 👋",
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),

            // Dias de ofensiva
            Text(
              "Você teve 4 dias de ofensiva na academia essa semana 🔥",
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 32),

            // Botão Treino
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/treino');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Visualize seu treino de hoje →",
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            // Botão Cronograma Alimentar
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/alimentacao');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Visualize seu cronograma alimentar →",
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para abrir popup de ajuda
  void _mostrarAjuda(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("❓ Dúvidas Frequentes"),
        content: Text(
          "• Os dias de ofensiva são contados toda vez que você registra um treino.\n\n"
          "• Você pode editar seu treino e alimentação a qualquer momento.\n\n"
          "• Mantenha seu perfil atualizado para melhores recomendações 💡",
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
