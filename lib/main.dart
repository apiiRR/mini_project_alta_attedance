import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mini_project_alta_attedance/Screens/Navigation/homepage.dart';
import 'package:mini_project_alta_attedance/Screens/Navigation/navigation.dart';
import 'package:mini_project_alta_attedance/view_model/auth_view_model.dart';
import 'package:mini_project_alta_attedance/view_model/data_view_model.dart';
import 'package:mini_project_alta_attedance/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import '/Screens/Welcome/welcome_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthViewModel(),
        ),
        ChangeNotifierProxyProvider<AuthViewModel, DataViewModel>(
          create: (context) => DataViewModel(),
          update: (context, auth, datas) =>
              datas!..updateData(auth.token, auth.userId),
        ),
        ChangeNotifierProxyProvider<AuthViewModel, ProfileViewModel>(
          create: (context) => ProfileViewModel(),
          update: (context, auth, datas) =>
              datas!..updateData(auth.token, auth.userId),
        ),
      ],
      builder: (context, child) => Consumer<AuthViewModel>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
          home: auth.isAuth
              ? Navigation()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    return WelcomeScreen();
                  },
                ),
        ),
      ),
    );
  }
}
