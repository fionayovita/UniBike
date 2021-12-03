import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/ui/bike_detail_page.dart';
import 'package:unibike/ui/home_page.dart';
import 'package:unibike/ui/login_page.dart';
import 'package:unibike/ui/main_page.dart';
import 'package:unibike/ui/register_page.dart';
import 'package:unibike/ui/splash_screen.dart';

import 'model/bike_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomePage.routeName: (context) => HomePage(),
        LoginPage.routeName: (context) => LoginPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        MainPage.routeName: (context) => MainPage(),
        BikeDetailPage.routeName: (context) => BikeDetailPage(
              bike: ModalRoute.of(context)?.settings.arguments as Bike,
            ),
      },
    );
  }
}
