import 'package:flutter/material.dart';

import '../constants.dart';

class Option extends StatefulWidget {
  const Option({Key? key, required this.text, required this.isActive})
      : super(key: key);
  final String text;
  final String isActive;

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          // color: optionSelected[index] ? kPrimaryColor : Colors.white,
          color: widget.isActive == widget.text ? kPrimaryMaroon : kPrimarygrey,
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
            widget.text,
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
