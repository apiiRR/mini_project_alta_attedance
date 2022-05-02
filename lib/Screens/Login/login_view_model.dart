import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../models/account.dart';
import '../../models/api/account_api.dart';

class LoginViewModel with ChangeNotifier {
  List _account = [];

  List get account => _account;

  Future accountAuth(email, password) async {
    var status = false;
    _account.clear();
    await getAllAccount().then((value) {
      for (var item in account) {
        if (item.contains(email) && item.contains(password)) {
          updateSharedPreferences(item[0]);
          status = true;
          break;
        }
      }
    });

    return status;
  }

  Future<void> getAllAccount() async {
    final data = await AccountAPI.getAccount();
    data.forEach((key, value) {
      _account.add([key, value["name"], value["email"], value["password"]]);
    });
    notifyListeners();
  }

  Future updateSharedPreferences(key) async {
    String myData = key.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('isLogin', myData);
  }
}
