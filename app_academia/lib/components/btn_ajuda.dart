import 'package:flutter/material.dart';


class BotaoDuvida extends StatelessWidget {
  const BotaoDuvida({super.key});


  // Método para mostrar o diálogo
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width - 80,
            height: MediaQuery.of(context).size.height - 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    left: 30.0,
                    right: 30.0,
                    bottom: 20.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        SizedBox(height: 20),
                        _CollapsibleItem(
                          title: "Dúvida 1: O que é isso?",
                          content: "Isso é um botão de ajuda reutilizável.",
                        ),
                        _CollapsibleItem(
                          title: "Dúvida 2: Como funciona?",
                          content: "Ele pode ser colocado em qualquer AppBar.",
                        ),
                        _CollapsibleItem(
                          title: "Dúvida 3: Onde uso?",
                          content:
                              "Em qualquer tela que quiser replicar o botão.",
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 30,
                    ),
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
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(Icons.info, color: Color(0xFFF84600), size: 30),
      ),
    );
  }
}


// Widget privado para o conteúdo expansível
class _CollapsibleItem extends StatelessWidget {
  final String title;
  final String content;


  const _CollapsibleItem({required this.title, required this.content});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontSize: 16)),
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFF84600), width: 1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(content, style: const TextStyle(fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}





