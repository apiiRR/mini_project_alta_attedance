import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mini_project_alta_attedance/models/api/data_api.dart';
import 'package:mini_project_alta_attedance/models/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationViewModel extends ChangeNotifier {
  List _account = [];
  List get account => _account;

  List<Data> _data = [];
  List get data => _data;

  var currentData;
  var status = true;

  NavigationViewModel() {
    syncDataWithProvider().then((value) => getAllData());
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('login');
    print(result);

    if (result != null) {
      _account = result;
    }

    notifyListeners();
  }

  Future checkIn() async {
    await DataAPI.checkIn(
            account[0],
            Data(
                    checkIn: DateTime.now().toString(),
                    checkOut: "",
                    duration: "",
                    id: "")
                .toJson())
        .then((value) {
      getAllData();
      status = false;
    });
  }

  getAllData() async {
    final datas = await DataAPI.getData(account[0]);
    if (datas != null) {
      _data.clear();
      datas.forEach((key, value) {
        _data.add(Data(
            checkIn: value["checkIn"],
            checkOut: value["checkOut"],
            duration: value["duration"],
            id: key));
      });
    }

    if (data.isNotEmpty) {
      var lastData = data[data.length - 1];
      currentData = lastData;
    }
    // if (lastData.checkOut == "" && lastData.duration == "0") {
    //   // print(lastData);
    //   currentData = lastData;
    // }

    notifyListeners();
  }

  Future checkOut() async {
    await DataAPI.checkOut(
        account[0],
        currentData.id,
        json.encode({
          "checkOut": DateTime.now().toString(),
          "duration": DateTime.now()
              .difference(DateTime.parse(currentData.checkIn))
              .inMinutes
              .toString(),
        })).then((value) {
      getAllData();
      status = true;
    });
  }
}
