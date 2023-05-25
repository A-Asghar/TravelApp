import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:travel_agency/models/package.dart';
import 'package:travel_agency/providers/package_provider.dart';
import 'package:travel_agency/screens/agency_home.dart';
import 'package:travel_agency/screens/auth/Login.dart';
import 'package:travel_agency/screens/bottom_navbar.dart';
import 'package:travel_agency/screens/package/add_package.dart';
import 'package:travel_agency/screens/package/edit_package.dart';
import 'package:travel_agency/screens/package/itinerary_screen.dart';
import 'package:travel_agency/screens/package/package_list_screen.dart';
import 'package:travel_agency/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PackageProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ExplorEase Travel Agency',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SplashScreen(),
        ),
      ),
      // home: EditPackageForm(
      //   package: Package(
      //       packageId: '024201636',
      //       packageName: "3 days Paris tour",
      //       packagePrice: 5600,
      //       packageDescription:
      //           "The city of love is the ultimate romantic vacation destination. Stroll hand-in-hand along the Champs-Élysées, grab coffee and croissants from a local boulangerie, and take in the city sights from Montmartre. Of course, the Eiffel Tower or a show at the Moulin Rouge are musts on your Paris trip, packaged with an evening defined by French pinot noir, chardonnay, or sauvignon blanc in a chic bistro. Luxury Paris vacation packages take you into the capital’s most elegant hotels, but there’s plenty of very welcoming budget friendly accommodation with a cheap Paris vacation package.",
      //       startDate: DateTime.parse('2020-07-17T03:18:31.177769-04:00'),
      //       numOfDays: 3,
      //       rating: 9.5, 
      //       numOfSales: 6,
      //       imgUrls: ["https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/La_Tour_Eiffel_vue_de_la_Tour_Saint-Jacques%2C_Paris_ao%C3%BBt_2014_%282%29.jpg/1200px-La_Tour_Eiffel_vue_de_la_Tour_Saint-Jacques%2C_Paris_ao%C3%BBt_2014_%282%29.jpg", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/88602138.jpg?k=476bc37d444772a24e2b1994b0f9f6af9e93b3c498b96b5c8d1a5e49baefa474&o=&hp=1", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/88602135.jpg?k=b7dd741f1b8d2128ee1d1071a9c32e0b447aa18e4efc84a1354885ae0cdcb282&o=&hp=1"],
      //       adults: 3,
      //       travelAgencyId: "721134670",
      //       hotelPropertyId: '334754382',
      //       destination: "Paris, France"),
      //       index: 1,
      // ),
      debugShowCheckedModeBanner: false,
    );
  }
}
