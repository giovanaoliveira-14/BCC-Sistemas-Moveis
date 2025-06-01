import 'package:flutter/material.dart';
import 'package:app_academia/services/auth_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _objectiveController = TextEditingController();
  String? _gender;

  void _register(BuildContext context) async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _weightController.text.isEmpty ||
        _heightController.text.isEmpty ||
        _objectiveController.text.isEmpty ||
        _gender == null) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        title: 'Campos obrigatórios',
        desc: 'Por favor, preencha todos os campos!',
        btnOkOnPress: () {},
      ).show();
      return;
    }

    final data = {
      'nome': _nameController.text,
      'email': _emailController.text,
      'senha': _passwordController.text,
      'peso': _weightController.text,
      'altura': _heightController.text,
      'genero': _gender!,
      'objetivo': _objectiveController.text,
    };

    final success = await ApiService.register(data);

    if (success) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        title: 'Sucesso!',
        desc: 'Cadastro realizado com sucesso!',
        btnOkOnPress: () => Navigator.pop(context, '/login'),
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Erro!',
        desc: 'Falha ao cadastrar. Tente novamente.',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.person_add_alt_1, size: 60, color: Color(0xFFF84600)),
              const SizedBox(height: 10),
              const Text(
                'Faça seu cadastro 🚀',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              _buildInputField(_nameController, 'Nome', 'Digite seu nome'),
              const SizedBox(height: 15),

              _buildInputField(_emailController, 'E-mail', 'Digite seu e-mail'),
              const SizedBox(height: 15),

              _buildInputField(_passwordController, 'Senha', 'Digite sua senha', obscureText: true),
              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                value: _gender,
                onChanged: (value) => setState(() => _gender = value),
                items: ['Masculino', 'Feminino', 'Outro']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                decoration: _inputDecoration('Gênero'),
              ),
              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      _weightController,
                      'Peso (kg)',
                      'Ex: 75',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField(
                      _heightController,
                      'Altura (cm)',
                      'Ex: 180',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              _buildInputField(_objectiveController, 'Objetivo', 'Ex: Ganhar massa'),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () => _register(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF84600),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 16, color: Colors.white),
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
    String hint, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: _inputDecoration(label, hint),
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
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
    );
  }
}
