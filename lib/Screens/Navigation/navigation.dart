import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mini_project_alta_attedance/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import '../../view_model/data_view_model.dart';
import 'report.dart';
import '../../constants.dart';
import 'homepage.dart';
import '../Profile/profile.dart';

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
    final profile = Provider.of<ProfileViewModel>(context);
    final data = Provider.of<DataViewModel>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryMaroon,
          leading: Container(
            margin: EdgeInsets.only(left: size.width * 0.05),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: Theme.of(context).scaffoldBackgroundColor),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 1)),
              ],
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                  scale: 0.5,
                  fit: BoxFit.contain,
                  image: NetworkImage(profile.data != null &&
                          profile.data!.photo != ""
                      ? profile.data!.photo
                      : "https://firebasestorage.googleapis.com/v0/b/mini-project-flutter-aee89.appspot.com/o/files%2Fuser_profile.png?alt=media&token=5e79293e-e1d6-4e1b-a61a-07a80960e313")),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.data != null ? profile.data!.name : "Username",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                profile.data != null ? profile.data!.job : "",
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: size.width * 0.02),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ProfileScreen()));
                  },
                  icon: Icon(Icons.settings)),
            )
          ],
        ),
        body: isInit
            ? Center(
                child: CircularProgressIndicator(),
              )
            : pages[_currentIndex],
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
                          'Beranda',
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
                          'Riwayat',
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
