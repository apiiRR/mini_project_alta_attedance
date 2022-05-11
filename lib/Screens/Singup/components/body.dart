import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mini_project_alta_attedance/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import '../../Navigation/navigation.dart';
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
    var auth = Provider.of<AuthViewModel>(context, listen: false);
    DateTime datetimeNow = DateTime.now();
    Size size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormBuilderState>();
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* const Text(
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ), */
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/Illustration-welcome.svg",
              height: size.height * 0.30,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            FormBuilder(
                key: _formKey,
                child: Column(children: [
                  const RoundedInputField(
                    hintText: "Name",
                    name: 'username',
                    icon: Icons.person,
                  ),
                  const RoundedInputField(
                    hintText: "Email",
                    name: 'email',
                    icon: Icons.email_rounded,
                  ),
                  const RoundedPasswordField(),
                  RoundedButton(
                      text: "Sign Up",
                      press: () {
                        context.loaderOverlay.show();
                        _formKey.currentState!.save();
                        auth
                            .signUp(
                                _formKey.currentState!.value["username"],
                                _formKey.currentState!.value["email"],
                                _formKey.currentState!.value["password"],
                                datetimeNow,
                                "",
                                "")
                            .then((value) {
                          if (value == true) {
                            context.loaderOverlay.hide();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(bottom: 50.0),
                                content: Text("Login Berhasil!!"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Navigation()),
                              (Route) => false,
                            );
                          } else {
                            print(value);
                            context.loaderOverlay.hide();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(value["error"]["message"]),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        });
                      }),
                ])),
            SizedBox(
              height: size.height * 0.02,
            ),
            AlreadyHaveAccount(
              login: false,
              press: () {
                /* Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const LoginScreen())); */
                Navigator.pop(context);
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
