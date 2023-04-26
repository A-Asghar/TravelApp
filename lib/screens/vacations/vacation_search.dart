import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/Package.dart';
import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/providers/HotelSearchProvider.dart';
import 'package:fyp/providers/PackageHomeProvider.dart';
import 'package:fyp/screens/hotel_search_details.dart';
import 'package:fyp/screens/package_details.dart';
import 'package:fyp/widgets/lottie_loader.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VacationSearch extends StatefulWidget {
  const VacationSearch({Key? key}) : super(key: key);

  @override
  State<VacationSearch> createState() => _VacationSearchState();
}

class _VacationSearchState extends State<VacationSearch> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();

  List<Package> filteredPackages = [];

  @override
  void initState() {
    super.initState();
    filteredPackages = context.read<PackageHomeProvider>().packages;
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void _filterList(String searchQuery) {
  List<Package> searchResult = context
      .read<PackageHomeProvider>()
      .packages
      .where((package) =>
          package.destination.toLowerCase().contains(searchQuery.toLowerCase()) ||
          package.packageName.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();
  setState(() {
    filteredPackages = searchResult;
  });
}

  @override
  Widget build(BuildContext context) {
    Clear() {
      context.read<HotelSearchProvider>().clearHotels();
      context.read<HotelSearchProvider>().errorMessage = '';
    }

    var hotelProvider = context.read<HotelSearchProvider>();
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    size: 25, color: Colors.black87),
                onPressed: () {
                  Clear();
                  Navigator.of(context).pop();
                },
              ),
              title: Container(
                      decoration: BoxDecoration(
                        color: Constants.secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        onChanged: (searchQuery) async {
                          _filterList(searchQuery);
                        },
                        controller: _searchController,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.poppins(
                              color: Constants.secondaryColor),
                          hintText: 'Search packages',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(left: 20),
                        ),
                      ),
                    ),
              centerTitle: true,
            ),
            key: scaffoldState,
            body: WillPopScope(
              onWillPop: () async {
                Clear();
                return true;
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                    ),
                    child: Row(
                      children: [
                        poppinsText(
                            text: context
                                    .read<PackageHomeProvider>()
                                    .packages
                                    .isNotEmpty
                                ? 'Total Packages (${filteredPackages.length.toString()})'
                                : '',
                            color: Constants.secondaryColor,
                            fontBold: FontWeight.w500),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount:  filteredPackages.length,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 80),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Get.to(
                              PackageDetails(package: filteredPackages[index]),
                              transition: Transition.rightToLeft,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              filteredPackages[index].imgUrls[0]),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          poppinsText(
                                              text: filteredPackages[index].packageName,
                                              fontBold: FontWeight.w700,
                                              size: 18.0),
                                          poppinsText(
                                              text: filteredPackages[index].destination,
                                              size: 14.0,
                                              color: const Color(0xff757575)),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Color(0xffFFD300),
                                                size: 15,
                                              ),
                                              poppinsText(
                                                  text: filteredPackages[index].rating.toString(),
                                                  size: 14.0,
                                                  color: Constants.primaryColor,
                                                  fontBold: FontWeight.w500),
                                              poppinsText(
                                                  text:
                                                      ' (${248} reviews)'),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          poppinsText(
                                              text:  filteredPackages[index].packagePrice.toStringAsFixed(0).toString(),
                                              size: 16.0,
                                              color: Constants.primaryColor,
                                              fontBold: FontWeight.w600),
                                          const SizedBox(height: 8),
                                          poppinsText(
                                              text: "/night",
                                              size: 10.0,
                                              color: Color(0xff757575),
                                              fontBold: FontWeight.w400),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}

Widget searchCard(String text, Color bgColor, VoidCallback onTap) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      height: 38,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: Constants.primaryColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Text(
            text,
            style: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    ),
  );
}
