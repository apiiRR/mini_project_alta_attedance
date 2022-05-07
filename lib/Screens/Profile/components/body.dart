import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mini_project_alta_attedance/Screens/Profile/components/background.dart';
import 'package:mini_project_alta_attedance/Screens/Profile/components/textfield.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../provider/authservice.dart';
import '../../Welcome/welcome_screen.dart';
import '../profile_view_model.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final profile = Provider.of<ProfileViewModel>(context);
    final _formKey = GlobalKey<FormBuilderState>();
    return Background(
      child: body(profile, size, context, _formKey),
      childBottom: Positioned(
          top: size.height * 0.05,
          left: size.width * 0.05,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 1)),
                ],
                color: Colors.white),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: kPrimaryMaroon,
            ),
          )),
    );
  }

  SingleChildScrollView result(Size size, BuildContext context, ProfileViewModel profile, GlobalKey<FormBuilderState> _formKey) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.09,
          ),
          Center(
            child: Stack(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 1)),
                      ],
                      shape: BoxShape.circle,
                      color: Colors.grey),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 4,
                              color:
                                  Theme.of(context).scaffoldBackgroundColor),
                          color: kPrimaryMaroon),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Text(profile.account.length > 0 ? profile.account[1] : "Username",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(profile.account.length > 0 ? profile.account[4] : "Job Name"),
          SizedBox(height: size.height * 0.03),
          Container(
            padding:
                EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  TextInputProfile(
                      name: "nip",
                      labelText: "NIP",
                      isPassword: false,
                      initial: profile.account.length > 0 ? profile.account[5] : "NIP TIDAK DIKETAHUI"),
                  TextInputProfile(
                      name: "username",
                      labelText: "Full Name",
                      isPassword: false,
                      initial: profile.account.length > 0 ? profile.account[1] : "USERNAME TIDAK DIKETAHUI"),
                  TextInputProfile(
                      name: "email",
                      labelText: "Email",
                      isPassword: false,
                      initial: profile.account.length > 0 ? profile.account[2] : "EMAIL TIDAK DIKETAHUI"),
                  TextInputProfile(
                      name: "password",
                      labelText: "Password",
                      isPassword: true,
                      initial: profile.account.length > 0 ? profile.account[3] : "PASSWORD TIDAK DIKETAHUI"),
                  TextInputProfile(
                      name: "job",
                      labelText: "Job",
                      isPassword: false,
                      initial: profile.account.length > 0 ? profile.account[4] : "JOB TIDAK DIKETAHUI"),
                ],
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Consumer<ProfileViewModel>(
                builder: (context, value, child) => ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF26765B)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                                horizontal: 36, vertical: 12)),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        elevation: MaterialStateProperty.all(2)),
                    onPressed: () {
                      context.loaderOverlay.show();
                      _formKey.currentState!.save();
                      value
                          .editData(
                              id: value.account[0],
                              email: _formKey.currentState!.value["email"],
                              job: _formKey.currentState!.value["job"],
                              name: _formKey.currentState!.value["username"],
                              nip: _formKey.currentState!.value["nip"],
                              password:
                                  _formKey.currentState!.value["password"])
                          .then((value) {
                        context.loaderOverlay.hide();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Update Successfull"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      });
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Consumer<AuthService>(
                builder: (context, value, child) => ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryMaroon),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                                horizontal: 36, vertical: 12)),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        elevation: MaterialStateProperty.all(2)),
                    onPressed: () {
                      value.refresh();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => WelcomeScreen()),
                          (route) => false);
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              /* TextButton(onPressed: () {}, child: Text("Update"), style: ButtonStyle(textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14, letterSpacing: 2.2, color: Colors.black)))), */
            ],
          ),
          SizedBox(height: size.height * 0.03),
        ],
      ),
    );
  }

    Widget body(ProfileViewModel viewModel, size, context, _formKey) {
    final isLoading = viewModel.state == ProfileViewState.loading;
    final isError = viewModel.state == ProfileViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator(),);
    }

    if (isError) {
      return const Center(child: Text("Get Data Failed"),);
    }

    return result(size, context, viewModel, _formKey);
  }
}
