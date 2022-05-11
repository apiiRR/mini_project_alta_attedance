import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_alta_attedance/models/api/data_api.dart';
import '../models/data.dart';

class DataViewModel extends ChangeNotifier {
  String? token, userId;

  void updateData(tokenData, uid) {
    token = tokenData;
    userId = uid;
    notifyListeners();
  }

  List<Data> _allData = [];
  List<Data> get allData => _allData;
  var currentData;
  var status = true;

  Future<void> inisialData() async {
    print("initial");
    _allData = [];

    try {
      await Dio()
          .get(
              'https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/datas.json?auth=$token&orderBy="userId"&equalTo="$userId"')
          .then((value) {
        var hasilResponse;

        if (value.data != null) {
          hasilResponse = value.data as Map<String, dynamic>;
          hasilResponse.forEach(
            (key, value) {
              Data prod = Data(
                  checkIn: value["checkIn"],
                  checkOut: value["checkOut"],
                  duration: value["duration"],
                  id: key,
                  userId: value["userId"]);
              _allData.add(prod);
            },
          );

          if (allData.isNotEmpty) {
            var lastData = allData[allData.length - 1];
            currentData = lastData;

            if (currentData.checkOut == "" && currentData.duration == "") {
              status = false;
            }
          }

          notifyListeners();
        } else {
          hasilResponse = null;
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
    // var data = await DataAPI.getData(token, userId);

    // await DataAPI.getData(token, userId).then((value) {
    //   print(value);
    //   if (value != null) {
    //     value.forEach(
    //       (key, value) {
    //         Data prod = Data(
    //             checkIn: value["checkIn"],
    //             checkOut: value["checkOut"],
    //             duration: value["duration"],
    //             id: key,
    //             userId: value["userId"]);
    //         _allData.add(prod);
    //       },
    //     );

    //     if (allData.isNotEmpty) {
    //       var lastData = allData[allData.length - 1];
    //       currentData = lastData;

    //       if (currentData.checkOut == "" && currentData.duration == "") {
    //         status = false;
    //       }
    //     }

    //     notifyListeners();
    //   }
    // });

    // try {
    //   var response = await Dio().get(
    //       '$urlMaster/datas.json?auth=$token&orderBy="userId"&equalTo="$userId"');
    //   if (response.statusCode! >= 300 && response.statusCode! < 200) {
    //     throw (response.statusCode!);
    //   } else {
    //     var data = json.decode(response.data) as Map<String, dynamic>;
    //   }
    // } on DioError catch (err) {
    //   print(err);
    // }
  }

  Future checkIn() async {
    print("start");
    await DataAPI.checkIn(
            Data(
                    checkIn: DateTime.now().toString(),
                    checkOut: "",
                    duration: "",
                    id: "",
                    userId: userId!)
                .toJson(),
            token)
        .then((value) {
      print("end");
      inisialData();
      status = false;
    });
  }

  Future checkOut() async {
    await DataAPI.checkOut(
        token,
        currentData.id,
        json.encode({
          "checkOut": DateTime.now().toString(),
          "duration": DateTime.now()
              .difference(DateTime.parse(currentData.checkIn))
              .inMinutes
              .toString(),
        })).then((value) {
      inisialData();
      status = true;
    });
  }
}
