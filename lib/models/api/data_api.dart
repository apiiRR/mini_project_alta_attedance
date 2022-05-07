import 'package:dio/dio.dart';

class DataAPI {
  static Future getAccount(key_akun) async {
    var response = await Dio().get(
        "https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/data/$key_akun.json");
    var hasilResponse = response.data as Map;
    return hasilResponse;
    // print(hasilResponse);
  }
}
