import 'package:dio/dio.dart';

class ProfileAPI {
  static Future<void> updateData(token, id, dataUpdate) async {
    try {
      await Dio().patch(
        "https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/accounts/$id.json?auth=$token",
        data: dataUpdate).then((value) => value);
    } catch (e) {
      print(e);
    }
  }
}
