import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project_alta_attedance/models/api/data_api.dart';
import '../models/data.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DataViewModel extends ChangeNotifier {
  String? token, userId;

  void updateData(tokenData, uid) {
    token = tokenData;
    userId = uid;
    notifyListeners();
  }

  List<Data> _allData = [];
  List<Data> get allData => _allData;

  List<Data> _aWeek = [];
  List<Data> get aWeek => _aWeek;

  List<Data> _aMonth = [];
  List<Data> get aMonth => _aMonth;

  var currentData;
  var status = true;

  Future<void> inisialData() async {
    _aWeek = [];
    _allData = [];
    currentData = null;

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
              if (value["checkOut"] != "" && value["duration"] != "") {
                _allData.add(prod);
              } else {
                currentData = prod;
                status = false;
              }
            },
          );

          // if (allData.isNotEmpty) {
          //   var lastData = allData[allData.length - 1];
          //   currentData = lastData;

          //   if (currentData.checkOut == "" && currentData.duration == "") {
          //     status = false;
          //   }
          // }
          _allData.sort((a, b) {
            return (b.checkIn).compareTo((a.checkIn));
          });

          _aWeek = allData.sublist(0, 5);
          _aMonth = allData;

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

  filterMonth(index) {
    if (index == 0) {
      _aMonth = [];
      _aMonth = allData;
    } else {
      _aMonth = [];
      allData.forEach((value) {
        if (DateFormat('M').format(DateTime.parse(value.checkIn)) ==
            index.toString()) {
          _aMonth.add(value);
        }
      });
    }

    notifyListeners();
  }

  exportPDF() async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Container(
                color: PdfColors.red800,
                alignment: pw.Alignment.center,
                width: double.infinity,
                child: pw.Text("UJI COBA PDF",
                    style: pw.TextStyle(
                      fontSize: 50,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                    )))
          ];
        }));

        Uint8List bytes = await pdf.save();

        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/report.pdf');

        await file.writeAsBytes(bytes);

        await OpenFile.open(file.path);
  }
}
