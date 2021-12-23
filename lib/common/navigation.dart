import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static back() => navigatorKey.currentState?.pop();
}
