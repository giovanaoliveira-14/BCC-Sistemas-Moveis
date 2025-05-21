import 'package:flutter/material.dart';
import '../components/btn_ajuda.dart';

class MeuPerfil extends StatelessWidget {
  const MeuPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [BotaoDuvida()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'Seu perfil 🧘‍♂️',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),

            // Inputs
            _campoDeTexto('Nome Completo'),
            _campoDeTexto('Email'),
            _campoDeTexto('Gênero'),
            Row(
              children: [
                Expanded(child: _campoDeTexto('Peso')),
                const SizedBox(width: 10),
                Expanded(child: _campoDeTexto('Altura')),
              ],
            ),
            _campoDeTexto('Objetivo'),

            const SizedBox(height: 16),

            // Botão atualizar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF84600),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // lógica de atualização
                },
                child: const Text(
                  'Atualizar',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Informações da academia
            Container(
              width: double.infinity, // Usa toda a largura disponível
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Academia da Unimar',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Valor mensalidade: R\$50,00',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    'Status da mensalidade: Pago',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _campoDeTexto(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: const TextStyle(color: Color(0xFFF84600)),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 12,
          ),
        ),
      ),
    );
  }
}
