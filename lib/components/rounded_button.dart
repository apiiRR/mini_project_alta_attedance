import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton(
      {Key? key,
      required this.text,
      required this.press,
      this.color = kPrimaryMaroon,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.9,
      height: 55,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
            onPressed: () {
              press();
            },
            style: ButtonStyle(
              /* padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 40)), */
              backgroundColor: MaterialStateProperty.all<Color>(color),
            ),
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w900),
            )),
      ),
    );
  }
}
