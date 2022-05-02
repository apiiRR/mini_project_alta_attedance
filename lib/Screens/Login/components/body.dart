import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mini_project_alta_attedance/Screens/Homepage/homepage.dart';
import 'package:mini_project_alta_attedance/Screens/Navigation/navigation.dart';
import 'package:mini_project_alta_attedance/Screens/Login/login_view_model.dart';
import 'package:mini_project_alta_attedance/provider/authservice.dart';
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
            /* const Text(
              "LOGIN",
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
              "Login",
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
                child: Column(
                  children: [
                    const RoundedInputField(
                      hintText: "Email",
                      name: 'email',
                    ),
                    const RoundedPasswordField(),
                    Consumer<AuthService>(
                      builder: (context, value, child) => RoundedButton(
                          text: "LOGIN",
                          press: () async {
                            context.loaderOverlay.show();
                            _formKey.currentState!.save();
                            value
                                .loginUser(
                                    email:
                                        _formKey.currentState!.value["email"],
                                    password: _formKey
                                        .currentState!.value["password"])
                                .then((value) {
                              if (value == false) {
                                context.loaderOverlay.hide();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Email & Password anda salah!!"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
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
                                      builder: (_) => const HomePage()),
                                  (Route) => false,
                                );
                              }
                            });
                            /* Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => navigation(),
                              ),
                              (route) => false,
                            ); */
                          }),
                    ),
                  ],
                )),
            SizedBox(
              height: size.height * 0.02,
            ),
            AlreadyHaveAccount(
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
