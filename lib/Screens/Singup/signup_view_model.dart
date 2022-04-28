import 'package:flutter/cupertino.dart';
import 'package:mini_project_alta_attedance/models/account.dart';
import 'package:mini_project_alta_attedance/models/api/account_api.dart';

class SignupViewModel extends ChangeNotifier {
  List _account = [];

  List get accounts => _account;

  Future signUp(Account account) async {
    var status = true;
    await getAllAccount().then((value) async {
      for (var item in accounts) {
        if (item.contains(account.email)) {
          status = false;
          break;
        } else {
          await AccountAPI.signUp(account.toJson()).then((value) {
            status = true;
          });
          break;
        }
      }
    });

    return status;
  }

  Future getAllAccount() async {
    final data = await AccountAPI.getAccount();
    data.forEach((key, value) {
      _account.add([key, value["name"], value["email"], value["password"]]);
    });
    notifyListeners();
  }
}
