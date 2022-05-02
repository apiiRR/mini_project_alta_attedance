import 'package:flutter/material.dart';

import '../../components/navbar.dart';
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
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
                              color: Colors.green),
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
      padding: const EdgeInsets.only(bottom: 35),
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
