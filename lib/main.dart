import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp/providers/SearchProvider.dart';
import 'package:fyp/repository/HotelRepository.dart';
import 'package:fyp/screens/BottomNavBar.dart';
import 'package:fyp/screens/Details.dart';
import 'package:fyp/screens/Home.dart';
import 'package:fyp/screens/Home2.dart';
import 'package:fyp/screens/Profile.dart';
import 'package:fyp/screens/Search.dart';
import 'package:fyp/screens/UserDetails.dart';
import 'package:fyp/screens/auth/Login.dart';
import 'package:fyp/screens/auth/SignUp.dart';
import 'package:fyp/screens/bookings/Bookings.dart';
import 'package:fyp/screens/hotel/HotelSearchRetults.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
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
      home: MyHomePage(title: 'ABCD'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HotelSearchResults(),
                    ));
                  },
                  child: Text('Hotel Search Results')),

              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Details(detailsType: 'hotel',),
                    ));
                  },
                  child: Text('Hotel Detail')),

              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
                  },
                  child: Text('Home')),

              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Home2(),
                    ));
                  },
                  child: Text('Home2')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Login(),
                    ));
                  },
                  child: Text('SignIn')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ));
                  },
                  child: Text('SignUp')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Details(
                        detailsType: 'package',
                      ),
                    ));
                  },
                  child: Text('Details Package')),

              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Details(detailsType: 'hotel'),
                    ));
                  },
                  child: Text('Details hotel room')),


              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Search(
                        title: 'hotel',
                      ),
                    ));
                  },
                  child: Text('Search Hotel')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Search(
                        title: 'flight',
                      ),
                    ));
                  },
                  child: Text('Search Flight')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Profile(),
                    ));
                  },
                  child: Text('Profile')),

              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserDetails(),
                    ));
                  },
                  child: Text('Passenger Details')),

              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Bookings(),
                    ));
                  },
                  child: Text('Bookings')),

              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BottomNavBar(),
                    ));
                  },
                  child: Text('Bottom Nav Bar')),

            ],
          ),
        ),
      ),
    );
  }
}
