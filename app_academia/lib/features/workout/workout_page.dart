import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_academia/services/auth_service.dart';
import 'package:app_academia/core/widgets/button_help.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final _tipoController = TextEditingController();
  final _tempoController = TextEditingController();
  List<Map<String, dynamic>> _treinos = [];
  int? _userId;

  @override
  void initState() {
    super.initState();
    _carregarUsuarioEListarTreinos();
  }

  Future<void> _carregarUsuarioEListarTreinos() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('user_id');
    if (_userId != null) {
      await _carregarTreinos();
    }
  }

  Future<void> _carregarTreinos() async {
    final treinos = await ApiService.listarTreinos(_userId!);
    setState(() {
      _treinos = treinos;
    });
  }

  Future<void> _registrarTreino() async {
    final tipo = _tipoController.text.trim();
    final tempo = _tempoController.text.trim();

    if (tipo.isEmpty || tempo.isEmpty) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        title: 'Campos vazios',
        desc: 'Preencha todos os campos para registrar o treino.',
        btnOkOnPress: () {},
      ).show();
      return;
    }

    final sucesso = await ApiService.registrarTreino(
      userId: _userId!,
      tipo: tipo,
      tempo: tempo,
    );

    if (sucesso) {
      _tipoController.clear();
      _tempoController.clear();
      await _carregarTreinos();

      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        title: 'Registrado!',
        desc: 'Treino registrado com sucesso.',
        btnOkOnPress: () {},
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Erro',
        desc: 'Falha ao registrar o treino.',
        btnOkOnPress: () {},
      ).show();
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Color(0xFFF84600)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(' Treino 🏃'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
          actions: const [BotaoDuvida()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            const Text(
              'Registrar treino de hoje',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tipoController,
                    decoration: _inputDecoration('Tipo do treino'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _tempoController,
                    decoration: _inputDecoration('Tempo (min)'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _registrarTreino,
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Registrar treino',
                  style: TextStyle(color: Colors.white),
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
              'Treinos registrados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _treinos.isEmpty
                  ? const Center(
                      child: Text('Nenhum treino registrado ainda.'),
                    )
                  : ListView.builder(
                      itemCount: _treinos.length,
                      itemBuilder: (context, index) {
                        final treino = _treinos[index];
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.fitness_center,
                              color: Color(0xFFF84600),
                            ),
                            title: Text(treino['tipo_treino']),
                            subtitle: Text(
                              'Tempo: ${treino['tempo_treino']} min\nData: ${treino['data']}',
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
