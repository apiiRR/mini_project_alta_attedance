import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mini_project_alta_attedance/models/api/profile_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ProfileViewState { none, loading, error }

class ProfileViewModel extends ChangeNotifier {
  ProfileViewState _state = ProfileViewState.none;
  ProfileViewState get state => _state;

  changeState(ProfileViewState state) {
    _state = state;
    notifyListeners();
  }

  List _account = [];
  List get account => _account;

  // List<String> currentUser = [];

  ProfileViewModel() {
    initialData();
  }

  Future<void> initialData() async {
    changeState(ProfileViewState.loading);

    try {
      await syncDataWithProvider();
      // await getAccount();
      if (account.length > 0) {
        changeState(ProfileViewState.none);
      }
    } catch (e) {
      changeState(ProfileViewState.error);
    }
  }

  // Future<void> getAccount() async {
  //   var tempData = [];
  //   final data = await ProfileAPI.getAccount(currentUser[0]);
  //   // print(data.length);
  //   if (data != null) {
  //     data.forEach((key, value) {
  //       tempData.add(value);
  //     });
  //   }

  //   _account = [...tempData];
  //   notifyListeners();
  // }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('login');
    print(result);

    if (result != null) {
      _account = result;
    }

    notifyListeners();
  }

  Future editData(
      {required String id,
      required String email,
      required String job,
      required String name,
      required String nip,
      required String password}) async {
    await ProfileAPI.editProfile(
        id,
        json.encode({
          "email": email,
          "job": job,
          "name": name,
          "nip": nip,
          "password": password
        })).then((value) {
      _account[5] = nip;
      _account[1] = name;
      _account[2] = email;
      _account[3] = password;
      _account[4] = job;
      // currentUser[1] = name;
      // currentUser[2] = email;
      // currentUser[3] = password;
    });

    updateSharedPreferences();
    notifyListeners();
  }

  Future updateSharedPreferences() async {
    List<String> myData = [...account];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('login', myData);
  }
}
