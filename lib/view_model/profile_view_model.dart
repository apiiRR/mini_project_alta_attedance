import 'dart:convert';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_alta_attedance/models/account.dart';
import 'package:mini_project_alta_attedance/models/api/profile_api.dart';

class ProfileViewModel extends ChangeNotifier {
  String? token, userId, newToken;

  void updateData(tokenData, uid) {
    token = tokenData;
    userId = uid;
    notifyListeners();
  }

  List<Account> _data = [];
  List<Account> get data => _data;

  Future<void> _authenticate() async {
    var email = data[0].email.trim();
    var password = data[0].password.trim();
    try {
      var data = {
        "email": email,
        "password": password,
      };
      print(json.encode(data));
      final response = await Dio().post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCUhgxlZ8PECDM1aUtPWSw_RuZ0vSba0_A',
        data: json.encode(data),
      );
      final responseData = response.data;
      newToken = responseData['idToken'];
    } on DioError catch (error) {
      print(error.response!.data);
    }
  }

  Future<void> inisialData() async {
    print("initial");
    _data = [];

    try {
      await Dio()
          .get(
              'https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/accounts.json?auth=$token&orderBy="idUser"&equalTo="$userId"')
          .then((value) {
        var hasilResponse;

        if (value.data != null) {
          hasilResponse = value.data as Map<String, dynamic>;
          hasilResponse.forEach(
            (key, value) {
              Account acc = Account(
                  idUser: value["idUser"],
                  name: value["name"],
                  email: value["email"],
                  password: value["password"],
                  createdAt: DateTime.parse(value["createdAt"]),
                  nip: value["nip"],
                  job: value["job"],
                  id: key);
              _data.add(acc);
            },
          );

          notifyListeners();
        } else {
          hasilResponse = null;
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  Future updateAccount(String nip, String name, String email, String password,
      String job) async {
    Account acc = Account(
        idUser: "",
        name: name,
        email: email,
        password: password,
        createdAt: DateTime.now(),
        nip: nip,
        job: job,
        id: "");

    if (email.toLowerCase() != data[0].email) {
      await _authenticate();
      try {
        await Dio().post(
          'https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyCUhgxlZ8PECDM1aUtPWSw_RuZ0vSba0_A',
          data: jsonEncode(
            {
              'idToken': newToken,
              'email': email,
              'returnSecureToken': true,
            },
          ),
        );
      } on DioError catch (e) {
        print(e);
      }
    }

    if (password != data[0].password) {
      await _authenticate();
      try {
        await Dio().post(
          'https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyCUhgxlZ8PECDM1aUtPWSw_RuZ0vSba0_A',
          data: jsonEncode(
            {
              'idToken': newToken,
              'password': password,
              'returnSecureToken': true,
            },
          ),
        );
      } on DioError catch (e) {
        print(e.response!.data);
      }
    }

    await ProfileAPI.updateData(token, data[0].id, acc.toJson()).then((value) {
      inisialData();
    });
  }

  // static Future<String> uploadImage(File imageFile) async {
  //   String fileName = basename(imageFile.path);

  //   final ref = FirebaseStorage.instance.ref().child(fileName);
  //   final task = ref.putFile(imageFile);
  //   final snapshot = await task.snapshot;
  // }
}
