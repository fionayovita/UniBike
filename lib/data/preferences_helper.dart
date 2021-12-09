import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const LOGIN = 'LOGIN';

  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  Future<bool> get isUserLoggedIn async {
    final prefs = await sharedPreferences;
    return prefs.getBool(LOGIN) ?? false;
  }

  void getUserLogin(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(LOGIN, value);
  }
}
