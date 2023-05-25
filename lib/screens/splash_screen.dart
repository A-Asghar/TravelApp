import 'package:flutter/material.dart';
import 'package:travel_agency/screens/auth/Login.dart';

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
    navigateToLoginScreenAfterDelay();
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

  void navigateToLoginScreenAfterDelay() {
    Future.delayed(Duration(seconds: 4), () {
      navigateToLoginScreen();
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
