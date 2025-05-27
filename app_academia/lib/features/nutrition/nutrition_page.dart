import 'package:flutter/material.dart';
import 'package:app_academia/core/widgets/button_help.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // fundo claro
      appBar: AppBar(
        title: const Text('Cronograma Alimentar 🥦'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // ação do botão
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Registrar cronograma alimentar 🍽️',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Lista dos períodos alimentares
            Expanded(
              child: ListView(
                children: const [
                  RefeicaoTile(
                    titulo: 'Café da manhã',
                    icone: Icons.free_breakfast,
                  ),
                  RefeicaoTile(
                    titulo: 'Almoço',
                    icone: Icons.restaurant,
                  ),
                  RefeicaoTile(
                    titulo: 'Café da tarde',
                    icone: Icons.coffee,
                  ),
                  RefeicaoTile(
                    titulo: 'Jantar',
                    icone: Icons.dinner_dining,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Componente separado para cada refeição
class RefeicaoTile extends StatelessWidget {
  final String titulo;
  final IconData icone;

  const RefeicaoTile({
    super.key,
    required this.titulo,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Icon(icone, color: Colors.black87),
        title: Text(titulo),
        children: const [
          ListTile(
            title: Text('• Inserir alimentos ou detalhes aqui...'),
          )
        ],
      ),
    );
  }
}
