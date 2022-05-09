import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mini_project_alta_attedance/Screens/Navigation/navigation_view_model.dart';
import 'package:mini_project_alta_attedance/models/data.dart';
import 'package:provider/provider.dart';
import 'report.dart';
import '../../constants.dart';
import 'homepage.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;
  List pages = const [
    HomePage(),
    Report(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoaderOverlay(
      child: Scaffold(
        body: Container(
            width: double.infinity,
            height: size.height,
            child: Stack(alignment: Alignment.center, children: [
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: size.height * 0.5,
                  child: Image.asset(
                    "assets/images/Illustration-background_1.png",
                    fit: BoxFit.fill,
                  )),
              pages[_currentIndex]
            ])),
        floatingActionButton: Consumer<NavigationViewModel>(
          builder: (context, value, child) => FloatingActionButton(
            child: const Icon(
              Icons.fingerprint,
              color: kPrimaryMaroon,
              size: 45,
            ),
            onPressed: () async {
              context.loaderOverlay.show();
              switch (value.status) {
                case true:
                  await value.checkIn().then((value) {
                    context.loaderOverlay.hide();
                  });
                  break;
                case false:
                  await value.checkOut().then((value) {
                    context.loaderOverlay.hide();
                  });
                  break;
                default:
              }
            },
            backgroundColor: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (_) => const HomePage()));
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: _currentIndex == 0
                              ? kPrimaryMaroon
                              : kPrimarygrey,
                          size: 36,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: _currentIndex == 0
                                  ? kPrimaryMaroon
                                  : kPrimarygrey,
                              fontFamily: 'Poppins'),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => const ReportScreen()));
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.data_exploration,
                          color: _currentIndex == 1
                              ? kPrimaryMaroon
                              : kPrimarygrey,
                          size: 36,
                        ),
                        Text(
                          'Report',
                          style: TextStyle(
                              color: _currentIndex == 1
                                  ? kPrimaryMaroon
                                  : kPrimarygrey,
                              fontFamily: 'Poppins'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
