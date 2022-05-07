import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextInputProfile extends StatefulWidget {
  const TextInputProfile(
      {Key? key,
      required this.labelText,
      required this.isPassword,
      required this.name,
      required this.initial})
      : super(key: key);
  final String labelText;
  final bool isPassword;
  final String name;
  final String initial;

  @override
  State<TextInputProfile> createState() => _TextInputProfileState();
}

class _TextInputProfileState extends State<TextInputProfile> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: FormBuilderTextField(
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        name: widget.name,
        initialValue: widget.initial,
        obscureText: widget.isPassword ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
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
          labelText: widget.labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // hintText: placeHolder,
          /* hintStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black), */
        ),
      ),
    );
  }
}
