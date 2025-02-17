// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/controller/sqflite_db.dart';
import '../model/user_model.dart';
import '../view/widgets/custom_alert_dialog_widget.dart';

class Logincontrollerr extends ChangeNotifier {
  SqfliteDb sqfliteDb = SqfliteDb();
  UserModel? userModel;
  TextEditingController? emailcontroller = TextEditingController();
  TextEditingController? passcontroller = TextEditingController();
  bool isEmailText = true;
  bool isPassword = true;
  bool obscureText = true;
  bool rememberMe = false;
  bool isEmpty = false;

  Logincontrollerr() {
    // تحميل البيانات من SharedPreferences عند الإنشاء
    getData();
    // getUser(email: emailcontroller!.text, password: passcontroller!.text);
  }

  checkEmpty({required String val}) {
    isEmpty = val.isEmpty;
    notifyListeners();
    return isEmpty;
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

  changeOpscureTextPassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  checkBoxChange() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  setData(String email, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('email', email);
    sharedPreferences.setString('pass', pass);
    notifyListeners();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    emailcontroller!.text = sharedPreferences.getString('email') ?? "";
    passcontroller!.text = sharedPreferences.getString('pass') ?? "";
  }

  removeData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('email');
    sharedPreferences.remove('pass');
    notifyListeners();
  }

  Future<void> getUser(
      {required String email, required String password}) async {
    try {
      List<Map> response = await sqfliteDb.getData(
        sql:
            "SELECT * FROM users WHERE email = '$email' AND password = '$password' LIMIT 1",
      );
      print(
          "$response ======================================== get user response");
      for (Map i in response) {
        userModel = UserModel.fromJson(json: i);
        print("✅ نجاح: تم العثور على المستخدم!");
        print("======================== ${userModel!.email}");
      }
    } catch (e) {
      print("❌ خطأ أثناء جلب المستخدم: $e");
      userModel = null;
    }

    notifyListeners();
  }

  Future<bool> checkUser(
      {required String email, required String password}) async {
    return await sqfliteDb.loginUser(email: email, password: password);
  }

  showNotUserDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialogWidget(
          title: "User Not Found",
          backgroundColor: Colors.red,
          text1: "Ok",
          onPressed1: () {
            Navigator.pop(context);
          },
          text2: "",
          onPressed2: () {},
        );
      },
    );
  }
}
