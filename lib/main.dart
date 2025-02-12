import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/task_controller.dart';
import 'controller/locale_controller.dart';
import 'controller/login_controller.dart';
import 'controller/sign_up_controller.dart';
import 'view/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TaskController()),
          ChangeNotifierProvider(create: (context) => LocaleController()),
          ChangeNotifierProvider(create: (context) => Logincontrollerr()),
          ChangeNotifierProvider(create: (context) => SignUpcontrollerr()),
        ],
        child: Consumer<LocaleController>(
          builder: (context, localeController, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            localizationsDelegates: [
              // يحدد الموارد الداعمة للغات.
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              //يحدد اللغات المدعومة: الإنجليزية والعربية.
              Locale('en'), // English
              Locale('ar'), // Arabic
            ],
            locale: localeController
                .locale, //يحدد اللغة الحالية باستخدام localController.locale.
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: SplashScreen(),
          ),
        ));
  }
}
