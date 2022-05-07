import 'package:flutter/material.dart';

import '../constants.dart';

class Option extends StatelessWidget {
  const Option({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          // color: optionSelected[index] ? kPrimaryColor : Colors.white,
          color: kPrimarygrey,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 0),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                // color: optionSelected[index] ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
