import 'package:flutter/material.dart';
import 'package:unibike/ui/bike_detail_page.dart';
import 'package:unibike/ui/history_peminjaman_page.dart';
import 'package:unibike/ui/home_page.dart';
import 'package:unibike/ui/login_page.dart';
import 'package:unibike/ui/main_page.dart';
import 'package:unibike/ui/profile_page.dart';
import 'package:unibike/ui/register_page.dart';
import 'package:unibike/ui/splash_screen.dart';
import 'package:unibike/ui/status_pinjam_page.dart';
import 'package:unibike/widgets/card_sepeda.dart';

class RouterHelper {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => HomePage());
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RegisterPage.routeName:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case StatusPinjamPage.routeName:
        return MaterialPageRoute(builder: (_) => StatusPinjamPage());
      case ProfilePage.routeName:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case HistoryPeminjamanPage.routeName:
        return MaterialPageRoute(builder: (_) => HistoryPeminjamanPage());
      case MainPage.routeName:
        return MaterialPageRoute(builder: (_) => MainPage());
      case BikeDetailPage.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            final args = settings.arguments as CardSepedaArgs;
            CardSepedaArgs argument = args;
            return BikeDetailPage(
              bike: argument.bike,
              fakultas: argument.fakultas as String,
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
