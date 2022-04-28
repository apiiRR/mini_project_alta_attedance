import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/Screens/Login/login_screen.dart';
import '/Screens/Singup/singup_screen.dart';
import '/constants.dart';

import '../../../components/rounded_button.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "WELCOME TO EDU",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03,),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05,),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder:  (_) {
                  return const LoginScreen();
                }));
              },
            ),
            RoundedButton(
              text: "SING UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
