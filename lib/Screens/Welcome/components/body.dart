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
            /* 
             */
            // SizedBox(height: size.height * 0.03,),
            SvgPicture.asset(
              "assets/icons/Illustration-welcome.svg",
              height: size.height * 0.30,
            ),
            SizedBox(height: size.height * 0.05,),
            Text("Welcome", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, fontFamily: 'Poppins'),),
            SizedBox(height: size.height * 0.02,),
            Text("The attendance application for employees enable accurate time tracking", textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),),
            SizedBox(height: size.height * 0.02,),
            RoundedButton(
              text: "Login",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder:  (_) {
                  return const LoginScreen();
                }));
              },
            ),
            RoundedButton(
              text: "Sign Up",
              textColor: Colors.white,
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
