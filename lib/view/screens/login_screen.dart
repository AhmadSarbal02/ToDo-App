import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../../controller/login_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custominput.dart';
import 'bottom_navigation_screen.dart';
import 'sign_up_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class LoginPageScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  LoginPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Logincontrollerr logincontrollerr =
        Provider.of<Logincontrollerr>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // ارتفاع الـ AppBar
        child: Container(
          decoration: BoxDecoration(gradient: Constant.gradient),
          child: AppBar(
            title: Text(
              AppLocalizations.of(context)!.login,
              style: const TextStyle(
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  gradient: Constant.gradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 320,
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Email TextFeild
                      Consumer<Logincontrollerr>(
                        builder: (context, logincontroller, child) =>
                            CustomTextField(
                          controller: logincontroller.emailcontroller,
                          validator: (val) {
                            if (logincontroller.checkEmpty(val: val!)) {
                              return AppLocalizations.of(context)!
                                  .enteryouremail;
                            }
                            if (!logincontroller.isEmail(email: val)) {
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
                      const SizedBox(height: 10),

                      //Password TextFeild
                      Consumer<Logincontrollerr>(
                        builder: (context, logincontroller, child) =>
                            CustomTextField(
                          controller: logincontroller.passcontroller,
                          validator: (val) {
                            if (logincontroller.checkEmpty(val: val!)) {
                              return AppLocalizations.of(context)!
                                  .enteryourpassword;
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
                              logincontroller.changeOpscureTextPassword();
                            },
                            icon: Icon(
                              logincontroller.obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                          obscureText: logincontroller.obscureText,
                        ),
                      ),

                      // CheckBox Widget
                      const SizedBox(height: 10),
                      Consumer<Logincontrollerr>(
                        builder: (context, logincontrollerr, child) => Row(
                          children: [
                            Checkbox(
                              value: logincontrollerr.rememberMe,
                              onChanged: (_) {
                                logincontrollerr.checkBoxChange();
                              },
                              checkColor: Colors.white,
                              activeColor: const Color(0xFF007bff),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              side: WidgetStateBorderSide.resolveWith(
                                (states) =>
                                    BorderSide(width: 1.0, color: Colors.white),
                              ),
                            ),
                            Text(AppLocalizations.of(context)!.rememberme,
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),
                      // Sign In Button
                      Consumer<Logincontrollerr>(
                        builder: (context, logincontrollerr, child) =>
                            CustomButton(
                          title: AppLocalizations.of(context)!.signin,
                          icon: Icons.login,
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              if (logincontrollerr.rememberMe) {
                                logincontrollerr.setData(
                                  logincontrollerr.emailcontroller!.text,
                                  logincontrollerr.passcontroller!.text,
                                );
                              }
                              bool isUser = await logincontrollerr.checkUser(
                                email: logincontrollerr.emailcontroller!.text,
                                password: logincontrollerr.passcontroller!.text,
                              );

                              if (isUser) {
                                await logincontrollerr.getUser(
                                  email: logincontrollerr.emailcontroller!.text,
                                  password:
                                      logincontrollerr.passcontroller!.text,
                                );

                                if (logincontrollerr.userModel != null) {
                                  // ignore: avoid_print
                                  print(
                                      "============================== تم ارسال الاي دي يوزر الى الجيت تاسك ");
                                } else {
                                  // ignore: avoid_print
                                  print("⚠️ تحذير: userModel لا يزال null");
                                }
                                Navigator.pushReplacement(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationScreen()),
                                );
                              } else {
                                // ignore: use_build_context_synchronously
                                logincontrollerr.showNotUserDialog(context);
                              }
                            }
                          },
                        ),
                      ),

                      //Remove Data Button
                      // const SizedBox(height: 10),
                      // TextButton(
                      //   onPressed: () {
                      //     logincontrollerr.removeData();
                      //   },
                      //   child: Text(
                      //     AppLocalizations.of(context)!.removeuser,
                      //     style: const TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),

              // Sing Up Button and Text
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.donthaveanaccount,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),

                  //Sign Up Button
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signup,
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
