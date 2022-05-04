import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: const Scaffold(
        body: Body(),
      ),
    );
  }
}