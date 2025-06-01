import 'package:flutter/material.dart';
import 'core/routes/app_routes.dart';
import 'features/splash/splash_page.dart'; // nova tela splash

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        ...AppRoutes.getRoutes(),
      },
    );
  }
}
