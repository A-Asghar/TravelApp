import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:travel_agency/screens/agency_home.dart';
import 'package:travel_agency/screens/booking/package_booking_screen.dart';
import 'package:travel_agency/screens/package/package_list_screen.dart';
import 'package:travel_agency/widgets/package_image_slider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var _currentIndex = 0;
  late PageController _pageController;
  List<Widget> tabPages = [
    const AgencyHome(),
    const PackageListScreen(),
    const PackageBookingScreen(),
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
                icon: const Icon(Icons.home_filled),
                title: const Text("Home"),
                selectedColor: Colors.teal,
                unselectedColor: Colors.teal
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.shopping_bag),
                title: const Text("Packages"),
                selectedColor: Colors.teal,
                unselectedColor: Colors.teal
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.library_books),
                title: const Text("Bookings"),
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
