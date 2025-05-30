import 'package:flutter/material.dart';
import 'features/auth/login_page.dart';
import 'features/auth/register_page.dart';
import 'features/home/home_page.dart'; 
import 'features/cronograma/cronograma_page.dart';
import 'features/perfil/perfil_page.dart';
import 'features/treino/treino_page.dart';   

void main() {
  runApp(const GymApp());
}

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Manager',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        primaryColor: const Color(0xFFF84600),
        textTheme: Theme.of(
          context,
        ).textTheme.apply(bodyColor: Colors.black, displayColor: Colors.black),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/cadastro': (context) => const RegisterPage(),
        '/home': (context) => HomePage(nomeUsuario: "João"), /
        '/treino': (context) => TreinoPage(), 
        '/alimentacao': (context) => CronogramaPage(), 
        '/perfil': (context) => PerfilPage(), 
      },
    );
  }
}
