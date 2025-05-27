import 'package:flutter/material.dart';
import 'package:app_academia/core/widgets/button_help.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Barra de app transparente
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Primeiro Card com Expanded
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      height: 50,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Center(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Tipo do treino:',
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Espaço entre os Cards
                const SizedBox(width: 8),

                // Segundo Card com Expanded
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      height: 50,
                      color: Colors.white,
                      child: const Center(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Tempo de treino:',
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 23),

            SizedBox(
              width: double.infinity, // Preenche toda a largura

              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Botão pressionado!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFF84600),
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Bordas mais arredondadas
                  ),
                  elevation: 8,
                ),
                child: const Text(
                  'Registrar treino de hoje ➕',
                  style: TextStyle(
                    fontSize: 18, // Aumentando o tamanho do texto
                    fontWeight: FontWeight.w600, // Peso do texto
                    letterSpacing: 1.2, // Espaçamento entre letras
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
          ],
        ),
      ),
    );
  }
}
