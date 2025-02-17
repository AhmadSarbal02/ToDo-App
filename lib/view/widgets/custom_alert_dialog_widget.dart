import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomAlertDialogWidget extends StatelessWidget {
  String? title;
  String? text1 = "";
  String? text2 = "";
  Color? backgroundColor;
  void Function()? onPressed1;
  void Function()? onPressed2;
  CustomAlertDialogWidget(
      {super.key,
      required this.title,
      this.backgroundColor,
      this.text1,
      this.text2,
      this.onPressed1,
      this.onPressed2});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      title: Text(title!),
      actions: [
        TextButton(onPressed: onPressed1, child: Text(text1!)),
        TextButton(onPressed: onPressed2, child: Text(text2!)),
      ],
    );
  }
}
