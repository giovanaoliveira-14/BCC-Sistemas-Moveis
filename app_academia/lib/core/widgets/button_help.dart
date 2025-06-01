import 'package:flutter/material.dart';

class BotaoDuvida extends StatelessWidget {
  const BotaoDuvida({super.key});

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.75,
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Dúvidas frequentes 💡",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF84600),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: const [
                            _CollapsibleItem(
                              title: "Quantas vezes devo treinar por semana?",
                              content:
                                  "Para iniciantes, 3 a 4 vezes por semana já é eficaz. O importante é manter a regularidade.",
                            ),
                            _CollapsibleItem(
                              title: "Devo treinar mesmo com dor muscular?",
                              content:
                                  "Dores leves são comuns no início. Se a dor for intensa, o ideal é descansar e se recuperar.",
                            ),
                            _CollapsibleItem(
                              title: "Posso fazer musculação todos os dias?",
                              content:
                                  "Sim, desde que organize bem os grupos musculares e respeite o descanso de cada um.",
                            ),
                            _CollapsibleItem(
                              title: "Qual é o melhor horário para treinar?",
                              content:
                                  "O melhor horário é aquele em que você se sente mais disposto e consegue manter a rotina.",
                            ),
                            _CollapsibleItem(
                              title: "Como combinar treino e alimentação?",
                              content:
                                  "Procure se alimentar bem antes e depois dos treinos. Acompanhe seu plano no app!",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showHelpDialog(context),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(Icons.help_outline, color: Color(0xFFF84600), size: 28),
      ),
    );
  }
}

class _CollapsibleItem extends StatelessWidget {
  final String title;
  final String content;

  const _CollapsibleItem({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(content, style: const TextStyle(fontSize: 15, color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
