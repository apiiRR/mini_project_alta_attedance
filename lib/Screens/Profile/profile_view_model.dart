import 'package:flutter/material.dart';
import 'package:mini_project_alta_attedance/models/account.dart';
import 'package:mini_project_alta_attedance/models/api/profile_api.dart';

class ProfileViewModel extends ChangeNotifier {
  List _account = [];

  List get account => _account;

  Future<void> getAccount(key_akun) async {
    var tempData = [];
    final data = await ProfileAPI.getAccount(key_akun);
    // print(data.length);
    if (data != null) {
      data.forEach((key, value) {
        tempData.add(value);
      });
    }
    _account = [...tempData];
    /* print(data);
    data.forEach((key, value) {
      tempData.add([key, value["name"], value["email"], value["password"], value["nip"], value["job"]]);
    });

    _account = tempData[0]; */
    // print(tempData);
    notifyListeners();
  }
}