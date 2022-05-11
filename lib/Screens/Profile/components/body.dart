import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mini_project_alta_attedance/Screens/Profile/components/background.dart';
import 'package:mini_project_alta_attedance/Screens/Profile/components/textfield.dart';
import 'package:mini_project_alta_attedance/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../view_model/auth_view_model.dart';
import '../../Welcome/welcome_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print("Download LINK : $urlDownload");
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });

    uploadFile();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileViewModel>(context);
    var data = profile.data[0];
    Size size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormBuilderState>();
    return Background(
      child: SingleChildScrollView(
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
                      child: GestureDetector(
                        onTap: selectFile,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              color: kPrimaryMaroon),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              data != null ? data.name : "Username",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(data != null && data.job != "" ? data.job : "Job Unknown"),
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
                        initial: data != null && data.nip != ""
                            ? data.nip
                            : "NIP Unknown"),
                    TextInputProfile(
                        name: "username",
                        labelText: "Full Name",
                        isPassword: false,
                        initial: data != null && data.name != ""
                            ? data.name
                            : "Job Unknown"),
                    TextInputProfile(
                        name: "email",
                        labelText: "Email",
                        isPassword: false,
                        initial: data != null && data.email != ""
                            ? data.email
                            : "Email Unknown"),
                    TextInputProfile(
                        name: "password",
                        labelText: "Password",
                        isPassword: true,
                        initial: data != null && data.password != ""
                            ? data.password
                            : "Password Unknown"),
                    TextInputProfile(
                        name: "job",
                        labelText: "Job",
                        isPassword: false,
                        initial: data != null && data.job != ""
                            ? data.job
                            : "Job Unknown"),
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
                        profile
                            .updateAccount(
                                _formKey.currentState!.value["nip"],
                                _formKey.currentState!.value["username"],
                                _formKey.currentState!.value["email"],
                                _formKey.currentState!.value["password"],
                                _formKey.currentState!.value["job"])
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
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryMaroon),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 36, vertical: 12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        elevation: MaterialStateProperty.all(2)),
                    onPressed: () async {
                      context.loaderOverlay.show();
                      await Provider.of<AuthViewModel>(context, listen: false)
                          .logOut()
                          .then((value) {
                        context.loaderOverlay.hide();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const WelcomeScreen()),
                          (Route) => false,
                        );
                      });
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
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
                Navigator.pop(context, true);
              },
              icon: Icon(Icons.arrow_back),
              color: kPrimaryMaroon,
            ),
          )),
    );
  }
}
