import 'package:flutter/cupertino.dart';
import 'package:unibike/data/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getUserLoginPreferences();
  }

  bool _isUserLoggedIn = false;
  bool get isUSerLoggedIn => _isUserLoggedIn;

  void _getUserLoginPreferences() async {
    _isUserLoggedIn = await preferencesHelper.isUserLoggedIn;
    notifyListeners();
  }

  void enable(bool value) {
    preferencesHelper.getUserLogin(value);
    _getUserLoginPreferences();
  }
}
