import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RegisterPage(),
    );
  }
}

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

  // Função de cadastro
  void _register() {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String weight = _weightController.text;
    String height = _heightController.text;
    String objective = _objectiveController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        weight.isEmpty ||
        height.isEmpty ||
        objective.isEmpty ||
        _gender == null) {
      // Exibe um alerta caso algum campo esteja vazio
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    } else {
      // Aqui você pode adicionar a lógica de cadastro
      print(
        'Cadastro: $name, $email, $password, $weight, $height, $objective, $_gender',
      );
      // Após o cadastro, você pode redirecionar para outra tela
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
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
                      onPressed: _register,
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
