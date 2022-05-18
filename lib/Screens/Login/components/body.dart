import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mini_project_alta_attedance/Screens/Navigation/navigation.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:validators/validators.dart';
import '../../../constants.dart';
import '../../../view_model/auth_view_model.dart';
import '/Screens/Singup/singup_screen.dart';
import '/components/rounded_button.dart';
// import '/constants.dart';

import '../../../components/already_have_account.dart';
import '../../../components/rounded_input_field.dart';
import '../../../components/rounded_password_field.dart';
// import '../../../components/text_field_container.dart';
import 'background.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool showEmail = false;
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthViewModel>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormBuilderState>();
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const Text(
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
                    RoundedInputField(
                      hintText: "Email",
                      name: 'email',
                      val: (value) {
                        if (value != null &&
                            value.toString().length > 0 &&
                            isEmail(value)) {
                          setState(() {
                            showEmail = false;
                          });
                          return null;
                        } else {
                          setState(() {
                            showEmail = true;
                          });
                          return "";
                        }
                      },
                    ),
                    if (showEmail) ...[
                      const Text(
                        "* Email tidak valid",
                        style: TextStyle(color: kPrimaryMaroon),
                      ),
                    ],
                    RoundedPasswordField(
                      val: (value) {
                        if (value != null && value.toString().length > 0) {
                          setState(() {
                            showPassword = false;
                          });
                          return null;
                        } else {
                          setState(() {
                            showPassword = true;
                          });
                          return "";
                        }
                      },
                    ),
                    if (showPassword) ...[
                      const Text(
                        "* Password tidak boleh kosong",
                        style: TextStyle(color: kPrimaryMaroon),
                      ),
                    ],
                    RoundedButton(
                        text: "LOGIN",
                        press: () async {
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            context.loaderOverlay.show();
                            auth
                                .signIn(_formKey.currentState!.value["email"],
                                    _formKey.currentState!.value["password"])
                                .then((value) {
                              if (value == true) {
                                context.loaderOverlay.hide();
                                showTopSnackBar(
                                  context,
                                  const CustomSnackBar.success(
                                    message:
                                        "Selamat... signup anda berhasil!!",
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
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message: value["error"]["message"],
                                  ),
                                );
                              }
                            });
                          }
                        }),
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
