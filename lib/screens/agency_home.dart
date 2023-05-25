import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/Constants.dart';
import 'package:travel_agency/models/package.dart';
import 'package:travel_agency/network/package_network.dart';
import 'package:travel_agency/providers/user_provider.dart';
import 'package:travel_agency/providers/package_provider.dart';
import 'package:travel_agency/screens/package/add_package.dart';
import 'package:travel_agency/widgets/heart_beat_floating_action_button.dart';
import 'package:travel_agency/widgets/lottie_loader.dart';
import 'package:travel_agency/widgets/poppinsText.dart';
import 'package:travel_agency/widgets/side_drawer.dart';
import 'package:travel_agency/widgets/top_packages.dart';
import 'package:provider/provider.dart';

class AgencyHome extends StatefulWidget {
  const AgencyHome({super.key});

  @override
  State<AgencyHome> createState() => _AgencyHomeState();
}

class _AgencyHomeState extends State<AgencyHome> {
  PackageNetwork packageNetwork = PackageNetwork();
  final UserProvider controller = Get.put(UserProvider());
  double totalSales = 0.0;
  int totalNumOfSales = 0;
  double averageRating = 0.0;

  @override
  void initState() {
    super.initState();
    totalSales = packageNetwork.calculateTotalSales(context);
    totalNumOfSales = packageNetwork.calculateTotalNumberOfSales(context);
    averageRating = packageNetwork.calculateAverageRating(context);
  }

  @override
  Widget build(BuildContext context) {
    var packageProvider = context.watch<PackageProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: poppinsText(
            text: controller.user!.name, fontBold: FontWeight.w600, size: 24.0),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: controller.user!.profilePhotoUrl == "assets/images/user.png"
                  ? CircleAvatar(
                      backgroundColor: Constants.primaryColor,
                      child: poppinsText(
                          text: controller.user!.name.substring(0, 1),
                          size: 20.0,
                          color: Colors.white,
                          fontBold: FontWeight.w500))
                  : StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where('uid',
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(); // show loading spinner
                              }

                              var userDocument = snapshot.data?.docs.first;
                              var profilePhotoUrl =
                                  userDocument?['profilePhotoUrl'] ??
                                      'assets/images/user.png';

                              return snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? CircularProgressIndicator(
                                      color: Constants.primaryColor,
                                    )
                                  : Container(
                                      height: 140,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: DecorationImage(
                                          image: profilePhotoUrl ==
                                                  "assets/images/user.png"
                                              ? AssetImage(profilePhotoUrl)
                                              : NetworkImage(profilePhotoUrl)
                                                  as ImageProvider<Object>,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                            },
                          ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              iconSize: 50,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    infoContainer(MediaQuery.of(context).size.width * 0.44, 150,
                        'Bookings', totalNumOfSales.toString(), 72.0),
                    const SizedBox(width: 10),
                    infoContainer(MediaQuery.of(context).size.width * 0.44, 150,
                        'Rating', averageRating.toString(), 72.0),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: infoContainer(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.2,
                  'Sales',
                  "\$${totalSales.toString()}",
                  56),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  poppinsText(
                      text: 'Your Top Selling',
                      fontBold: FontWeight.w500,
                      size: 20.0),
                  const Spacer(),
                  // seeAll(() {}),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            packageProvider.agencyPackages.isEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          poppinsText(
                              text: 'You currently have no packages',
                              color: Colors.grey,
                              size: 20.0,
                              fontBold: FontWeight.w500),
                          const SizedBox(height: 10.0),
                          HeartbeatFloatingActionButton(onPressed: () {
                            Get.to(AddPackageForm(),
                                transition: Transition.fade);
                          })
                        ],
                      ),
                    ))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: packageList(
                        context.read<PackageProvider>().agencyPackages,
                        context,
                        'top',
                        330),
                  ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  poppinsText(
                      text: 'Currently Featured',
                      fontBold: FontWeight.w500,
                      size: 20.0),
                  // const Spacer(),
                  // seeAll(() {}),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: packageList(context.read<PackageProvider>().allPackages,
                  context, 'featured', 330),
            ),
          ],
        ),
      ),
      endDrawer: SideDrawer(),
      backgroundColor: Colors.white,
    );
  }
}

Widget infoContainer(double width, double height, String infoTitle, String info,
    double infoSize) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Constants.primaryColor.withOpacity(0.7),
          Constants.primaryColor.withOpacity(0.75),
          Constants.primaryColor.withOpacity(0.8),
          Constants.primaryColor.withOpacity(0.9),
          Constants.primaryColor
        ],
        stops: [0.0, 0.15, 0.5, 0.85, 1.0],
      ),
    ),
    child: Column(
      children: [
        poppinsText(
          text: infoTitle,
          size: 20.0,
          fontBold: FontWeight.w500,
          color: Colors.white,
        ),
        Expanded(
          child: Center(
            child: poppinsText(
              text: info,
              size: infoSize,
              fontBold: FontWeight.w400,
              color: Colors.white,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget seeAll(VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 30,
      width: 75,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Constants.primaryColor.withOpacity(0.3),
      ),
      child: poppinsText(
          text: 'See All',
          fontBold: FontWeight.w500,
          size: 16.0,
          color: Constants.primaryColor),
    ),
  );
}
