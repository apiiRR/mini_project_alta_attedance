import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/account.dart';
import '../models/api/account_api.dart';

class AuthService with ChangeNotifier {

  AuthService() {
    syncDataWithProvider();
  }


  List<String> currentUser = [];
  List<String> dataEmail = [];
  List tempData = [];

  getUser() {
    return currentUser;
  }

  void logout() {
    currentUser.clear();
    updateSharedPreferences();
    notifyListeners();
  }

  Future createUser(Account akun) async {
    var status = false;
    dataEmail.clear();
    await getAllEmail().then((value) async {
      if (!dataEmail.contains(akun.email.toLowerCase())) {
        await AccountAPI.signUp(akun.toJson()).then((value) {
          status = true;
        });
      }
    });

    return status;
  }

  Future loginUser({required String email, required String password}) async {
    var status = false;
    tempData.clear();
    await getAllAccount().then((value) {
      for (var item in tempData) {
        if (item.contains(email.toLowerCase()) && item.contains(password)) {
          add(item);
          status = true;
          break;
        }
      }
    });

    return status;
  }

  Future updateSharedPreferences() async {
    List<String> myData = currentUser;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('login', myData);
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('login');

    if (result != null) {
      currentUser = result;
    }

    notifyListeners();
  }

  Future getAllEmail() async {
    final data = await AccountAPI.getAccount();
    data.forEach((key, value) {
      dataEmail.add(value["email"].toString());
    });
    notifyListeners();
  }

  Future<void> getAllAccount() async {
    final data = await AccountAPI.getAccount();
    data.forEach((key, value) {
      tempData.add([key, value["name"], value["email"], value["password"]]);
    });
    notifyListeners();
  }

    void add(List item) {
    currentUser = [...item];
    // contacts.add(contact);
    updateSharedPreferences();
    notifyListeners();
  }
}
