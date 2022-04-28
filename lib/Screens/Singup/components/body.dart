import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_project_alta_attedance/Screens/Singup/signup_view_model.dart';
import 'package:mini_project_alta_attedance/models/account.dart';
import 'package:provider/provider.dart';
import '/Screens/Login/login_screen.dart';
import '/components/already_have_account.dart';
import '/components/rounded_button.dart';
import '/components/rounded_input_field.dart';
import '/components/rounded_password_field.dart';
// import '/constants.dart';

import 'background.dart';
// import 'or_divider.dart';
// import 'social_icon.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime datetimeNow = DateTime.now();
    Size size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormBuilderState>();
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            FormBuilder(
                key: _formKey,
                child: Column(children: [
                  const RoundedInputField(
                    hintText: "Your Name",
                    name: 'username',
                    icon: Icons.person,
                  ),
                  const RoundedInputField(
                    hintText: "Your Email",
                    name: 'email',
                    icon: Icons.email_rounded,
                  ),
                  const RoundedPasswordField(),
                  Consumer<SignupViewModel>(
                      builder: (context, value, child) => RoundedButton(
                          text: "SIGNUP",
                          press: () {
                            _formKey.currentState!.save();
                            value
                                .signUp(Account(
                                    id: 0.toString(),
                                    name: _formKey
                                        .currentState!.value["username"],
                                    email:
                                        _formKey.currentState!.value["email"],
                                    password: _formKey
                                        .currentState!.value["password"],
                                    createdAt: datetimeNow))
                                .then((value) {
                              if (value == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Signup berhasil, silahkan lakukan login."),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Email sudah pernah didaftarkan."),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            });
                          })),
                ])),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAccount(
              login: false,
              press: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
            ),
            /* OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            ) */
          ],
        ),
      ),
    );
  }
}
