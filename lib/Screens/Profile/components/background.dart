import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key, required this.child, required this.childBottom})
      : super(key: key);
  final Widget child;
  final Widget childBottom;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: size.height,
            child: Stack(
                // alignment: Alignment.center,
                children: [
                  Positioned(
                      top: -90,
                      left: 0,
                      right: 0,
                      height: size.height * 0.5,
                      child: Image.asset(
                        "assets/images/Illustration-background_3.png",
                        fit: BoxFit.fill,
                      )),
                  child,
                  childBottom
                ])));
  }
}
