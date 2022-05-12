import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mini_project_alta_attedance/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import '../../view_model/data_view_model.dart';
import 'report.dart';
import '../../constants.dart';
import 'homepage.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit == true) {
      Provider.of<DataViewModel>(context, listen: false).inisialData();

      Provider.of<ProfileViewModel>(context, listen: false).inisialData();

      isInit = false;
    }
    super.didChangeDependencies();
  }

  int _currentIndex = 0;
  List pages = const [
    HomePage(),
    Report(),
  ];

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataViewModel>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return LoaderOverlay(
      child: Scaffold(
        body: Container(
            width: double.infinity,
            height: size.height,
            child: Stack(alignment: Alignment.center, children: [
              Positioned(
                  top: -55,
                  left: 0,
                  right: 0,
                  height: size.height * 0.5,
                  child: Image.asset(
                    "assets/images/Illustration-background_3.png",
                    fit: BoxFit.fill,
                  )),
              isInit
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : pages[_currentIndex]
            ])),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.fingerprint,
            color: kPrimaryMaroon,
            size: 45,
          ),
          onPressed: () async {
            context.loaderOverlay.show();
            switch (data.status) {
              case true:
                await data.checkIn().then((value) {
                  context.loaderOverlay.hide();
                });
                break;
              case false:
                await data.checkOut().then((value) {
                  context.loaderOverlay.hide();
                });
                break;
              default:
            }
          },
          backgroundColor: Colors.white,
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
                          Icons.description_outlined,
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
