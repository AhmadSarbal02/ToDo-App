import 'package:flutter/material.dart';

class Constant {
  static Gradient? gradient = LinearGradient(
    colors: [Colors.blue.shade300, Colors.purple.shade400], // خلفية متدرجة
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
