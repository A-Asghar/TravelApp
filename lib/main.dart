import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fyp/providers/FlightSearchProvider.dart';
import 'package:fyp/providers/HomeProvider.dart';
import 'package:fyp/providers/HotelSearchProvider.dart';
import 'package:fyp/providers/PackageHomeProvider.dart';
import 'package:fyp/providers/RecommendationProvider.dart';
import 'package:fyp/providers/loading_provider.dart';
import 'package:fyp/screens/SplashScreen.dart';
import 'package:fyp/screens/auth/Login.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Stripe.publishableKey =
      "pk_test_51MygtvITbvfdqJlo9p4ysJUCshKbyGFnSyxNLAuc9WCV9DxRy8Y8HJHd8Q7boeCnWO6M6wvPru2BuhvWW7S5ntE600XK7SK60K";
  Stripe.merchantIdentifier = 'Ali Asghar';
  await Stripe.instance.applySettings();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FlightSearchProvider()),
        ChangeNotifierProvider(create: (_) => HotelSearchProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => PackageHomeProvider()),
        ChangeNotifierProvider(create: (_) => RecommendationProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ExploreEase Traveler',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SplashScreen(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
