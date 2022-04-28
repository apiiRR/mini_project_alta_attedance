import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../constants.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: FormBuilderTextField(
      name: 'password',
      obscureText: true,
      decoration: const InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none),
    ));
  }
}
