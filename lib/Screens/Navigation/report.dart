import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

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
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(profile.data != null &&
                                    profile.data!.photo != ""
                                ? profile.data!.photo
                                : "https://firebasestorage.googleapis.com/v0/b/mini-project-flutter-aee89.appspot.com/o/files%2Fuser_profile.png?alt=media&token=5e79293e-e1d6-4e1b-a61a-07a80960e313")),
                      ),
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
                        profile.data != null && profile.data!.name != ""
                            ? profile.data!.name
                            : "Name Unknown",
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
                Option(text: 'All', index: 0),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'January', index: 1),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'February', index: 2),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'Maret', index: 3),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'April', index: 4),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'May', index: 5),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'June', index: 6),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'July', index: 7),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'August', index: 8),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'September', index: 9),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'October', index: 10),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'November', index: 11),
                const SizedBox(
                  width: 8,
                ),
                Option(text: 'December', index: 12),
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
              IconButton(onPressed: () {
                data.exportPDF();
              }, icon: Icon(Icons.download, size: 32,), color: kPrimaryMaroon,),
            ],
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
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 1),
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
                                          data.aMonth[index].checkIn))
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
                                              data.aMonth[index].checkIn))
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      DateFormat('MMMM')
                                          .format(DateTime.parse(
                                              data.aMonth[index].checkIn))
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
                                        data.aMonth[index].checkIn))
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
                                data.aMonth[index].checkOut != ""
                                    ? DateFormat.Hms()
                                        .format(DateTime.parse(
                                            data.aMonth[index].checkOut))
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

  Widget Option({required String text, required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });

        Provider.of<DataViewModel>(context, listen: false).filterMonth(index);
      },
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          // color: optionSelected[index] ? kPrimaryColor : Colors.white,
          color: _currentIndex == index ? kPrimaryMaroon : kPrimarygrey,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 0),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                // color: optionSelected[index] ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
