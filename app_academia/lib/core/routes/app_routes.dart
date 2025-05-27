import 'package:flutter/material.dart';
import 'package:app_academia/features/login/login_page.dart';
import 'package:app_academia/features/register/register_page.dart';
import 'package:app_academia/features/home/home_page.dart';
import 'package:app_academia/features/workout/workout_page.dart';
import 'package:app_academia/features/profile/profile_page.dart';
import 'package:app_academia/features/nutrition/nutrition_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String workout = '/workout';
  static const String profile = '/profile';
  static const String nutrition = '/nutrition'; 

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    home: (context) => const HomePage(),
    workout: (context) => const WorkoutPage(),
    profile: (context) => const ProfilePage(),
    nutrition: (context) => const NutritionPage(),
  };
}
