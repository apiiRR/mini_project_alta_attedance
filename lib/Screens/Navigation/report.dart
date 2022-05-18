import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../view_model/data_view_model.dart';
import '../../view_model/profile_view_model.dart';
import '../Profile/profile.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  int _currentIndex = 0;
  var _chosenValue;
  List<String> month = [
    'All',
    'January',
    'February',
    'Maret',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileViewModel>(context);
    final data = Provider.of<DataViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: kPrimaryPink,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: DropdownButton<String>(
              menuMaxHeight: 200,
              focusColor: Colors.white,
              //elevation: 5,
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              items: month.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              hint: Row(
                children: [
                  Icon(
                    Icons.date_range,
                    color: kPrimaryMaroon,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Select Month",
                    style: TextStyle(
                        color: kPrimaryMaroon,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              onChanged: (value) {
                setState(() {
                  _chosenValue = value!;
                });
                data.filterMonth(month.indexOf(value!));
                print(month.indexOf(value));
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          InkWell(
            onTap: () {
              data.exportPDF(profile.data!);
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: kPrimaryPink,
                  borderRadius: BorderRadius.circular(20),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_download_outlined,
                        color: kPrimaryMaroon,
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        "Download PDF",
                        style: TextStyle(
                            color: kPrimaryMaroon,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Report ${_chosenValue != null ? _chosenValue : 'All'}",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          data.aMonth.isEmpty
              ? Container(
                  margin: EdgeInsets.only(
                      bottom: size.height * 0.3, top: size.height * 0.03),
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
                  itemCount: data.aMonth.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return data.aMonth[index].status == "hadir"
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: kPrimaryMaroon,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                      ),
                                      child: Text(
                                        DateFormat('EEEE').format(
                                            DateTime.parse(
                                                data.aMonth[index].checkIn)),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color: kPrimaryPink,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              bottomRight: Radius.circular(8)),
                                        ),
                                        child: Text(
                                          DateFormat('dd MMMM yyyy').format(
                                              DateTime.parse(
                                                  data.aMonth[index].checkIn)),
                                          style: const TextStyle(
                                              color: kPrimaryMaroon,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.av_timer_rounded,
                                        color: kPrimaryMaroon,
                                      ),
                                      SizedBox(width: size.width * 0.02),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("Check In"),
                                              Text(
                                                  DateFormat.Hms().format(
                                                      DateTime.parse(data
                                                          .aMonth[index]
                                                          .checkIn)),
                                                  style: const TextStyle(
                                                    color: kPrimaryMaroon,
                                                    fontWeight: FontWeight.bold,
                                                  ))
                                            ],
                                          ),
                                          SizedBox(width: size.width * 0.15),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("Check Out"),
                                              Text(
                                                  DateFormat.Hms().format(
                                                      DateTime.parse(data
                                                          .aMonth[index]
                                                          .checkOut)),
                                                  style: const TextStyle(
                                                    color: kPrimaryMaroon,
                                                    fontWeight: FontWeight.bold,
                                                  ))
                                            ],
                                          )
                                        ],
                                      )
                                    ]),
                                const Divider(
                                  color: kPrimarygrey,
                                  thickness: 1,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.timer_outlined,
                                      color: kPrimaryMaroon,
                                    ),
                                    SizedBox(width: size.width * 0.02),
                                    Row(
                                      children: [
                                        const Text("Durasi Kerja : "),
                                        Text(
                                          "${data.aMonth[index].duration} menit",
                                          style: const TextStyle(
                                              color: kPrimaryMaroon),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ))
                        : Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFE0E0E0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF333333),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                      ),
                                      child: Text(
                                        DateFormat('EEEE').format(
                                            DateTime.parse(
                                                data.aMonth[index].checkIn)),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFBDBDBD),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              bottomRight: Radius.circular(8)),
                                        ),
                                        child: Text(
                                          DateFormat('dd MMMM yyyy').format(
                                              DateTime.parse(
                                                  data.aMonth[index].checkIn)),
                                          style: const TextStyle(
                                              color: Color(0xFF333333),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.av_timer_rounded,
                                        color: Color(0xFF4F4F4F),
                                      ),
                                      SizedBox(width: size.width * 0.02),
                                      Text("Izin ${data.aMonth[index].status}")
                                    ]),
                                const Divider(
                                  color: kPrimarygrey,
                                  thickness: 1,
                                ),
                                data.aMonth[index].status == "sakit"
                                    ? Row(
                                        children: [
                                          const Icon(
                                            Icons.description_outlined,
                                            color: Color(0xFF4F4F4F),
                                          ),
                                          SizedBox(width: size.width * 0.02),
                                          Row(
                                            children: [
                                              const Text("Bukti : "),
                                              GestureDetector(
                                                onTap: () async {
                                                  await launchUrl(
                                                      Uri.parse(data.aMonth[index].doc), mode: LaunchMode.externalApplication);
                                                  /* await OpenFile.open(data.aMonth[index].doc); */
                                                },
                                                child: const Text(
                                                  "Lihat Surat Izin Sakit",
                                                  style: TextStyle(
                                                      color: kPrimaryMaroon),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          const Icon(
                                            Icons.timer_outlined,
                                            color: Color(0xFF4F4F4F),
                                          ),
                                          SizedBox(width: size.width * 0.02),
                                          Row(
                                            children: [
                                              const Text("Durasi Kerja : "),
                                              const Text(
                                                "0 menit",
                                                style: const TextStyle(
                                                    color: Color(0xFF4F4F4F)),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                              ],
                            ));
                  },
                )
        ],
      ),
    );
  }
}
