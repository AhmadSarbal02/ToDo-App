// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constant.dart';
import 'package:todo/view/screens/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/sign_up_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custominput.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController pass2controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // نفس لون خلفية صفحة تسجيل الدخول
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // ارتفاع الـ AppBar
        child: Container(
          decoration: BoxDecoration(
            gradient: Constant.gradient,
          ),
          child: AppBar(
            title: Text(
              AppLocalizations.of(context)!.signup,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor:
                Colors.transparent, // جعل الخلفية شفافة ليظهر التدرج
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
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: Constant.gradient,
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

                            if (!signUpcontrollerr.isSamePassword(
                                passcontroller.text, val)) {
                              return AppLocalizations.of(context)!
                                  .notmatchpassword;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      // sign Up button
                      Consumer<SignUpcontrollerr>(
                        builder: (context, signUpcontrollerr, child) =>
                            CustomButton(
                          title: AppLocalizations.of(context)!.signup,
                          icon: Icons.login,
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              int signUp = await signUpcontrollerr.signUp(
                                  email: emailcontroller.text,
                                  password: passcontroller.text,
                                  name: namecontroller.text);

                              // ignore: avoid_print
                              print(
                                  "================================================================================================================SignUp result: $signUp");
                              // ignore: unrelated_type_equality_checks
                              if (signUp == 0) {
                                // ignore: avoid_print
                                print(
                                    "فششششششششششششششششششششششششششششششششششششششششششششششششششششششششششششششششل انشاااااااااااااااااااااااء حسااااااااااااااااااااااااب");
                              } else {
                                await signUpcontrollerr.getUser(
                                    email: emailcontroller.text,
                                    password: passcontroller.text);
                                signUpcontrollerr.showSignUpDoneDialog(context);
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
                      style: const TextStyle(
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
