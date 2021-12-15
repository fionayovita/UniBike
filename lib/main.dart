import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/preferences/preferences_helper.dart';
import 'package:unibike/provider/alarm_provider.dart';
import 'package:unibike/provider/preferences_provider.dart';
import 'package:unibike/ui/bike_detail_page.dart';
import 'package:unibike/ui/home_page.dart';
import 'package:unibike/ui/login_page.dart';
import 'package:unibike/ui/main_page.dart';
import 'package:unibike/ui/profile_page.dart';
import 'package:unibike/ui/register_page.dart';
import 'package:unibike/ui/splash_screen.dart';
import 'package:unibike/ui/status_pinjam_page.dart';
import 'package:unibike/utils/background_service.dart';
import 'package:unibike/utils/notifications_helper.dart';

import 'model/bike_model.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
      ],
      child: MaterialApp(
        theme: themeData,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          HomePage.routeName: (context) => HomePage(),
          LoginPage.routeName: (context) => LoginPage(),
          RegisterPage.routeName: (context) => RegisterPage(),
          StatusPinjamPage.routeName: (context) => StatusPinjamPage(),
          ProfilePage.routeName: (context) => ProfilePage(),
          MainPage.routeName: (context) => MainPage(),
          BikeDetailPage.routeName: (context) => BikeDetailPage(
              bike: ModalRoute.of(context)?.settings.arguments as Bike)
        },
      ),
    );
  }
}
