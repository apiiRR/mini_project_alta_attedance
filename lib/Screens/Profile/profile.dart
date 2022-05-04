import 'package:flutter/material.dart';
import 'package:mini_project_alta_attedance/Screens/Profile/profile_view_model.dart';
import 'package:mini_project_alta_attedance/Screens/Welcome/welcome_screen.dart';
import 'package:mini_project_alta_attedance/provider/authservice.dart';
import 'package:provider/provider.dart';

import '../../components/navbar.dart';
import '../../components/profie_top.dart';
import '../../components/top_background.dart';
import '../../constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthService>(context);
    var getUser = auth.getUser();
    var profile = Provider.of<ProfileViewModel>(context);
    var getData = profile.getAccount(getUser[0]);
    print(profile.account);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          // alignment: Alignment.center,
          children: [
            TopBackground(size: size),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.09,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
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
                                    offset: Offset(0, 1)),
                              ],
                              shape: BoxShape.circle,
                              color: Colors.grey),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  color: kPrimaryMaroon),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(profile.account[3] ?? "Tidak Diketahui",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(profile.account[2] ?? "Tidak Diketahui"),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    padding: EdgeInsets.only(
                        top: 20, right: 20, left: 20, bottom: 10),
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        buildTextField("NIP", "1234567890", false),
                        buildTextField(
                            "Full Name", "Michella Aurora Cantik", false),
                        buildTextField("Email", "Michella@gmail.com", false),
                        buildTextField("Password", "rafi ramadhana", true),
                        buildTextField("Job", "Menyayangi mas rafi", false),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF26765B)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 36, vertical: 12)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              elevation: MaterialStateProperty.all(2)),
                          onPressed: () {},
                          child: Text(
                            "Update",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kPrimaryMaroon),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 36, vertical: 12)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              elevation: MaterialStateProperty.all(2)),
                          onPressed: () {
                            auth.refresh();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => WelcomeScreen()), (route) => false);
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      /* TextButton(onPressed: () {}, child: Text("Update"), style: ButtonStyle(textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14, letterSpacing: 2.2, color: Colors.black)))), */
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
            Positioned(
                top: size.height * 0.05,
                left: size.width * 0.05,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 1)),
                      ],
                      color: Colors.white),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);                    },
                    icon: Icon(Icons.arrow_back),
                    color: kPrimaryMaroon,
                  ),
                )),
            /* GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  /* Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ), */
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
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
                                    offset: Offset(0, 1)),
                              ],
                              shape: BoxShape.circle,
                              color: Colors.grey),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  color: kPrimaryMaroon),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  buildTextField("Full Name", "Michella Aurora Cantik", false),
                  buildTextField("Email", "Michella@gmail.com", false),
                  buildTextField("Password", "rafi ramadhana", true),
                  buildTextField("Job", "Menyayangi mas rafi", false),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(horizontal: 50)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              elevation: MaterialStateProperty.all(2)),
                          onPressed: () {},
                          child: Text(
                            "Update",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ))
                      /* TextButton(onPressed: () {}, child: Text("Update"), style: ButtonStyle(textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14, letterSpacing: 2.2, color: Colors.black)))), */
                    ],
                  )
                ],
              ),
            ) */
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.fingerprint,
      //     color: kPrimaryMaroon,
      //     size: 45,
      //   ),
      //   onPressed: () {},
      //   backgroundColor: Colors.white,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: Navbar(homeActive: false, profileActive: true),
    );
  }

  buildTextField(String labelText, String placeHolder, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: TextField(
        obscureText: isPassword ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ))
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
