import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../constants.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  const RoundedPasswordField({
    Key? key,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: FormBuilderTextField(
      name: 'password',
      obscureText: showPassword,
      decoration: InputDecoration(
          hintText: "Password",
          hintStyle: const TextStyle(fontSize: 16),
          icon: const Icon(
            Icons.lock,
            color: kPrimaryMaroon,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            icon: const Icon(Icons.visibility),
            color: kPrimaryMaroon,
          ),
          border: InputBorder.none),
    ));
  }
}
