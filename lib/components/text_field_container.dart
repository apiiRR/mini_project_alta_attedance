import 'package:flutter/material.dart';

import '../constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: size.width * 0.9,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(29),
            border: Border.all(color: kPrimaryMaroon, width: 2),
            color: const Color(0xFFFFFFFF),
          ),
          child: child,
        )
      ],
    );
  }
}
