import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project_alta_attedance/models/api/data_api.dart';
import '../models/account.dart';
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
    _aMonth = [];
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
                  userId: value["userId"],
                  status: value["status"],
                  doc: value["doc"]);
              if (value["checkOut"] == "" &&
                  value["duration"] == "" &&
                  value["status"] == "hadir") {
                currentData = prod;
                status = false;
              } else {
                _allData.add(prod);
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

          if (allData.isNotEmpty && allData.length > 5) {
            _aWeek = allData.sublist(0, 5);
          } else {
            _aWeek = allData;
          }
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
                    userId: userId!,
                    status: "hadir",
                    doc: "")
                .toJson(),
            token)
        .then((value) {
      inisialData();
      status = false;
    });
  }

  Future checkInSakit(bukti) async {
    await DataAPI.checkIn(
            Data(
                    checkIn: DateTime.now().toString(),
                    checkOut: "",
                    duration: "",
                    id: "",
                    userId: userId!,
                    status: "sakit",
                    doc: bukti)
                .sakitToJson(),
            token)
        .then((value) {
      inisialData();
      status = true;
    });
  }

  Future checkInCuti(date) async {
    List<DateTime> days = [];

    List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
      List<DateTime> days = [];
      for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
        days.add(startDate.add(Duration(days: i)));
      }
      return days;
    }

    DateTimeRange dateRange =
        DateTimeRange(start: DateTime.now(), end: DateTime.now());
    dateRange = date;

    days = getDaysInBeteween(dateRange.start, dateRange.end);

    masukDataCuti(days).then((value) {
      inisialData();
      status = true;
    });
  }

  Future masukDataCuti(item) async {
    for (var day in item) {
      await DataAPI.checkIn(
          Data(
                  checkIn: day.toString(),
                  checkOut: "",
                  duration: "",
                  id: "",
                  userId: userId!,
                  status: "cuti",
                  doc: "")
              .cutiToJson(),
          token);
    }
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

  exportPDF(Account user) async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Container(
                width: double.infinity,
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("NIP : ${user.nip}"),
                      pw.Text("Nama : ${user.name}"),
                      pw.Text("Email : ${user.email}"),
                      pw.Text("Job : ${user.job}"),
                      pw.Divider(thickness: 2),
                      pw.Table(border: pw.TableBorder.all(), children: [
                        pw.TableRow(
                          children: [
                            pw.Center(
                              child: pw.Text("Tanggal"),
                            ),
                            pw.Center(
                              child: pw.Text("Check In"),
                            ),
                            pw.Center(
                              child: pw.Text("Check Out"),
                            ),
                            pw.Center(
                              child: pw.Text("Durasi"),
                            ),
                            pw.Center(child: pw.Text("Kehadiran")),
                          ],
                        ),
                        for (var item in aMonth) ...[
                          pw.TableRow(children: [
                            pw.Center(
                              child: pw.Text(DateFormat('dd MMMM yyyy')
                                  .format(DateTime.parse(item.checkIn))),
                            ),
                            pw.Center(
                              child: item.status == "hadir"
                                  ? pw.Text(item.checkIn != ""
                                      ? DateFormat.Hms()
                                          .format(DateTime.parse(item.checkIn))
                                      : "-")
                                  : pw.Text("-"),
                            ),
                            pw.Center(
                              child: pw.Text(item.checkOut != ""
                                  ? DateFormat.Hms()
                                      .format(DateTime.parse(item.checkOut))
                                  : "-"),
                            ),
                            pw.Center(
                              child: pw.Text(item.duration != ""
                                  ? "${item.duration} menit"
                                  : "-"),
                            ),
                            pw.Center(child: pw.Text(item.status)),
                          ])
                        ],
                      ]),
                    ]))
          ];
        }));

    Uint8List bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/report.pdf');

    await file.writeAsBytes(bytes);

    await OpenFile.open(file.path);
  }
}
