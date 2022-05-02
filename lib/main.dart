import 'package:flutter/material.dart';
import 'package:mini_project_alta_attedance/Screens/Homepage/homepage.dart';
import 'package:mini_project_alta_attedance/provider/authservice.dart';
import 'package:provider/provider.dart';
import '/Screens/Welcome/welcome_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthService(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List user = Provider.of<AuthService>(context).getUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
      home: user.isEmpty ? WelcomeScreen() : HomePage(),
    );
  }
}
