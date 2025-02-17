import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constant.dart';
import 'package:todo/view/screens/login_screen.dart';

import '../../controller/locale_controller.dart';
import '../widgets/custom_button.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: Constant.gradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Chosse Your Language",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 30),

            // زر اللغة الإنجليزية
            CustomButton(
              title: "English",
              icon: Icons.language,
              onTap: () {
                Provider.of<LocaleController>(context, listen: false)
                    .changeLang(langCode: "en");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPageScreen(),
                    ));
              },
            ),
            SizedBox(height: 20),

            // زر اللغة العربية
            CustomButton(
              title: "العربية",
              icon: Icons.translate,
              onTap: () {
                Provider.of<LocaleController>(context, listen: false)
                    .changeLang(langCode: "ar");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPageScreen(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
