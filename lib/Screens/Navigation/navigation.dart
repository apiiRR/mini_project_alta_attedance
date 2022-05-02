import 'package:flutter/material.dart';
import 'package:mini_project_alta_attedance/Screens/Attedance/attedance.dart';
import 'package:mini_project_alta_attedance/Screens/Homepage/homepage.dart';
import 'package:mini_project_alta_attedance/Screens/Profile/profile.dart';
import 'package:mini_project_alta_attedance/Screens/Report/report.dart';
import 'package:mini_project_alta_attedance/constants.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  // Color background = Colors.black;
  int _currentTab = 0;

  List<IconData> icon = [
    Icons.home,
    Icons.qr_code_scanner,
    Icons.library_books,
    Icons.person
  ];

  final List<Widget> screen = [
    HomePage(),
    ProfileScreen(),
  ];

  Widget currentScreen = HomePage();

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Icon(
          Icons.fingerprint,
          color: kPrimaryColor,
        ),
        title: Text(
          "Attedance Apps",
          style: TextStyle(color: kPrimaryColor),
        ),
        titleSpacing: -5,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.logout,
                color: kPrimaryColor,
              )),
        ],
      ), */
      // backgroundColor: kPrimaryColor,
      body: currentScreen,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.fingerprint,
          color: kPrimaryMaroon,
          size: 45,
        ),
        onPressed: () {},
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = HomePage();
                      _currentTab = 0;
                    });
                  },
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: _currentTab == 0 ? kPrimaryMaroon : kPrimarygrey, size: 36,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                          color:
                              _currentTab == 0 ? kPrimaryMaroon : kPrimarygrey, fontFamily: 'Poppins'
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = ProfileScreen();
                      _currentTab = 1;
                    });
                  },
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: _currentTab == 1 ? kPrimaryMaroon : kPrimarygrey, size: 36,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                          color:
                              _currentTab == 1 ? kPrimaryMaroon : kPrimarygrey, fontFamily: 'Poppins'
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      /*   bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: kPrimaryColor,
          labelTextStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
              iconTheme: MaterialStateProperty.all(IconThemeData(color: Colors.white)),
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: NavigationBar(
              backgroundColor: kPrimaryLightColor,
              animationDuration: const Duration(seconds: 1),
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              height: 60,
              selectedIndex: _currentIndex,
              onDestinationSelected: (int newIndex) {
                setState(() {
                  _currentIndex = newIndex;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined, color: Colors.white,),
                  label: 'Beranda',
                  selectedIcon: Icon(Icons.home),
                ),
                NavigationDestination(
                  icon: Icon(Icons.fingerprint_outlined,  color: Colors.white,),
                  label: 'Presensi',
                  selectedIcon: Icon(Icons.fingerprint),
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline,  color: Colors.white,),
                  label: 'Profil',
                  selectedIcon: Icon(Icons.person),
                ),
              ],
            ),
          ),
        ),
      ), */
    );
  }
}
