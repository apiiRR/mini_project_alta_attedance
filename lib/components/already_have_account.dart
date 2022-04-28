import 'package:flutter/material.dart';

import '../constants.dart';

class AlreadyHaveAccount extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAccount({
    Key? key, this.login = true, required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don't have an Account ? " : "Already have an Account ?",
          style: const TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: () {
            press();
          },
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: const TextStyle(
                color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}