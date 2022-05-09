import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../components/option.dart';
import '../../constants.dart';
import '../Profile/profile.dart';
import 'navigation_view_model.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<NavigationViewModel>(context);
    final dataCheckIn = data.data;
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
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (_) => ProfileScreen()))
                          .then((value) {
                        setState(() {
                          print('update state');
                          data.syncDataWithProvider();
                          print('after update');
                        });
                      });
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
                        data.account.length > 0 ? data.account[1] : "Username",
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
            height: size.height * 0.03,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Option(text: 'All'),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'January'),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'February'),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'Maret'),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'April'),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'May'),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'June'),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'July'),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'August'),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'September'),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'October'),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'November'),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'December'),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            width: size.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("assets/images/Pattern.png"),
                  fit: BoxFit.cover),
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
                Text(
                  "All Duration",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                CircularPercentIndicator(
                  radius: 70.0,
                  lineWidth: 16.0,
                  percent: 1,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "153",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 36,
                        ),
                      ),
                      Text("Hours"),
                    ],
                  ),
                  progressColor: kPrimaryMaroon,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
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
                "History",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          dataCheckIn.isEmpty
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
