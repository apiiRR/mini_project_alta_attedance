import 'package:flutter/material.dart';

class TopBackground extends StatelessWidget {
  const TopBackground({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: size.height * 0.5,
        child: Image.asset(
          "assets/images/Illustration-background_1.png",
          fit: BoxFit.fill,
        ));
  }
}