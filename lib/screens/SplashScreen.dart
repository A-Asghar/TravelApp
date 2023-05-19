import 'package:flutter/material.dart';
import 'package:fyp/providers/HomeProvider.dart';
import 'package:fyp/providers/PackageHomeProvider.dart';
import 'package:fyp/repository/HotelRepository.dart';
import 'package:fyp/screens/auth/Login.dart';
import 'package:fyp/models/Package.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();
    startAnimation();
    fetchData();
  }

  void startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    final curve = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(curve);

    _controller!.forward();
  }

  Future<void> fetchData() async {
    await fetchHotels();
    await fetchPackages();
    await Future.delayed(Duration(seconds: 1)); // Add a delay of 2 seconds
    navigateToLoginScreen();
  }

  Future<void> fetchHotels() async {
    HotelRepository hotelRepository = HotelRepository();
    List hotelResponse = await hotelRepository.getHotels();
    context.read<HomeProvider>().hotels = hotelResponse[0];
    context.read<HomeProvider>().city = hotelResponse[1];
  }

  Future<void> fetchPackages() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('packages').get();
    snapshot.docs.forEach((document) {
      context
          .read<PackageHomeProvider>()
          .packages
          .add(Package.fromJson(document.data() as Map<String, dynamic>));
    });
  }

  void navigateToLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation!,
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller!,
              builder: (context, child) {
                final double scale = 1 +
                    (_scaleAnimation!.value *
                        0.5); // Increase the multiplier for larger zoom
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/images/ExplorEase.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
