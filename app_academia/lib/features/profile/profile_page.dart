import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:app_academia/services/auth_service.dart';
import 'package:app_academia/core/widgets/button_help.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _objectiveController = TextEditingController();
  String _gender = 'Feminino';
  String _email = '';
  bool _isLoading = false;
  int _selectedIndex = 4;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    final user = await ApiService.getCurrentUser();
    if (user != null) {
      setState(() {
        _nameController.text = user['nome'] ?? '';
        _weightController.text = user['peso'] ?? '';
        _heightController.text = user['altura'] ?? '';
        _objectiveController.text = user['objetivo'] ?? '';
        _gender = user['genero'] ?? 'Feminino';
        _email = user['email'] ?? '';
      });
    }
  }

  void _atualizarDados() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final dadosAtualizados = {
      'email': _email,
      'nome': _nameController.text,
      'peso': _weightController.text,
      'altura': _heightController.text,
      'genero': _gender,
      'objetivo': _objectiveController.text,
    };

    final sucesso = await ApiService.updateUser(dadosAtualizados);
    setState(() => _isLoading = false);

    AwesomeDialog(
      context: context,
      dialogType: sucesso ? DialogType.success : DialogType.error,
      title: sucesso ? 'Sucesso!' : 'Erro!',
      desc: sucesso
          ? 'Informações atualizadas com sucesso.'
          : 'Falha ao atualizar informações.',
      btnOkOnPress: () {},
    ).show();
  }

  void _confirmarExclusao() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: 'Confirmar exclusão',
      desc: 'Tem certeza que deseja excluir sua conta?',
      btnCancelOnPress: () {},
      btnOkText: 'Sim, excluir',
      btnOkOnPress: () async {
        final sucesso = await ApiService.deleteUser(_email);
        if (sucesso) {
          await ApiService.logout();
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            title: 'Erro!',
            desc: 'Falha ao excluir conta.',
            btnOkOnPress: () {},
          ).show();
        }
      },
    ).show();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/workout');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/nutrition');
        break;
      case 4:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        actions: const [BotaoDuvida()],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Icon(Icons.account_circle, size: 70, color: Color(0xFFF84600)),
                    const SizedBox(height: 20),

                    _buildInputField(_nameController, 'Nome', 'Digite seu nome'),
                    const SizedBox(height: 15),

                    _buildInputField(_weightController, 'Peso (kg)', 'Ex: 70'),
                    const SizedBox(height: 15),

                    _buildInputField(_heightController, 'Altura (cm)', 'Ex: 170'),
                    const SizedBox(height: 15),

                    _buildInputField(_objectiveController, 'Objetivo', 'Ex: Ganhar massa'),
                    const SizedBox(height: 15),

                    DropdownButtonFormField<String>(
                      value: _gender,
                      items: ['Feminino', 'Masculino', 'Outro']
                          .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                          .toList(),
                      onChanged: (value) => setState(() => _gender = value!),
                      decoration: _inputDecoration('Gênero'),
                    ),
                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: _atualizarDados,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF84600),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Salvar alterações',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _confirmarExclusao,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Excluir conta',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String label,
    String hint,
  ) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(label, hint),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
    );
  }

  InputDecoration _inputDecoration(String label, [String? hint]) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Color(0xFFF84600)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 14),
    );
  }
}
