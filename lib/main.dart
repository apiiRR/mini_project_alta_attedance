import 'package:flutter/material.dart';
import 'package:mini_project_alta_attedance/Screens/Navigation/navigation.dart';
import 'package:mini_project_alta_attedance/Screens/Navigation/navigation_view_model.dart';
import 'package:mini_project_alta_attedance/Screens/Profile/profile_view_model.dart';
import 'package:mini_project_alta_attedance/provider/authservice.dart';
import 'package:provider/provider.dart';
import '/Screens/Welcome/welcome_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthService(),
    ),
    ChangeNotifierProvider(create: (context) => ProfileViewModel()),
    ChangeNotifierProvider(create: (context) => NavigationViewModel()),
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
      home: user.isEmpty ? const WelcomeScreen() : const Navigation(),
    );
  }
}
