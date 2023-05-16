import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'Home.dart';
import 'bookings/Bookings.dart';
import 'profile/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var _currentIndex = 0;
  late PageController _pageController;
  List<Widget> tabPages = [
    const Home(),
    const Bookings(),
    const Profile(),
  ];
  @override
  void initState() {
    super.initState();
    setState(() => _currentIndex = 0);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: Colors.teal,
                unselectedColor: Colors.teal
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.library_books),
                title: const Text("Bookings"),
                selectedColor: Colors.teal,
                unselectedColor: Colors.teal
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                title: const Text("Profile"),
                selectedColor: Colors.teal,
                unselectedColor: Colors.teal
              ),
            ]),
        body: PageView(
          onPageChanged: onPageChanged,
          controller: _pageController,
          children: tabPages,
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  void onTabTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
