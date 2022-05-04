import 'dart:convert';

import 'package:dio/dio.dart';
// import '../account.dart';

class ProfileAPI {
  static Future getAccount(key_akun) async {
    var response = await Dio().get("https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/account/$key_akun.json");
    var hasilResponse = response.data as Map;
    return hasilResponse;
    // print(hasilResponse);
  }
}
