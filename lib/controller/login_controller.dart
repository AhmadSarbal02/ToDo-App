import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/controller/sqflite_db.dart';
import '../model/user_model.dart';
import '../view/widgets/alert_errorlogin_widget.dart';

class Logincontrollerr extends ChangeNotifier {
  SqfliteDb sqfliteDb = SqfliteDb();
  List<UserModel>? usersList;
  TextEditingController? emailcontroller = TextEditingController();
  TextEditingController? passcontroller = TextEditingController();
  bool isEmailText = true;
  bool isPassword = true;
  bool obscureText = true;
  bool rememberMe = false;
  bool isEmpty = false;
  bool? isUser;

  Logincontrollerr() {
    // تحميل البيانات من SharedPreferences عند الإنشاء
    getData();
    getAllUesrs();
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

  getAllUesrs() async {
    usersList = [];
    List<Map> response = await sqfliteDb.getData(sql: "SELECT * FROM users");
    for (Map i in response) {
      usersList!.add(UserModel.fromJson(json: i));
    }
    notifyListeners();
  }

  checkUser({required String email, required String password}) async {
    isUser = await sqfliteDb.loginUser(email: email, password: password);
    return isUser;
  }

  showNotUserDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertErrorloginWidget();
      },
    );
  }
}
