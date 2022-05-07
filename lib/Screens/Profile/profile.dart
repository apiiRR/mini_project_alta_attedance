import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mini_project_alta_attedance/Screens/Profile/components/body.dart';
// import 'package:mini_project_alta_attedance/Screens/Profile/profile_view_model.dart';
// import 'package:mini_project_alta_attedance/Screens/Welcome/welcome_screen.dart';
// import 'package:mini_project_alta_attedance/provider/authservice.dart';
// import 'package:provider/provider.dart';
// import '../../components/top_background.dart';
// import '../../constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  // final bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    // print("build ulang bros");
    // final profile = Provider.of<ProfileViewModel>(context, listen: false);
    // // Size size = MediaQuery.of(context).size;
    // print(profile.account);
    // final _formKey = GlobalKey<FormBuilderState>();
    return LoaderOverlay(child: Scaffold(body: Body()));
    // body: Container(
    //     width: double.infinity,
    //     height: size.height,
    //     child: Stack(
    //         // alignment: Alignment.center,
    //         children: [
    //           TopBackground(size: size),

    //           Positioned(
    //               top: size.height * 0.05,
    //               left: size.width * 0.05,
    //               child: Container(
    //                 height: 40,
    //                 width: 40,
    //                 decoration: BoxDecoration(
    //                     shape: BoxShape.circle,
    //                     boxShadow: [
    //                       BoxShadow(
    //                           spreadRadius: 2,
    //                           blurRadius: 10,
    //                           color: Colors.black.withOpacity(0.1),
    //                           offset: Offset(0, 1)),
    //                     ],
    //                     color: Colors.white),
    //                 child: IconButton(
    //                   onPressed: () {
    //                     Navigator.pop(context);
    //                   },
    //                   icon: Icon(Icons.arrow_back),
    //                   color: kPrimaryMaroon,
    //                 ),
    //               )),
    //         ])));
  }
}
