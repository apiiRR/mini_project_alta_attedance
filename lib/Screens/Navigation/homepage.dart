import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project_alta_attedance/Screens/Navigation/components/day.dart';
import 'package:mini_project_alta_attedance/Screens/Navigation/components/time.dart';

import 'package:mini_project_alta_attedance/view_model/data_view_model.dart';
import 'package:mini_project_alta_attedance/view_model/profile_view_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../Profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataViewModel>(context);
    final profile = Provider.of<ProfileViewModel>(context);
    final dataCheckIn = data.allData;
    final currentData = data.currentData;
    final dataProfile = profile.data[0];
    // final currentData = data.currentData;
    // final dataCheckIn = data.data;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ProfileScreen()));
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 1)),
                          ],
                          shape: BoxShape.circle,
                          color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            fontFamily: 'Poppins'),
                      ),
                      Text(
                        dataProfile != null ? dataProfile.name : "Username",
                        style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                      )
                    ],
                  )
                ],
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: kPrimaryMaroon),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "NIP : ${dataProfile != null ? dataProfile.nip : "-"}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          "Job : ${dataProfile != null ? dataProfile.job : "-"}",
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Day(),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Time(),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Divider(
                  color: kPrimarygrey,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 25.0,
                      percent: 0.8,
                      progressColor: kPrimaryMaroon,
                      backgroundColor: kPrimaryOrange,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: kPrimaryMaroon,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Text(
                              "Present 80%",
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: kPrimaryOrange,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Text(
                              "Absent 20%",
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: AssetImage("assets/images/Group_179.png"),
                  fit: BoxFit.cover),
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
                      "Check In",
                      style: TextStyle(color: kPrimaryMaroon),
                    ),
                    Text(
                      currentData != null && currentData != ""
                          ? DateFormat.Hms()
                              .format(DateTime.parse(currentData.checkIn))
                              .toString()
                          : "-",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: kPrimaryMaroon),
                    ),
                  ],
                ),
                Container(
                  width: 2,
                  height: 40,
                  color: kPrimaryMaroon,
                ),
                Column(
                  children: [
                    Text("Check Out", style: TextStyle(color: kPrimaryMaroon)),
                    Text(
                      currentData != null &&
                              currentData != "" &&
                              currentData.checkOut != ""
                          ? DateFormat.Hms()
                              .format(DateTime.parse(currentData.checkOut))
                              .toString()
                          : "-",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: kPrimaryMaroon),
                    ),
                  ],
                ),
                Container(
                  width: 2,
                  height: 40,
                  color: kPrimaryMaroon,
                ),
                Column(
                  children: [
                    Text("Duration", style: TextStyle(color: kPrimaryMaroon)),
                    Text(
                      currentData != null &&
                              currentData != "" &&
                              currentData.duration != ""
                          ? "${currentData.duration} min"
                          : "- min",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: kPrimaryMaroon),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Last 5 days",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
              // TextButton(
              //     onPressed: () {},
              //     child: Text(
              //       "See more",
              //       style: TextStyle(color: kPrimaryMaroon),
              //     ))
            ],
          ),
          dataCheckIn.isEmpty
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
                  itemCount: dataCheckIn.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
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
                            offset: Offset(0, 2), // changes position of shadow
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
                                          dataCheckIn[index].checkIn))
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat('E')
                                          .format(DateTime.parse(
                                              dataCheckIn[index].checkIn))
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      DateFormat('MMMM')
                                          .format(DateTime.parse(
                                              dataCheckIn[index].checkIn))
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
                                "Check In",
                                style: TextStyle(),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                DateFormat.Hms()
                                    .format(DateTime.parse(
                                        dataCheckIn[index].checkIn))
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
                                "Check Out",
                                style: TextStyle(),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                dataCheckIn[index].checkOut != ""
                                    ? DateFormat.Hms()
                                        .format(DateTime.parse(
                                            dataCheckIn[index].checkOut))
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
                    );
                  },
                )
        ],
      ),
    );
  }
}
