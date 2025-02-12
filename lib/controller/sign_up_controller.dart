import 'package:flutter/material.dart';
import 'package:todo/controller/sqflite_db.dart';

class SignUpcontrollerr extends ChangeNotifier {
  SqfliteDb sqfliteDb = SqfliteDb();
  bool isEmailText = true;
  bool isPassword = true;
  bool obscureText = true;
  bool isEmpty = false;
  bool isLong = false;

  signUp(
      {required String email,
      required String password,
      required String name}) async {
    int response = await sqfliteDb.insertData(
        sql:
            "INSERT INTO users (name, email, password) VALUES ('$name', '$email', '$password')");
    // ignore: avoid_print
    print(
        "$response====================signUp Reeesponse==============================");
    notifyListeners();
    return response;
  }

  checkEmpty({required String val}) {
    isEmpty = val.isEmpty;
    notifyListeners();
    return isEmpty;
  }

  checkLength({required String val}) {
    isLong = val.length > 40;

    notifyListeners();
    return isLong;
  }

  bool isEmail({required String email}) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    isEmailText = regExp.hasMatch(email);
    return regExp.hasMatch(email);
  }

  checkPassword({required String password}) {
    isPassword = password.isNotEmpty;
    notifyListeners();
  }

  //Make sure  Strong Password
  bool isStrongPassword({required String password}) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  //Make Sure Same Password (confirm Password)
  bool isSamePassword(String pass1, String pass2) {
    bool x;
    pass2 == pass1 ? x = true : x = false;
    return x;
  }

  changeOpscureTextPassword() {
    obscureText = !obscureText;
    notifyListeners();
  }
}
