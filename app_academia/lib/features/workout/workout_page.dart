import 'package:flutter/material.dart';
import 'package:app_academia/core/widgets/button_help.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [BotaoDuvida()], // Sem sombra na AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Seus treinos!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Image.asset(
              'assets/images/Icon.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(text: 'Hoje seu treino é de '),
                  TextSpan(
                    text: 'pernas ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '🦵'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                   child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Tipo de treino',
                      labelStyle: const TextStyle(color: Color(0xFFF84600)),
                      hintText: 'Digite o tipo do treino',
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
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Tempo de treino',
                      labelStyle: const TextStyle(color: Color(0xFFF84600)),
                      hintText: 'Digite o tempo de treino',
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
                  )
                ),
              ],
            ),

            const SizedBox(height: 23),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Botão pressionado!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFF84600),
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                ),
                child: const Text(
                  'Registrar treino de hoje ➕',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 23),
            const Text(
              'Treino da semana',
              style: TextStyle(fontSize: 18, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            buildWorkoutCard(context, '24/05/2025', 'Treino de perna'),
            const SizedBox(height: 8),
            buildWorkoutCard(context, '25/05/2025', 'Treino de braço'),
            const SizedBox(height: 8),
            buildWorkoutCard(context, '26/05/2025', 'Treino de costas'),
          ],
        ),
      ),
    );
  }

  static Widget buildWorkoutCard(
    BuildContext context,
    String date,
    String workout,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(date, style: const TextStyle(fontSize: 16)),
            ),
            Expanded(
              flex: 5,
              child: Text(workout, style: const TextStyle(fontSize: 16)),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.deepOrange),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Editar treino: $workout')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
