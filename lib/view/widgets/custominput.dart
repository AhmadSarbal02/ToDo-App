import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? lable;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final int? maxLines;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? errorText;
  const CustomTextField({
    super.key,
    required this.keyboardType,
    required this.prefixIcon,
    required this.lable,
    required this.hintText,
    required this.obscureText,
    this.suffixIcon,
    this.validator,
    this.controller,
    this.errorText,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLines: maxLines,
        obscureText: obscureText,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          errorText: errorText,
          label: Text(
            lable!,
            style: TextStyle(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 255, 255, 255)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 255, 255, 255)),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hintText!,
          hintStyle: TextStyle(color: Colors.white),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
