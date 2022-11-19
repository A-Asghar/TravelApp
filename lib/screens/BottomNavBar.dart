import 'package:flutter/material.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'Home2.dart';
import 'Profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var _currentIndex = 0;
  late PageController _pageController;
  List<Widget> tabPages = [
    Home2(),
    Scaffold(
      body: Center(
        child: poppinsText(text: 'Bookings Screen'),
      ),
    ),
    Profile(),
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: Colors.teal,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.library_books),
              title: Text("Bookings"),
              selectedColor: Colors.teal,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ]),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._currentIndex = page;
    });
  }
  void onTabTapped(int index) {
    this._pageController.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
  }
}