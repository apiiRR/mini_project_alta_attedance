import 'dart:convert';

import 'package:dio/dio.dart';
// import '../account.dart';

class AccountAPI {
  static Future<void> signUp(dataAccount) async {
    final response = await Dio().post("https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/account.json",
        data: json.encode(dataAccount));
  }

  static Future getAccount() async {
    var response = await Dio().get("https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/account.json");
    var hasilResponse = response.data as Map;
    return hasilResponse;
    // print(hasilResponse);
  }
}