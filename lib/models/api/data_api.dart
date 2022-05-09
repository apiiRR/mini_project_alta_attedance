import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mini_project_alta_attedance/models/data.dart';

class DataAPI {
  static Future getData(id) async {
    var hasilResponse;
    final response = await Dio().get(
        "https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/data/$id.json");
    if (response.data != null) {
      hasilResponse = response.data as Map;
    } else {
      var hasilResponse = null;
    }
    return hasilResponse;
  }

  static Future<void> checkIn(id, dataCheck) async {
    final response = await Dio().post(
        "https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/data/$id.json",
        data: dataCheck);
  }

  static Future<void> checkOut(user, id, dataCheckout) async {
    var response = await Dio().patch(
        "https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/data/$user/$id.json",
        data: dataCheckout);

    return response.data;
  }
}
