import 'package:flutter/material.dart';
import 'package:ngimpi/screens/addnote_screen.dart';
import 'package:ngimpi/screens/home_screen.dart';
import 'package:ngimpi/screens/note_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    const NoteScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddnoteScreen()));
              setState(() {
                currentTab = 2;
              });
            },
            child: const Icon(Icons.add, color: Color(0xffffffff)),
            backgroundColor: const Color(0xff31457E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90),
            ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          color: const Color(0xff31457E),
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 150,
                      onPressed: () {
                        setState(() {
                          currentScreen = HomeScreen();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: currentTab == 0
                                ? const Color(0xffffffff)
                                : const Color(0xff9F9F9F),
                          ),
                          Text(
                            'Beranda',
                            style: TextStyle(
                              color: currentTab == 0
                                  ? const Color(0xffffffff)
                                  : const Color(0xff9F9F9F),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // kanan tab
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 150,
                      onPressed: () {
                        setState(() {
                          currentScreen = NoteScreen();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.my_library_books_rounded,
                            color: currentTab == 1
                                ? const Color(0xffffffff)
                                : const Color(0xff9F9F9F),
                          ),
                          Text(
                            'Catatan',
                            style: TextStyle(
                              color: currentTab == 1
                                  ? const Color(0xffffffff)
                                  : const Color(0xff9F9F9F),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
