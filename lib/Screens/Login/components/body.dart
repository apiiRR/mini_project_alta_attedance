import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_project_alta_attedance/Screens/Home/homescreen.dart';
import 'package:mini_project_alta_attedance/Screens/Login/login_view_model.dart';
import 'package:provider/provider.dart';
import '/Screens/Singup/singup_screen.dart';
import '/components/rounded_button.dart';
// import '/constants.dart';

import '../../../components/already_have_account.dart';
import '../../../components/rounded_input_field.dart';
import '../../../components/rounded_password_field.dart';
// import '../../../components/text_field_container.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormBuilderState>();
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    const RoundedInputField(
                      hintText: "Your Email",
                      name: 'email',
                    ),
                    const RoundedPasswordField(),
                    Consumer<LoginViewModel>(
                      builder: (context, value, child) => RoundedButton(
                          text: "LOGIN",
                          press: () async {
                            _formKey.currentState!.save();
                            value
                                .accountAuth(
                                    _formKey.currentState!.value["email"],
                                    _formKey.currentState!.value["password"])
                                .then((value) {
                              if (value == false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Email & Password anda salah!!"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.only(bottom: 50.0),
                                    content: Text("Login Berhasil!!"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const HomeScreen()));
                              }
                            });
                            /* Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => HomeScreen(),
                              ),
                              (route) => false,
                            ); */
                          }),
                    ),
                  ],
                )),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAccount(
              press: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
