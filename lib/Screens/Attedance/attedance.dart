import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AttendaceScreen extends StatelessWidget {
  const AttendaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "09:12",
            style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500),
          ),
          Text(
            "Senin, 4 Mei 2022",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,),
          ),
          SizedBox(height: 20,),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.black)
            ),
            child: Icon(Icons.back_hand_rounded, size: 100,),
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.av_timer, size: 50,),
                  SizedBox(height: 10,),
                  Text("09:10", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  Text("Check-In", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.av_timer, size: 50,),
                  SizedBox(height: 10,),
                  Text("09:10", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  Text("Check-In", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.av_timer, size: 50,),
                  SizedBox(height: 10,),
                  Text("09:10", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  Text("Check-In", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),)
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }
}
