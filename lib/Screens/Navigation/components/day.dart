import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Day extends StatelessWidget {
  const Day({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var result = DateFormat('E, dd MMMM').format(now);
    return Text(
      result
    );
  }
}