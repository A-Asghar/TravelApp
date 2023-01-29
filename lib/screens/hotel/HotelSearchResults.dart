import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/providers/HotelSearchProvider.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Details.dart';

class HotelSearchResults extends StatefulWidget {
  const HotelSearchResults({Key? key}) : super(key: key);

  @override
  State<HotelSearchResults> createState() => _HotelSearchResultsState();
}

class _HotelSearchResultsState extends State<HotelSearchResults> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Clear() {
      context.read<HotelSearchProvider>().clearHotels();
    }

    var hotelProvider = context.read<HotelSearchProvider>();
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: Constants.primaryColor),
                onPressed: () {
                  Clear();
                  Navigator.of(context).pop();
                },
              ),
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
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        poppinsText(
                          text: context
                                  .read<HotelSearchProvider>()
                                  .hotels
                                  .isNotEmpty
                              ? 'Found (${context.read<HotelSearchProvider>().hotels.length.toString()})'
                              : '',
                          color: Constants.secondaryColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: (context.watch<HotelSearchProvider>().hotels.isEmpty)
                        ? lottieLoader()
                        : context.read<HotelSearchProvider>().hotels.length == 0
                            ? Center(
                                child:
                                    poppinsText(text: 'Not Found', size: 30.0))
                            : ListView.builder(
                                itemCount: hotelProvider.hotels.length,
                                physics: const ClampingScrollPhysics(),
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 80),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        Details(
                                          detailsType: 'hotel',
                                          property: hotelProvider.hotels[index],
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
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color:
                                          //     const Color(0xff04060F).withOpacity(0.05),
                                          //     blurRadius: 8,
                                          //   )
                                          // ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        hotelProvider
                                                            .hotels[index]
                                                            .propertyImage!
                                                            .image!
                                                            .url!
                                                        // index == 0
                                                        //     ? 'assets/images/d1.png'
                                                        //     : index == 1
                                                        //         ? 'assets/images/d6.png'
                                                        //         : index == 2
                                                        //             ? 'assets/images/d2.png'
                                                        //             : index == 3
                                                        //                 ? 'assets/images/d7.png'
                                                        //                 : 'assets/images/d8.png',
                                                        ),
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
                                                        text: hotelProvider
                                                            .hotels[index].name,
                                                        fontBold:
                                                            FontWeight.w700,
                                                        size: 18.0),
                                                    // Text(
                                                    //   index == 0
                                                    //       ? "Le Bristol Hotel"
                                                    //       : index == 1
                                                    //           ? "Maison Souquet"
                                                    //           : index == 2
                                                    //               ? "Le Meurice Hotel"
                                                    //               : "Plaza Athenee",
                                                    //   style: Theme.of(context)
                                                    //       .textTheme
                                                    //       .bodyText1!
                                                    //       .copyWith(
                                                    //         fontSize: 20,
                                                    //         fontWeight: FontWeight.w700,
                                                    //       ),
                                                    // ),
                                                    const SizedBox(height: 15),
                                                    poppinsText(
                                                        text: hotelProvider
                                                            .to.city,
                                                        size: 14.0,
                                                        color: const Color(
                                                            0xff757575)),
                                                    // Text(
                                                    //   // index == 0
                                                    //   //     ? "Istanbul, Turkiye"
                                                    //   //     : index == 1
                                                    //   //         ? "Paris, France"
                                                    //   //         : index == 2
                                                    //   //             ? "London, United Kingdom"
                                                    //   //             : "Rome, Italia",
                                                    //   style: Theme.of(context)
                                                    //       .textTheme
                                                    //       .bodyText1!
                                                    //       .copyWith(
                                                    //         fontSize: 14,
                                                    //         color:
                                                    //             const Color(0xff757575),
                                                    //       ),
                                                    // )
                                                    const SizedBox(height: 15),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xffFFD300),
                                                          size: 15,
                                                        ),
                                                        poppinsText(
                                                            text: hotelProvider
                                                                .hotels[index]
                                                                .reviews!
                                                                .score
                                                                .toString(),
                                                            size: 14.0,
                                                            color: Constants
                                                                .primaryColor)
                                                        // Text(
                                                        //   "  4.8  ",
                                                        //   style: Theme.of(context)
                                                        //       .textTheme
                                                        //       .bodyText1!
                                                        //       .copyWith(
                                                        //         fontSize: 14,
                                                        //         color: Constants
                                                        //             .primaryColor,
                                                        //       ),
                                                        // )
                                                        ,
                                                        poppinsText(
                                                            text:
                                                                ' ${hotelProvider.hotels[index].reviews!.total.toString()} reviews'),
                                                        // Text(
                                                        //   index == 0
                                                        //       ? "(4,981 reviews)"
                                                        //       : index == 1
                                                        //           ? "(4,981 reviews)"
                                                        //           : index == 2
                                                        //               ? "(3,672 reviews)"
                                                        //               : index == 3
                                                        //                   ? "(4,441 reviews)"
                                                        //                   : "(4,338 reviews)",
                                                        //   style: Theme.of(context)
                                                        //       .textTheme
                                                        //       .bodyText1!
                                                        //       .copyWith(
                                                        //         fontSize: 14,
                                                        //         color: const Color(
                                                        //             0xff757575),
                                                        //       ),
                                                        // ),
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
                                                        text: hotelProvider
                                                            .hotels[index]
                                                            .price!
                                                            .options![0]
                                                            .formattedDisplayPrice
                                                            .toString(),
                                                        size: 16.0,
                                                        color: Constants
                                                            .primaryColor),
                                                    // Text(
                                                    //   index == 0
                                                    //       ? "\$27"
                                                    //       : index == 1
                                                    //           ? "\$35"
                                                    //           : index == 2
                                                    //               ? "\$32"
                                                    //               : index == 3
                                                    //                   ? "\$36"
                                                    //                   : "\$38",
                                                    //   style: Theme.of(context)
                                                    //       .textTheme
                                                    //       .bodyText1!
                                                    //       .copyWith(
                                                    //         fontSize: 18,
                                                    //         color: Constants.primaryColor,
                                                    //       ),
                                                    // ),
                                                    const SizedBox(height: 8),
                                                    poppinsText(
                                                        text: "/night",
                                                        size: 10.0,
                                                        color:
                                                            Color(0xff757575)),
                                                    // Text(
                                                    //   "/ night",
                                                    //   style: Theme.of(context)
                                                    //       .textTheme
                                                    //       .bodyText1!
                                                    //       .copyWith(
                                                    //         fontSize: 10,
                                                    //         color:
                                                    //             const Color(0xff757575),
                                                    //       ),
                                                    // ),
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
                  )
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

Widget lottieLoader() {
  return Center(
    child: Lottie.asset('assets/lf30_editor_pdzneexn.json', height: 100),
  );
}
