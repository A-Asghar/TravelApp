import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp/providers/FlightSearchProvider.dart';
import 'package:fyp/providers/HomeProvider.dart';
import 'package:fyp/providers/HotelSearchProvider.dart';
import 'package:fyp/providers/PackageHomeProvider.dart';
import 'package:fyp/providers/RecommendationProvider.dart';
import 'package:fyp/screens/BottomNavBar.dart';
import 'package:fyp/screens/auth/Login.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FlightSearchProvider()),
        ChangeNotifierProvider(create: (_) => HotelSearchProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => PackageHomeProvider()),
        ChangeNotifierProvider(create: (_) => RecommendationProvider()),
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
