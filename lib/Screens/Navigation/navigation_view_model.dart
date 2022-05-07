import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationViewModel extends ChangeNotifier {
  List _account = [];
  List get account => _account;

  NavigationViewModel() {
    syncDataWithProvider();
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('login');
    print(result);

    if (result != null) {
      _account = result;
    }

    notifyListeners();
  }
}
