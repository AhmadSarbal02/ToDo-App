import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  LocaleController() {
    // ignore: avoid_print
    print("Locale Controller Constructor");
    loadLang(); // تحميل اللغة من الشيرد بريفرنسيز
  }

  Locale locale =
      Locale("en"); //يحدد اللغة الحالية، افتراضيًا هي الإنجليزية (en).

  changeLang({required String langCode}) async {
    locale = Locale(langCode); //يتم تمريره لتحديد اللغة الجديدة.
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("local", langCode);
  }

  loadLang() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String langcode = sharedPreferences.getString("local") ??
        "en"; // اذا كانت فاضية اختار الانكليزية ك افتراضيه

    locale = Locale(langcode);
    notifyListeners();
  }
}
