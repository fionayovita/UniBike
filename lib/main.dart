import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/ui/login_page.dart';
import 'package:unibike/ui/register-page.dart';
import 'package:unibike/ui/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurants app',
      theme: themeData,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        LoginPage.routeName: (context) => LoginPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
      },
    );
  }
}
