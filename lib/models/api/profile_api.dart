import 'package:dio/dio.dart';
// import '../account.dart';

class ProfileAPI {
  static Future getAccount(keyAkun) async {
    var response = await Dio().get(
        "https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/account/$keyAkun.json");
    var hasilResponse = response.data as Map;
    return hasilResponse;
    // print(hasilResponse);
  }

  static Future<void> editProfile(String id, dataContact) async {
    var response = await Dio().patch(
        "https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/account/$id.json",
        data: dataContact);

    return response.data;
    /* return http
        .patch(url,
            body: json.encode({
              "name": name,
              "position": position,
              "imageUrl": image,
            }))
        .then((res) {
      Player selectPlayer =
          _allPlayer.firstWhere((element) => element.id == id);
      selectPlayer.name = name;
      selectPlayer.position = position;
      selectPlayer.imageUrl = image;
      notifyListeners(); */
  }
}
