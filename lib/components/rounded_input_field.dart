import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../constants.dart';
import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final String name;
  final Function val;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.name,
    required this.val,
    this.icon = Icons.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: FormBuilderTextField(
        name: name,
        validator: (value) {
          return val(value);
        },
        textCapitalization: name == "username"
            ? TextCapitalization.words
            : TextCapitalization.none,
        keyboardType: name == "username"
            ? TextInputType.name
            : TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 16),
          icon: Icon(
            icon,
            color: kPrimaryMaroon,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
