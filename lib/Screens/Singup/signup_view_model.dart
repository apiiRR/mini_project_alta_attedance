import 'package:flutter/material.dart';
import 'package:mini_project_alta_attedance/models/account.dart';
import 'package:mini_project_alta_attedance/models/api/account_api.dart';

class SignupViewModel extends ChangeNotifier {
  List<String> _account = [];

  List get accounts => _account;

  Future signUp(Account akun) async {
    var status = false;
    _account.clear();
    await getAllAccount().then((value) async {
      if (!_account.contains(akun.email.toLowerCase())) {
        await AccountAPI.signUp(akun.toJson()).then((value) {
          status = true;
        });
      }
    });

    return status;
  }

  Future getAllAccount() async {
    final data = await AccountAPI.getAccount();
    data.forEach((key, value) {
      _account.add(value["email"].toString());
    });
    notifyListeners();
  }
}
