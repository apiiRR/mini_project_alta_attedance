import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../components/navbar.dart';
import '../../components/profie_top.dart';
import '../../components/top_background.dart';
import '../../constants.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(alignment: Alignment.center, children: [
          TopBackground(size: size),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                ProfileTop(),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      option('All'),
                      const SizedBox(
                        width: 8,
                      ),
                      option('January'),
                      const SizedBox(
                        width: 8,
                      ),
                      option('February'),
                      const SizedBox(
                        width: 8,
                      ),
                      option('Maret'),
                      const SizedBox(
                        width: 8,
                      ),
                      option('April'),
                      const SizedBox(
                        width: 8,
                      ),
                      option('May'),
                      const SizedBox(
                        width: 8,
                      ),
                      option('June'),
                      const SizedBox(
                        width: 8,
                      ),
                      option('July'),
                      const SizedBox(
                        width: 8,
                      ),
                      option('August'),
                      const SizedBox(
                        width: 8,
                      ),
                      option('September'),
                      const SizedBox(
                        width: 8,
                      ),
                      option('October'),
                      const SizedBox(
                        width: 8,
                      ),
                      option('November'),
                      const SizedBox(
                        width: 8,
                      ),
                      option('December'),
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
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
                                  "19",
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
                                      "Fri",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "May",
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
                                "08.58",
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
                                "08.58",
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
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.fingerprint,
          color: kPrimaryMaroon,
          size: 45,
        ),
        onPressed: () {},
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Navbar(homeActive: false, profileActive: true),
    );
  }

  Widget option(String text) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          // color: optionSelected[index] ? kPrimaryColor : Colors.white,
          color: kPrimarygrey,
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
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
