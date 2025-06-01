import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:app_academia/services/auth_service.dart';
import 'package:app_academia/core/widgets/button_help.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  final _refeicaoController = TextEditingController();
  final _periodoController = TextEditingController();
  List<Map<String, dynamic>> _refeicoes = [];
  int? _userId;

  @override
  void initState() {
    super.initState();
    _carregarUsuarioEListarRefeicoes();
  }

  Future<void> _carregarUsuarioEListarRefeicoes() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('user_id');
    if (_userId != null) {
      await _carregarRefeicoes();
    }
  }

  Future<void> _carregarRefeicoes() async {
    final refeicoes = await ApiService.listarRefeicoes(_userId!);
    setState(() {
      _refeicoes = refeicoes;
    });
  }

  Future<void> _registrarRefeicao() async {
    final periodo = _periodoController.text.trim();
    final descricao = _refeicaoController.text.trim();

    if (periodo.isEmpty || descricao.isEmpty) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        title: 'Campos vazios',
        desc: 'Preencha todos os campos para registrar a refeição.',
        btnOkOnPress: () {},
      ).show();
      return;
    }

    final sucesso = await ApiService.registrarRefeicao(
      userId: _userId!,
      periodo: periodo,
      descricao: descricao,
    );

    if (sucesso) {
      _periodoController.clear();
      _refeicaoController.clear();
      await _carregarRefeicoes();

      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        title: 'Registrado!',
        desc: 'Refeição registrada com sucesso.',
        btnOkOnPress: () {},
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Erro',
        desc: 'Falha ao registrar a refeição.',
        btnOkOnPress: () {},
      ).show();
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFFF84600)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Cronograma Alimentar 🥦'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
          actions: const [BotaoDuvida()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Registrar refeição do dia',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),

            // Campos
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _periodoController,
                    decoration: _inputDecoration('Período (Ex: Almoço)'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _refeicaoController,
                    decoration: _inputDecoration('Descrição'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Botão registrar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _registrarRefeicao,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ), // Ícone branco também
                label: const Text(
                  'Registrar refeição',
                  style: TextStyle(color: Colors.white), // Cor do texto branca
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF84600),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              'Refeições registradas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Lista
            Expanded(
              child:
                  _refeicoes.isEmpty
                      ? const Center(
                        child: Text('Nenhuma refeição registrada ainda.'),
                      )
                      : ListView.builder(
                        itemCount: _refeicoes.length,
                        itemBuilder: (context, index) {
                          final refeicao = _refeicoes[index];
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: const Icon(
                                Icons.restaurant_menu,
                                color: Color(0xFFF84600),
                              ),
                              title: Text(refeicao['periodo']),
                              subtitle: Text(
                                '${refeicao['descricao']}\nData: ${refeicao['data']}',
                              ),
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
}
