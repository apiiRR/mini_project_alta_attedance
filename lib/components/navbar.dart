import 'package:flutter/material.dart';
import 'package:mini_project_alta_attedance/Screens/Homepage/homepage.dart';
import 'package:mini_project_alta_attedance/Screens/Profile/profile.dart';

import '../constants.dart';

class Navbar extends StatelessWidget {
  final homeActive;
  final profileActive;
  const Navbar({ Key? key, required this.homeActive, required this.profileActive }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
                  },
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: homeActive ? kPrimaryMaroon : kPrimarygrey,
                        size: 36,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                            color: homeActive ? kPrimaryMaroon : kPrimarygrey, fontFamily: 'Poppins'),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
                  },
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.data_exploration,
                        color: profileActive ? kPrimaryMaroon : kPrimarygrey,
                        size: 36,
                      ),
                      Text(
                        'Report',
                        style: TextStyle(
                            color: profileActive ? kPrimaryMaroon : kPrimarygrey, fontFamily: 'Poppins'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}