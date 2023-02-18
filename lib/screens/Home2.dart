import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/Package.dart';
import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/providers/HomeProvider.dart';
import 'package:fyp/providers/PackageHomeProvider.dart';
import 'package:fyp/providers/UserProvider.dart';
import 'package:fyp/repository/HotelRepository.dart';
import 'package:fyp/screens/Search.dart';

import 'package:fyp/screens/hotel/HotelSearchResults.dart';

import 'package:fyp/screens/hotel_home_details.dart';
import 'package:fyp/screens/package_details.dart';
import 'package:fyp/widgets/lottie_loader.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../Constants.dart';
import '../models/RecommendedCities.dart';
import '../providers/RecommendationProvider.dart';
import '../repository/FlightRepository.dart';
import '../repository/RecommendationRepository.dart';

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  @override
  void initState() {
    super.initState();

    fetchInfo();
  }

  fetchInfo() {
    setState(() => isLoading = true);

    if (context.read<RecommendationProvider>().recommendedCities == null) {
      fetchRecommended();
    }
    if (context.read<HomeProvider>().hotels.isEmpty) {
      fetchHotels();
    }
    if (context.read<PackageHomeProvider>().packages.isEmpty) {
      fetchPackages();
    }

    setState(() => isLoading = false);
  }

  bool isLoading = false;
  fetchHotels() async {
    HotelRepository hotelRepository = HotelRepository();
    List hotelResponse = await hotelRepository.getHotels();
    context.read<HomeProvider>().hotels = hotelResponse[0];
    context.read<HomeProvider>().city = hotelResponse[1];
  }

  fetchPackages() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('packages').get();
    snapshot.docs.forEach((document) {
      context
          .read<PackageHomeProvider>()
          .packages
          .add(Package.fromJson(document.data() as Map<String, dynamic>));
    });
  }

  fetchRecommended() async {
    final UserProvider controller = Get.put(UserProvider());

    context.read<RecommendationProvider>().recommendedCities =
        await RecommendationRepository()
            .getRecommendedCities(cityIatas: controller.user!.searchedCities);
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = context.watch<HomeProvider>();
    var packageProvider = context.watch<PackageHomeProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      // drawer: SideBar(),
      body: isLoading
          ? lottieLoader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          // top: 0,
                          child: topBackgroundImage(context),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.width * 0.02,
                          child: topIcons(context),
                        ),
                        // searchBar(context),
                        Positioned(
                          top: 120,
                          left: 20,
                          child: topHeading('Asghar'),
                        ),
                      ],
                    ),
                  ),
                  heading('Summer Escapes', 25.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: poppinsText(
                        text:
                            'Break the routine and escape to these hand-picked properties for exceptional prices',
                        color: Constants.secondaryColor),
                  ),
                  const SizedBox(height: 10),
                  summerEscapes(
                    context,
                    context.read<HomeProvider>().hotels,
                    context.read<HomeProvider>().city,
                  ),
                  const SizedBox(height: 20),
                  recommendedDestinations(context),
                  const SizedBox(height: 10),
                  heading('Top Packages', 20.0),
                  topPackages(
                      context.read<PackageHomeProvider>().packages, context),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}

Widget topBackgroundImage(context) {
  return SizedBox(
    height: MediaQuery.of(context).size.width * 0.85,
    child: Image.asset(
      'assets/images/home_main.jpg',
      fit: BoxFit.fill,
    ),
  );
}

Widget iconBox(icon, backgroundColor, text, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    color: Constants.secondaryColor,
                    blurRadius: 5.0,
                    offset: Offset(1.0, 0.75))
              ],
              color: backgroundColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15)),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        poppinsText(text: text, fontBold: FontWeight.w400)
      ],
    ),
  );
}

Widget topIcons(context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        iconBox(Icons.flight, Constants.primaryColor, 'Flights', () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Search(title: 'flight')));
        }),
        iconBox(Icons.location_city, Constants.primaryColor, 'Hotels', () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Search(title: 'hotel')));
        }),
        iconBox(Icons.beach_access, Constants.primaryColor, 'Vacations', () {}),
      ],
    ),
  );
}

Widget topHeading(text) {
  return poppinsText(
      text: 'Hi $text \nWhere would you like to go ?',
      size: 25.0,
      color: Colors.white,
      fontBold: FontWeight.bold);
}

Widget searchBar(context) {
  return Center(
    child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.3)),
        child:
            poppinsText(text: 'Search Here', color: Colors.white, size: 18.0)),
  );
}

Widget heading(text, size) {
  return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: poppinsText(text: text, size: size, fontBold: FontWeight.w600));
}

Widget summerEscapes(
    context, List<PropertySearchListing> hotels, List<String> city) {
  List images = [
    'https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768',
    'https://media-cdn.tripadvisor.com/media/photo-s/1d/24/9b/85/hotel-exterior.jpg',
    'https://cf.bstatic.com/xdata/images/hotel/max1024x768/321508463.jpg?k=b4d405dada3968a746c8988364236c165cf0d8985ede33aa304abf06f793ab6a&o=&hp=1',
    'https://theenglishhotel.com/wp-content/uploads/2022/06/image002-2.png',
    'https://www.murhotels.com/cache/40/b3/40b3566310d686be665d9775f59ca9cd.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Cordoba_Center_Hotel_in_Cordoba%2C_Spain.jpg/1200px-Cordoba_Center_Hotel_in_Cordoba%2C_Spain.jpg',
    'https://aff.bstatic.com/images/hotel/840x460/183/183065428.jpg'
  ];
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    // width: MediaQuery.of(context).size.width * 0.95,
    height: 300,
    child: ListView.builder(
        itemCount: hotels.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var formatter = NumberFormat('#,##,000');
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HotelHomeDetails(
                  property: hotels[index],
                ),
              ));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    roundedImage(
                        160.0, 250.0, hotels[index].propertyImage!.image!.url),
                    Container(
                      height: 130,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          poppinsText(
                              text: hotels[index].name.toString(),
                              size: 16.0,
                              fontBold: FontWeight.w500),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 12.0,
                                color: Constants.primaryColor,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              poppinsText(
                                  text: city[index],
                                  size: 15.0,
                                  color: Constants.secondaryColor),
                            ],
                          ),
                          Container(
                            width: 180,
                            alignment: Alignment.bottomRight,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Row(
                                  children: [
                                    poppinsText(
                                        text: hotels[index]
                                            .reviews!
                                            .score
                                            .toString(),
                                        color: Colors.black87,
                                        fontBold: FontWeight.w400),
                                    const SizedBox(width: 10),
                                    poppinsText(
                                        text:
                                            '(${hotels[index].reviews!.total! > 1000 ? formatter.format(hotels[index].reviews!.total).toString() : hotels[index].reviews!.total.toString()} reviews)',
                                        color: Constants.secondaryColor,
                                        size: 13.0),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              poppinsText(
                                  text: double.parse(hotels[index]
                                          .price!
                                          .lead!
                                          .amount!
                                          .toStringAsFixed(2))
                                      .toString(),
                                  size: 20.0,
                                  color: Constants.primaryColor,
                                  fontBold: FontWeight.w500),
                              poppinsText(
                                  text: ' /night',
                                  color: Constants.secondaryColor,
                                  size: 12.0)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
  );
}

Widget roundedImage(height, width, src) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: Image.network(
        '$src',
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget recommendedDestinations(BuildContext context) {
  List images = [
    'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=944&q=80',
    'https://london.com/wp-content/uploads/2019/03/london_001.jpg',
    'https://images.unsplash.com/photo-1444723121867-7a241cacace9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1496568816309-51d7c20e3b21?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80',
    'https://cdn.britannica.com/49/179449-138-9F4EC401/Overview-Berlin.jpg?w=800&h=450&c=crop',
    'https://content.r9cdn.net/rimg/dimg/62/28/22c46ab3-city-3286-164709113b2.jpg?crop=true&width=1020&height=498',
  ];

  List<City>? locations =
      context.watch<RecommendationProvider>().recommendedCities;

  if (locations == null) {
    return Container();
  }
  if (locations.isNotEmpty) {
    return Column(
      children: [
        heading('Recommended Destinations', 20.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: 145,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    roundedImage(100.0, 150.0, images[index]),
                    Container(
                        padding: const EdgeInsets.all(5),
                        child: poppinsText(
                            text: locations[index].name, size: 16.0))
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
  return Container();
}

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(48), // Image radius
                    child: Image.network(
                        'https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg',
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          sideBarRow(icon: Icons.person, text: 'Profile', onTap: () {}),
          sideBarRow(icon: Icons.settings, text: 'Settings', onTap: () {}),
          sideBarRow(icon: Icons.help, text: 'Help Center', onTap: () {}),
          sideBarRow(icon: Icons.help_outline, text: 'FAQs', onTap: () {}),
          sideBarRow(
              icon: Icons.interpreter_mode_sharp,
              text: 'Terms & Conditions',
              onTap: () {}),
          sideBarRow(
              icon: Icons.report_problem, text: 'Disputes', onTap: () {}),
          sideBarRow(icon: Icons.logout, text: 'Logout', onTap: () {}),
        ],
      ),
    );
  }
}

class sideBarRow extends StatelessWidget {
  const sideBarRow(
      {Key? key, required this.icon, required this.text, required this.onTap})
      : super(key: key);
  final icon;
  final text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Constants.primaryColor,
      ),
      title: poppinsText(text: text, fontBold: FontWeight.w500),
      onTap: () => {Navigator.of(context).pop()},
    );
  }
}

Widget topPackages(List<Package> packages, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    height: MediaQuery.of(context).size.height * 0.32,
    child: ListView.builder(
        itemCount: packages.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PackageDetails(
                  package: packages[index],
                ),
              ));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    roundedImage(160.0, 250.0, packages[index].imgUrls[0]),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          poppinsText(
                              text: packages[index].packageName,
                              size: 20.0,
                              fontBold: FontWeight.w500),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Constants.primaryColor,
                                size: 12,
                              ),
                              poppinsText(
                                  text: packages[index].destination,
                                  size: 15.0,
                                  color: Constants.secondaryColor),
                            ],
                          ),
                          Row(
                            children: [
                              poppinsText(
                                  text: double.parse(packages[index]
                                          .packagePrice
                                          .toStringAsFixed(2))
                                      .toString(),
                                  size: 20.0,
                                  color: Constants.primaryColor,
                                  fontBold: FontWeight.w500),
                              poppinsText(
                                  text: ' /person',
                                  color: Constants.secondaryColor,
                                  size: 12.0)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
  );
}
