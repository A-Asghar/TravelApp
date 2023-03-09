import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/providers/HotelSearchProvider.dart';
import 'package:fyp/screens/hotel_search_details.dart';
import 'package:fyp/widgets/lottie_loader.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HotelSearchResults extends StatefulWidget {
  const HotelSearchResults({Key? key}) : super(key: key);

  @override
  State<HotelSearchResults> createState() => _HotelSearchResultsState();
}

class _HotelSearchResultsState extends State<HotelSearchResults> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();

  List<PropertySearchListing> filteredHotels = [];

  @override
  void initState() {
    super.initState();
    filteredHotels = context.read<HotelSearchProvider>().hotels;
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void _filterList(String searchQuery) {
    List<PropertySearchListing> searchResult = [];
    searchResult.addAll(context.read<HotelSearchProvider>().hotels.where(
        (property) =>
            property.name!.toLowerCase().contains(searchQuery.toLowerCase())));
    setState(() {
      filteredHotels = searchResult;
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
                icon: const Icon(Icons.arrow_back_ios, size: 25, color: Colors.black87),
                onPressed: () {
                  Clear();
                  Navigator.of(context).pop();
                },
              ),
              title: (context.watch<HotelSearchProvider>().errorMessage == '' &&
                    context.watch<HotelSearchProvider>().hotels.isEmpty)
                ? Container() : Container(
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
                    hintStyle:
                        GoogleFonts.poppins(color: Constants.secondaryColor),
                    hintText: 'Search hotels',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 20),
                  ),
                ),
              ),
              centerTitle: true,
            ),
            key: scaffoldState,
            body: (context.watch<HotelSearchProvider>().errorMessage == '' &&
                    context.watch<HotelSearchProvider>().hotels.isEmpty)
                ? lottieLoader()
                : (context.watch<HotelSearchProvider>().errorMessage != '' &&
                        context.watch<HotelSearchProvider>().hotels.isEmpty)
                    ? Center(
                        child: poppinsText(
                            text: context
                                .read<HotelSearchProvider>()
                                .errorMessage,
                            size: 20.0))
                    : WillPopScope(
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
                                              .read<HotelSearchProvider>()
                                              .hotels
                                              .isNotEmpty
                                          ? 'Found (${filteredHotels.isEmpty ? hotelProvider.hotels.length.toString() : filteredHotels.length.toString()})'
                                          : '',
                                      color: Constants.secondaryColor,
                                      fontBold: FontWeight.w500),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                itemCount: filteredHotels.isEmpty
                                    ? hotelProvider.hotels.length
                                    : filteredHotels.length,
                                physics: const ClampingScrollPhysics(),
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 80),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        HotelSearchDetails(
                                          property: filteredHotels.isEmpty
                                              ? hotelProvider.hotels[index]
                                              : filteredHotels[index],
                                        ),
                                        transition: Transition.rightToLeft,
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 25),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                                      BorderRadius.circular(
                                                          20.0),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        filteredHotels.isEmpty
                                                            ? hotelProvider
                                                                .hotels[index]
                                                                .propertyImage!
                                                                .image!
                                                                .url!
                                                            : filteredHotels[
                                                                    index]
                                                                .propertyImage!
                                                                .image!
                                                                .url!),
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
                                                        text: filteredHotels
                                                                .isEmpty
                                                            ? hotelProvider
                                                                .hotels[index]
                                                                .name
                                                            : filteredHotels[
                                                                    index]
                                                                .name,
                                                        fontBold:
                                                            FontWeight.w700,
                                                        size: 18.0),
                                                    poppinsText(
                                                        text: hotelProvider
                                                            .to.city,
                                                        size: 14.0,
                                                        color: const Color(
                                                            0xff757575)),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xffFFD300),
                                                          size: 15,
                                                        ),
                                                        poppinsText(
                                                            text: filteredHotels
                                                                    .isEmpty
                                                                ? hotelProvider
                                                                    .hotels[
                                                                        index]
                                                                    .reviews!
                                                                    .score
                                                                    .toString()
                                                                : filteredHotels[
                                                                        index]
                                                                    .reviews!
                                                                    .score
                                                                    .toString(),
                                                            size: 14.0,
                                                            color: Constants
                                                                .primaryColor,
                                                            fontBold: FontWeight.w500),
                                                        poppinsText(
                                                            text:
                                                                ' (${filteredHotels.isEmpty ? hotelProvider.hotels[index].reviews!.total.toString() : filteredHotels[index].reviews!.total.toString()} reviews)'),
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
                                                        text: filteredHotels
                                                                .isEmpty
                                                            ? hotelProvider
                                                                    .hotels[index]
                                                                    .price!
                                                                    .options!
                                                                    .isEmpty
                                                                ? '\$XX'
                                                                : hotelProvider
                                                                    .hotels[
                                                                        index]
                                                                    .price!
                                                                    .options![0]
                                                                    .formattedDisplayPrice
                                                                    .toString()
                                                            : filteredHotels[index]
                                                                    .price!
                                                                    .options!
                                                                    .isEmpty
                                                                ? '\$XX'
                                                                : filteredHotels[index]
                                                                    .price!
                                                                    .options![0]
                                                                    .formattedDisplayPrice
                                                                    .toString(),
                                                        size: 16.0,
                                                        color: Constants
                                                            .primaryColor,
                                                        fontBold:
                                                            FontWeight.w600),
                                                    const SizedBox(height: 8),
                                                    poppinsText(
                                                        text: "/night",
                                                        size: 10.0,
                                                        color:
                                                            Color(0xff757575),
                                                        fontBold:
                                                            FontWeight.w400),
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
                            // Expanded(
                            //   child: (context.watch<HotelSearchProvider>().hotels.isEmpty)
                            //       ? lottieLoader()
                            //       : context.read<HotelSearchProvider>().hotels.length == 0
                            //           ? Center(
                            //               child:
                            //                   poppinsText(text: 'Not Found', size: 30.0))
                            //           : ListView.builder(
                            //               itemCount: hotelProvider.hotels.length,
                            //               physics: const ClampingScrollPhysics(),
                            //               padding: const EdgeInsets.only(
                            //                   left: 20, right: 20, bottom: 80),
                            //               itemBuilder: (BuildContext context, int index) {
                            //                 return InkWell(
                            //                   onTap: () {
                            //                     Get.to(
                            //                       Details(
                            //                         detailsType: 'hotel',
                            //                         property: hotelProvider.hotels[index],
                            //                       ),
                            //                       transition: Transition.rightToLeft,
                            //                     );
                            //                   },
                            //                   child: Padding(
                            //                     padding:
                            //                         const EdgeInsets.only(bottom: 25),
                            //                     child: Container(
                            //                       decoration: BoxDecoration(
                            //                         color: Colors.grey.withOpacity(0.1),
                            //                         borderRadius:
                            //                             BorderRadius.circular(16),
                            //                       ),
                            //                       child: Padding(
                            //                         padding: const EdgeInsets.all(14.0),
                            //                         child: Row(
                            //                           children: [
                            //                             Container(
                            //                               height: 100,
                            //                               width: 100,
                            //                               decoration: BoxDecoration(
                            //                                 image: DecorationImage(
                            //                                   image: NetworkImage(
                            //                                       hotelProvider
                            //                                           .hotels[index]
                            //                                           .propertyImage!
                            //                                           .image!
                            //                                           .url!),
                            //                                   fit: BoxFit.fill,
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                             const SizedBox(width: 10),
                            //                             Expanded(
                            //                               flex: 4,
                            //                               child: Column(
                            //                                 mainAxisAlignment:
                            //                                     MainAxisAlignment.center,
                            //                                 crossAxisAlignment:
                            //                                     CrossAxisAlignment.start,
                            //                                 children: [
                            //                                   poppinsText(
                            //                                       text: hotelProvider
                            //                                           .hotels[index].name,
                            //                                       fontBold:
                            //                                           FontWeight.w700,
                            //                                       size: 18.0),
                            //                                   const SizedBox(height: 15),
                            //                                   poppinsText(
                            //                                       text: hotelProvider
                            //                                           .to.city,
                            //                                       size: 14.0,
                            //                                       color: const Color(
                            //                                           0xff757575)),
                            //                                   const SizedBox(height: 15),
                            //                                   Row(
                            //                                     children: [
                            //                                       const Icon(
                            //                                         Icons.star,
                            //                                         color:
                            //                                             Color(0xffFFD300),
                            //                                         size: 15,
                            //                                       ),
                            //                                       poppinsText(
                            //                                           text: hotelProvider
                            //                                               .hotels[index]
                            //                                               .reviews!
                            //                                               .score
                            //                                               .toString(),
                            //                                           size: 14.0,
                            //                                           color: Constants
                            //                                               .primaryColor),
                            //                                       poppinsText(
                            //                                           text:
                            //                                               ' ${hotelProvider.hotels[index].reviews!.total.toString()} reviews'),
                            //                                     ],
                            //                                   )
                            //                                 ],
                            //                               ),
                            //                             ),
                            //                             Expanded(
                            //                               child: Column(
                            //                                 crossAxisAlignment:
                            //                                     CrossAxisAlignment.end,
                            //                                 children: [
                            //                                   poppinsText(
                            //                                       text: hotelProvider
                            //                                               .hotels[index]
                            //                                               .price!
                            //                                               .options!
                            //                                               .isEmpty
                            //                                           ? '\$XX'
                            //                                           : hotelProvider
                            //                                               .hotels[index]
                            //                                               .price!
                            //                                               .options![0]
                            //                                               .formattedDisplayPrice
                            //                                               .toString(),
                            //                                       size: 16.0,
                            //                                       color: Constants
                            //                                           .primaryColor),
                            //                                   const SizedBox(height: 8),
                            //                                   poppinsText(
                            //                                       text: "/night",
                            //                                       size: 10.0,
                            //                                       color:
                            //                                           Color(0xff757575)),
                            //                                   const SizedBox(height: 20),
                            //                                 ],
                            //                               ),
                            //                             )
                            //                           ],
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 );
                            //               },
                            //             ),
                            // )
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
