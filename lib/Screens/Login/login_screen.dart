import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'components/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoaderOverlay(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}