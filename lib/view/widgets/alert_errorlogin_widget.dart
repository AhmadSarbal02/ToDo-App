import 'package:flutter/material.dart';

class AlertErrorloginWidget extends StatelessWidget {
  const AlertErrorloginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("User Not Found"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok")),
      ],
    );
  }
}
