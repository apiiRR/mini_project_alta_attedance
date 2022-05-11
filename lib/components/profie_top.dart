import 'package:flutter/material.dart';
import 'package:mini_project_alta_attedance/Screens/Profile/profile.dart';
import '../constants.dart';

class ProfileTop extends StatelessWidget {
  const ProfileTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context)
                            .scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 1)),
                    ],
                    shape: BoxShape.circle,
                    color: Colors.grey),
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Welcome",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'Poppins'),
                ),
                Text("Username",
                  style: TextStyle(
                      fontSize: 20, fontFamily: 'Poppins'),
                )
              ],
            )
          ],
        ),
        Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: kPrimaryMaroon),
          child: const Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}