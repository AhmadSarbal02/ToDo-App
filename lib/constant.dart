import 'package:flutter/material.dart';

class Constant {
  static Gradient? gradient = LinearGradient(
    colors: [
      Colors.blue,
      const Color.fromARGB(255, 27, 67, 228)
    ], // خلفية متدرجة
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Color background = const Color.fromARGB(255, 200, 211, 255);
}
