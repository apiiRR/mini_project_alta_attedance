import 'package:flutter/cupertino.dart';

// import '../../models/account.dart';
import '../../models/api/account_api.dart';

class LoginViewModel with ChangeNotifier {
  List _account = [];

  List get account => _account;

  Future accountAuth(email, password) async {
    var status = false;
    await getAllAccount().then((value) {
      for (var item in account) {
        if (item.contains(email) && item.contains(password)) {
          status = true;
          break;
        } else {
          status = false;
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
}
