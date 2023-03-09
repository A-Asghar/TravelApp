import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp/providers/FlightSearchProvider.dart';
import 'package:fyp/providers/HomeProvider.dart';
import 'package:fyp/providers/HotelSearchProvider.dart';
import 'package:fyp/providers/PackageHomeProvider.dart';
import 'package:fyp/providers/RecommendationProvider.dart';
import 'package:fyp/screens/AddPackage.dart';
import 'package:fyp/screens/EditPackage.dart';

import 'package:fyp/screens/Home2.dart';
import 'package:fyp/screens/Search.dart';
import 'package:fyp/screens/auth/Login.dart';
import 'package:fyp/screens/auth/SignUp.dart';
import 'package:fyp/screens/bookings/Bookings.dart';
import 'package:fyp/screens/profile/Profile.dart';
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
// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => SearchProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

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
      home: BottomNavBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }


// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => Home2(),
//                     ));
//                   },
//                   child: Text('Home2')),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => Login(),
//                     ));
//                   },
//                   child: Text('SignIn')),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => AddPackage(),
//                     ));
//                   },
//                   child: Text('Add Package')),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => EditPackage(
//                         package:
//                             context.read<PackageHomeProvider>().packages[0],
//                       ),
//                     ));
//                   },
//                   child: Text('Edit Package')),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => SignUp(),
//                     ));
//                   },
//                   child: Text('SignUp')),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => Search(
//                         title: 'hotel',
//                       ),
//                     ));
//                   },
//                   child: Text('Search Hotel')),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => Search(
//                         title: 'flight',
//                       ),
//                     ));
//                   },
//                   child: Text('Search Flight')),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => Profile(),
//                     ));
//                   },
//                   child: Text('Profile')),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => Bookings(),
//                     ));
//                   },
//                   child: Text('Bookings')),
//               ElevatedButton(
//                   onPressed: () async {
//                     // Navigator.of(context).push(MaterialPageRoute(
//                     //   builder: (context) => TicketScreen(),
//                     // ));
//                     // HotelRepository h = HotelRepository();
//                     // h.detail();
//                     // h.reviews();
//                     // WeatherRepository w = WeatherRepository();


//                     // Weather weather = await w.getWeather(
//                     //     q: 'Karachi',
//                     //     dt: Constants.convertDate(DateTime(DateTime.now().year,
//                     //         DateTime.now().month + 1, DateTime.now().day)));
//                     // Navigator.of(context).push(MaterialPageRoute(
//                     //   builder: (context) => WeatherScreen(
//                     //       q: 'Karachi',
//                     //       dt: Constants.convertDate(DateTime(
//                     //           DateTime.now().year,
//                     //           DateTime.now().month + 1,
//                     //           DateTime.now().day))),
//                     // ));
//                     // PackageRepository p = PackageRepository();
//                     // p.makePackageBooking(
//                     //     travelerId: 'Px2HVU4xBNWabxuolk6cPTlvnVG2',
//                     //     travelAgencyId: 'Px2HVU4xBNWabxuolk6cPTlvnVG2',
//                     //     packageId: '024201636');
//                     // AuthNetwork a = AuthNetwork();
//                     // AuthNetwork.createNewUser(email: 'aatest722@gmail.com', password: '123456');
//                     // AuthNetwork.login(email: 'aatest722@gmail.com', password: '123456');
//                     // final UserProvider controller = Get.put(UserProvider());
//                     // print(controller.user!.email);
//                     // Navigator.of(context).push(MaterialPageRoute(
//                     //   builder: (context) => Login(),
//                     // ));

//                     // Future<List<Map<String, dynamic>>>
//                     //     getPropertyListings() async {
//                     //   List<Map<String, dynamic>> listings = [];
//                     //
//                     //   QuerySnapshot snapshot = await FirebaseFirestore.instance
//                     //       .collection("propertySearchListing")
//                     //       .get();
//                     //
//                     //   snapshot.docs.forEach((document) {
//                     //     Map<String, dynamic> data =
//                     //         document.data() as Map<String, dynamic>;
//                     //     data["property"] = PropertySearchListing.fromJson(data["property"]);
//                     //     listings.add(data);
//                     //   });
//                     //
//                     //   return listings;
//                     // }
//                     // getHomePackages() async {
//                     //   QuerySnapshot snapshot = await FirebaseFirestore.instance
//                     //       .collection('packages')
//                     //       .get();
//                     //   snapshot.docs.forEach((document) {
//                     //     context.read<PackageHomeProvider>().packages.add(
//                     //         Package.fromJson(
//                     //             document.data() as Map<String, dynamic>));
//                     //   });
//                     // }
//                     //
//                     // await getHomePackages();


                    // final UserProvider controller = Get.put(UserProvider());
                    //
                    // print(controller.user!.searchedCities);
                    // RecommendationRepository().getRecommendedCities(
                    //     cityIatas: controller.user!.searchedCities);
                    //
                    // final RecommendationProvider controller2 =
                    //     Get.put(RecommendationProvider());
                    //
                    // print(controller2.recommendedCities);
                    // controller2.recommendedCities?.forEach((element) {
                    //   print(element.name);
                    // });
                  },
                  child: Text('API Test')),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => AddPackage(),
                    // ));
                  },
                  child: Text('Package')),
            ],
          ),
        ),
      ),
    );
  }
}

