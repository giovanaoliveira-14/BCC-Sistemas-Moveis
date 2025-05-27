import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0066CC);
  static const Color secondary = Color(0xFF00CC99);
  static const Color background = Color(0xFFF2F2F2);
  static const Color text = Color(0xFF333333);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
}

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.text,
  );

  static const TextStyle button = TextStyle(
    fontSize: 18,
    color: AppColors.white,
    fontWeight: FontWeight.w600,
  );
}
