import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: size.height * 0.5,
              child: Image.asset(
                "assets/images/Illustration-background.png",
                // width: size.width * 0.3,
                fit: BoxFit.fill,
              )),
          // Positioned(
          //     bottom: 0,
          //     left: 0,
          //     child: Image.asset(
          //       "assets/images/main_bottom.png",
          //       width: size.width * 0.2,
          //     )),
          child,
        ],
      ),
    );
  }
}
