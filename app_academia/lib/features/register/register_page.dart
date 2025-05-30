import 'package:flutter/material.dart';
import 'package:app_academia/services/auth_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

// Tela de Cadastro
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _objectiveController = TextEditingController();

  String? _gender;

void _register(BuildContext context) async {
  print('[DEBUG] Iniciando processo de cadastro...');

  // Verifica se há campos vazios
  if (_nameController.text.isEmpty ||
      _emailController.text.isEmpty ||
      _passwordController.text.isEmpty ||
      _weightController.text.isEmpty ||
      _heightController.text.isEmpty ||
      _objectiveController.text.isEmpty ||
      _gender == null) {
    print('[DEBUG] Campos obrigatórios não preenchidos.');
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Campos obrigatórios',
      desc: 'Por favor, preencha todos os campos!',
      btnOkOnPress: () {},
    ).show();
    return;
  }

  // Dados capturados do formulário
  Map<String, dynamic> data = {
    'nome': _nameController.text,
    'email': _emailController.text,
    'senha': _passwordController.text,
    'peso': _weightController.text,
    'altura': _heightController.text,
    'genero': _gender!,
    'objetivo': _objectiveController.text,
  };

  print('[DEBUG] Dados para envio: $data');
  print('[DEBUG] Chamando ApiService.register...');

  bool success = await ApiService.register(data);

  print('[DEBUG] Resultado do cadastro: $success');

  if (success) {
    print('[DEBUG] Cadastro realizado com sucesso!');
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Sucesso!',
      desc: 'Cadastro realizado com sucesso!',
      btnOkOnPress: () {
        Navigator.pop(context); 
      },
    ).show();
  } else {
    print('[DEBUG] Falha no cadastro.');
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Erro!',
      desc: 'Falha ao cadastrar. Tente novamente.',
      btnOkOnPress: () {},
    ).show();
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Cor de fundo
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar transparente
        elevation: 0, // Remove a sombra do AppBar
      ),
      resizeToAvoidBottomInset:
          true, // Garante que o conteúdo se ajuste ao teclado
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ), // Padding lateral
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centraliza o conteúdo
            crossAxisAlignment:
                CrossAxisAlignment.center, // Garante o alinhamento horizontal
            children: [
              const SizedBox(height: 20),
              // Texto de boas-vindas
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Faça seu cadastro 🚀',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              // Container com largura máxima para os campos
              Container(
                width: double.infinity, // Usa toda a largura disponível
                constraints: const BoxConstraints(
                  maxWidth: 320,
                ), // Largura máxima de 320px
                child: Column(
                  children: [
                    // Campo de Nome
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: const TextStyle(color: Color(0xFFF84600)),
                        hintText: 'Digite seu nome',
                        filled: true,
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Campo de E-mail
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        labelStyle: const TextStyle(color: Color(0xFFF84600)),
                        hintText: 'Digite seu e-mail',
                        filled: true,
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Campo de Senha
                    TextField(
                      controller: _passwordController,
                      obscureText: true, // Oculta o texto da senha
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        labelStyle: const TextStyle(color: Color(0xFFF84600)),
                        hintText: 'Digite sua senha',
                        filled: true,
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Campo de Gênero
                    DropdownButtonFormField<String>(
                      value: _gender,
                      onChanged: (String? newValue) {
                        setState(() {
                          _gender = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Gênero',
                        labelStyle: const TextStyle(color: Color(0xFFF84600)),
                        filled: true,
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 12,
                        ),
                      ),
                      items:
                          ['Masculino', 'Feminino', 'Outro']
                              .map(
                                (gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(gender),
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 15),

                    // Campo de Peso e Altura
                    Flex(
                      direction:
                          Axis.horizontal, // Definindo a direção para horizontal
                      children: [
                        // Campo de Peso
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ), // Gap entre os campos
                            child: TextField(
                              controller: _weightController,
                              decoration: InputDecoration(
                                labelText: 'Peso (kg)',
                                labelStyle: const TextStyle(
                                  color: Color(0xFFF84600),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 12,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        // Campo de Altura
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ), // Gap entre os campos
                            child: TextField(
                              controller: _heightController,
                              decoration: InputDecoration(
                                labelText: 'Altura (cm)',
                                labelStyle: const TextStyle(
                                  color: Color(0xFFF84600),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 12,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Campo de Objetivo
                    TextField(
                      controller: _objectiveController,
                      decoration: InputDecoration(
                        labelText: 'Objetivo',
                        labelStyle: const TextStyle(color: Color(0xFFF84600)),
                        hintText: 'Digite seu objetivo',
                        filled: true,
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Botão de Cadastro
                    ElevatedButton(
                      onPressed: () => _register(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF84600),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
