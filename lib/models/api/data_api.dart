import 'package:dio/dio.dart';

class DataAPI {
  static Future getData(token, userId) async {
    try {
      await Dio()
          .get(
              'https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/datas.json?auth=$token&orderBy="userId"&equalTo="$userId"')
          .then((value) {
        var hasilResponse;

        if (value.data != null) {
          hasilResponse = value.data as Map<String, dynamic>;
        } else {
          hasilResponse = null;
        }

        print("response $hasilResponse");
        return hasilResponse;
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  static Future<void> checkIn(dataCheck, token) async {
    try {
      final response = await Dio().post(
          "https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/datas.json?auth=$token",
          data: dataCheck);

      return response.data;
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  static Future<void> checkOut(token, id, dataCheckout) async {
    var response = await Dio().patch(
        "https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/datas/$id.json?auth=$token",
        data: dataCheckout);

    return response.data;
  }
}
