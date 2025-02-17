// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo/controller/sqflite_db.dart';
import 'package:todo/view/screens/login_screen.dart';
import 'package:todo/view/widgets/custom_alert_dialog_widget.dart';
import '../model/user_model.dart';

class SignUpcontrollerr extends ChangeNotifier {
  SqfliteDb sqfliteDb = SqfliteDb();
  bool isEmailText = true;
  bool isPassword = true;
  bool obscureText = true;
  bool isEmpty = false;
  bool isLong = false;
  UserModel? userModel;

  signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      int response = await sqfliteDb.insertData(
          sql:
              "INSERT INTO users (name, email, password) VALUES ('$name', '$email', '$password')");

      print(
          "$response====================signUp Reeesponse================================================================================");
      return response;
    } catch (e) {
      print(
          '====================================================================================================Error inserting data: $e');
      return -1; // تم التعامل مع الخطأ
    }
  }

  getUser({required String email, required String password}) async {
    List<Map> response = await sqfliteDb.getData(
        sql:
            "SELECT * FROM users WHERE email = '$email' AND password = '$password' LIMIT 1");
    if (response.isNotEmpty) {
      for (Map i in response) {
        userModel = (UserModel.fromJson(json: i));
      }
      // بيانات المستخدم موجودة
      return true;
    }
    return false;
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
    return pass1 == pass2;
  }

  changeOpscureTextPassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  showSignUpDoneDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialogWidget(
          title: "Sign Up Done",
          backgroundColor: Colors.green,
          text1: "Ok",
          onPressed1: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPageScreen(),
                ));
          },
          text2: "",
          onPressed2: () {},
        );
      },
    );
  }
}
