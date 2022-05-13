import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project_alta_attedance/constants.dart';

class Time extends StatefulWidget {
  const Time({ Key? key }) : super(key: key);

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  Timer? timer;
  var jam = '';
  void startJam() {
    timer = Timer.periodic(new Duration(seconds: 1), (_) {
      var tgl = new DateTime.now();
      var formatedjam = new DateFormat.Hms().format(tgl);
      setState(() {
          jam = formatedjam;
      });
    });
  }

  @override
  void initState() {
    if (mounted) {
      startJam();
    } else {
      return;
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Text(
      jam, style: TextStyle(color: kPrimaryMaroon, fontWeight: FontWeight.bold, fontSize: 36),
    );
  }
}