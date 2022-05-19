import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project_alta_attedance/Screens/Navigation/components/day.dart';
import 'package:mini_project_alta_attedance/Screens/Navigation/components/time.dart';

import 'package:mini_project_alta_attedance/view_model/data_view_model.dart';
import 'package:mini_project_alta_attedance/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future<String> uploadFile() async {
    var urlPhoto;
    if (pickedFile != null) {
      final path = 'files/${pickedFile!.name}';
      final file = File(pickedFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });

      final snapshot = await uploadTask!.whenComplete(() {});

      final urlDownload = await snapshot.ref.getDownloadURL();
      print("Download LINK : $urlDownload");
      urlPhoto = urlDownload;

      setState(() {
        uploadTask = null;
      });
    }

    return urlPhoto;
  }

  Future selectFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataViewModel>(context);
    final profile = Provider.of<ProfileViewModel>(context);
    final currentData = data.currentData;
    // final currentData = data.currentData;
    // final dataCheckIn = data.data;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),

          // section waktu jam & tanggal
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Column(
                children: [
                  Time(),
                  Day(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),

          // section pencatat waktu masuk dan keluar terkini
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kPrimaryMaroon,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "Masuk",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      currentData != null && currentData != ""
                          ? DateFormat.Hms()
                              .format(DateTime.parse(currentData.checkIn))
                              .toString()
                          : "-",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  width: 2,
                  height: 40,
                  color: Colors.white,
                ),
                Column(
                  children: [
                    Text("Keluar", style: TextStyle(color: Colors.white)),
                    Text(
                      currentData != null &&
                              currentData != "" &&
                              currentData.checkOut != ""
                          ? DateFormat.Hms()
                              .format(DateTime.parse(currentData.checkOut))
                              .toString()
                          : "-",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  width: 2,
                  height: 40,
                  color: Colors.white,
                ),
                Column(
                  children: [
                    Text("Durasi", style: TextStyle(color: Colors.white)),
                    Text(
                      currentData != null &&
                              currentData != "" &&
                              currentData.duration != ""
                          ? "${currentData.duration} min"
                          : "- min",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),

          // section pengajuan cuti & izin
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pengajuan Cuti / Izin Sakit"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Izin Sakit"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              "Silahkan ungggah surat izin sakit anda dalam format pdf*"),
                                          ElevatedButton(
                                              onPressed: () async {
                                                await selectFile();
                                              },
                                              child: const Text("Unggah"),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        kPrimaryMaroon),
                                              )),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Batal",
                                              style: TextStyle(
                                                  color: kPrimaryMaroon),
                                            )),
                                        TextButton(
                                            onPressed: () async {
                                              if (pickedFile != null) {
                                                Navigator.pop(context);
                                                await uploadFile().then(
                                                    (value) => data
                                                        .checkInSakit(value));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "dokumen belum diunggah"),
                                                    duration:
                                                        Duration(seconds: 2),
                                                  ),
                                                );
                                              }
                                            },
                                            child: const Text(
                                              "Kirim",
                                              style: TextStyle(
                                                  color: kPrimaryMaroon),
                                            )),
                                      ],
                                    ));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kPrimaryPink,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add_circle_outlined,
                                  color: kPrimaryMaroon,
                                ),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                const Text(
                                  "Izin Sakit",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryMaroon),
                                )
                              ],
                            ),
                          )),
                      TextButton(
                          onPressed: () async {
                            DateTimeRange? selectedDateRange =
                                await showDateRangePicker(
                                    context: context,
                                    initialDateRange: DateTimeRange(
                                        start: DateTime.now(),
                                        end: DateTime.now()),
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime(2023),
                                    confirmText: "Cuti",
                                    cancelText: "Batal");

                            if (selectedDateRange != null) {
                              await data.checkInCuti(selectedDateRange);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kPrimaryPink,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_circle_outlined,
                                  color: kPrimaryMaroon,
                                ),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                Text(
                                  "Izin Cuti",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryMaroon),
                                )
                              ],
                            ),
                          ))
                    ],
                  )
                ],
              )),
          if (uploadTask != null) ...[
            SizedBox(
              height: size.height * 0.02,
            ),
            buildProgress(),
          ],
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Data 5 hari terakhir",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          // section list data 5 hari terakhir
          SizedBox(
            height: size.height * 0.02,
          ),
          data.aWeek.isEmpty
              ? Container(
                  margin: EdgeInsets.only(
                      bottom: size.height * 0.07, top: size.height * 0.03),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text("Data is Empty"),
                  ))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.aWeek.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return data.aWeek[index].status == "hadir"
                        ? Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: 100,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: kPrimaryPink,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('dd')
                                            .format(DateTime.parse(
                                                data.aWeek[index].checkIn))
                                            .toString(),
                                        style: TextStyle(
                                            color: kPrimaryMaroon,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormat('E')
                                                .format(DateTime.parse(
                                                    data.aWeek[index].checkIn))
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            DateFormat('MMMM')
                                                .format(DateTime.parse(
                                                    data.aWeek[index].checkIn))
                                                .toString(),
                                            style: TextStyle(fontSize: 16),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Masuk",
                                      style: TextStyle(),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      DateFormat.Hms()
                                          .format(DateTime.parse(
                                              data.aWeek[index].checkIn))
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryMaroon),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Keluar",
                                      style: TextStyle(),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      data.aWeek[index].checkOut != ""
                                          ? DateFormat.Hms()
                                              .format(DateTime.parse(
                                                  data.aWeek[index].checkOut))
                                              .toString()
                                          : "-",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryMaroon),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFE0E0E0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: 100,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFBDBDBD),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('dd')
                                            .format(DateTime.parse(
                                                data.aWeek[index].checkIn))
                                            .toString(),
                                        style: const TextStyle(
                                            color: Color(0xFF333333),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormat('E')
                                                .format(DateTime.parse(
                                                    data.aWeek[index].checkIn))
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            DateFormat('MMMM')
                                                .format(DateTime.parse(
                                                    data.aWeek[index].checkIn))
                                                .toString(),
                                            style: TextStyle(fontSize: 16),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Keterangan",
                                      style: TextStyle(),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Izin ${data.aWeek[index].status}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                  },
                )
        ],
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;

            return SizedBox(
              height: 20,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey,
                        color: kPrimaryMaroon,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 50,
            );
          }
        },
      );
}
