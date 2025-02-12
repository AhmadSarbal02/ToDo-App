import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/view/screens/bottom_navigation_screen.dart';
import 'package:todo/view/screens/login_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../controller/sign_up_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custominput.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  TextEditingController? namecontroller = TextEditingController();
  TextEditingController? emailcontroller = TextEditingController();
  TextEditingController? passcontroller = TextEditingController();
  TextEditingController? pass2controller = TextEditingController();
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();

    return Scaffold(
      backgroundColor: Colors.white, // نفس لون خلفية صفحة تسجيل الدخول
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // ارتفاع الـ AppBar
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade300,
                Colors.purple.shade400,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: Text(
              AppLocalizations.of(context)!.signup,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor:
                Colors.transparent, // اجعل الخلفية شفافة ليظهر التدرج
            elevation: 0,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade300,
                      Colors.purple.shade400
                    ], // خلفية متدرجة
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      // Name TextField
                      Consumer<SignUpcontrollerr>(
                        builder: (context, signUpcontrollerr, child) =>
                            CustomTextField(
                          controller: namecontroller,
                          validator: (val) {
                            if (signUpcontrollerr.checkEmpty(val: val!)) {
                              return AppLocalizations.of(context)!.emptyname;
                            }
                            if (signUpcontrollerr.checkLength(val: val)) {
                              return AppLocalizations.of(context)!.longername;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.white),
                          lable: AppLocalizations.of(context)!.name,
                          hintText: AppLocalizations.of(context)!.fullname,
                          obscureText: false,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(height: 15),

                      // Email TextField
                      Consumer<SignUpcontrollerr>(
                        builder: (context, signUpcontrollerr, child) =>
                            CustomTextField(
                          controller: emailcontroller,
                          validator: (val) {
                            if (signUpcontrollerr.checkEmpty(val: val!)) {
                              return AppLocalizations.of(context)!
                                  .enteryouremail;
                            }
                            if (!signUpcontrollerr.isEmail(email: val)) {
                              return AppLocalizations.of(context)!.invalidemail;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.white),
                          lable: AppLocalizations.of(context)!.email,
                          hintText:
                              AppLocalizations.of(context)!.enteryouremail,
                          // errorText: signUpcontrollerr.isEmailText
                          //     ? null
                          //     : "Invalid Email",
                          obscureText: false,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(height: 15),

                      // Password TextFeild
                      Consumer<SignUpcontrollerr>(
                        builder: (context, signUpcontrollerr, child) =>
                            CustomTextField(
                          controller: passcontroller,
                          validator: (val) {
                            if (signUpcontrollerr.checkEmpty(val: val!)) {
                              return AppLocalizations.of(context)!
                                  .enteryourpassword;
                            }
                            if (!signUpcontrollerr.isStrongPassword(
                                password: val)) {
                              return AppLocalizations.of(context)!
                                  .passWordisweek;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.white),
                          lable: AppLocalizations.of(context)!.password,
                          hintText:
                              AppLocalizations.of(context)!.enteryourpassword,
                          maxLines: 1,
                          suffixIcon: IconButton(
                            onPressed: () {
                              signUpcontrollerr.changeOpscureTextPassword();
                            },
                            icon: Icon(
                              signUpcontrollerr.obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                          obscureText: signUpcontrollerr.obscureText,
                          // errorText: signUpcontrollerr.isPassword
                          //     ? null
                          //     : "Empty Password",
                        ),
                      ),
                      SizedBox(height: 15),

                      //Confrim Password TextFeild
                      Consumer<SignUpcontrollerr>(
                        builder: (context, signUpcontrollerr, child) =>
                            CustomTextField(
                          controller: pass2controller,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.white),
                          lable: AppLocalizations.of(context)!.confrimpassword,
                          hintText:
                              AppLocalizations.of(context)!.enteryourpassword,
                          maxLines: 1,
                          suffixIcon: IconButton(
                            onPressed: () {
                              signUpcontrollerr.changeOpscureTextPassword();
                            },
                            icon: Icon(
                              signUpcontrollerr.obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                          obscureText: signUpcontrollerr.obscureText,
                          validator: (val) {
                            if (signUpcontrollerr.checkEmpty(val: val!)) {
                              return AppLocalizations.of(context)!
                                  .enteryourpassword;
                            }
                            //signUpcontrollerr.pass2controller!.text = val!;

                            if (!signUpcontrollerr.isSamePassword(
                                passcontroller!.text, val)) {
                              return AppLocalizations.of(context)!
                                  .notmatchpassword;
                            }
                            return null;
                          },
                          // errorText: signUpcontrollerr.isPassword
                          //     ? null
                          //     : "Empty Password",
                        ),
                      ),
                      SizedBox(height: 20),
                      // sign Up button
                      Consumer<SignUpcontrollerr>(
                        builder: (context, signUpcontrollerr, child) =>
                            CustomButton(
                          title: AppLocalizations.of(context)!.signup,
                          icon: Icons.login,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              int signUp = signUpcontrollerr.signUp(
                                  email: emailcontroller!.text,
                                  password: passcontroller!.text,
                                  name: namecontroller!.text);
                              // ignore: unrelated_type_equality_checks
                              if (signUp == 0) {
                                // ignore: avoid_print
                                print(
                                    "فششششششششششششششششششششششششششششششششششششششششششششششششششششششششششششششششل انشاااااااااااااااااااااااء حسااااااااااااااااااااااااب");
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationScreen(),
                                    ));
                              }
                            }
                          },
                        ),
                      ),

                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.alreadyhaveanaccount,
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPageScreen()));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signin,
                      style: TextStyle(
                          color: Color(0xFF007bff),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
