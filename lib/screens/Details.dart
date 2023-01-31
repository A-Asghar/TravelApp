import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyp/models/Detail.dart';
import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/providers/HotelSearchProvider.dart';
import 'package:fyp/repository/HotelRepository.dart';
import 'package:fyp/screens/hotel/HotelSearchResults.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants.dart';
import 'FullScreenImagePage.dart';
import 'HotelGallery.dart';
import 'Reviews.dart';
import 'WeatherScreen.dart';
import 'hotel/RoomDetails.dart';

class Details extends StatefulWidget {
  Details({Key? key, required this.detailsType, required this.property})
      : super(key: key);
  final String detailsType;
  final PropertySearchListing property;
  @override
  State<Details> createState() => _DetailsState();
}

String desc =
    """Would you not like to spend the most beautiful days of your life in the shape of Hunza Honeymoon deluxe tour 2022. As we all know, Hunza Valley attracts foreigners as well as domestic tourists alike. Furthermore, road structure is improving with every passing day. May it be hotels, restaurants, or local eatery, things are shaping up rather nicely. 

Hang tight! We are here with you for another extraordinary Hunza Honeymoon Deluxe tour in 2022. As the name suggests, the package is a combination of luxury and comfort. Furthermore, the landscape makes it compelling for newlyweds. Moreover, Hunza Valley has a fan following of sightseeing, but adventure lovers have some opportunities there. 

 Now guess what Husseini Bridge, the dangerous bridge features in this Hunza Honeymoon Deluxe Tour. Altit Village is a 1000-year-old village near karimabad offering stunning beauty of local life. You will witness an old swimming pool right in the centre of Altit Village with various restaurants nearby.

Furthermore, Baltit Fort presents magical views of the whole Hunza Valley.  Most interestingly, our Facebook Reviews are awesome. Click HERE to see what our customers say about Hunza Honeymoon deluxe tour 2022.
  """;

List<String> daywise = [
  """The first day, we shall be traveling to Chilas, it would take near 11 hours partially on the motorway and then Karakorum highway. We shall reach our destination by evening and check-in at Hotel
Shangrila Chilas Hotel""",
  """The first day sets the tone but 2nd day of the tour starts with the astounding beauty of Karakorum highway. First glimpse of glaciers. A short stay at Nangaparbat View Point along 03 Mountain range meeting Point. We would reach Hunza Karimabad in 06 Hours.
Serena Hunza or Darbar Hunza Hotel""",
  """Having Breakfast in Hotel will energize you. Some market visit along Baltit & Altit Fort is on task list along with entry Tickets. A bonus feature would be visiting Ganesh Village as well.
Serena Hunza or Darbar Hunza Hotel""",
  """We shall be Visiting Upper Hunza after Breakfast. Check out From Karimabad Hotel and reach the LUxury resort on Bank of Attabad Lake. We shall first check-in at Luxus Hunza Hotel, then we shall be having some activity like exploring Gulmit village, passu cons and much more.
Luxus Hunza Hotel""",
  """We would head towards Naltar Valley after checking out. It would be full-day activity on 4×4 Jeep. Once Naltar Valley is explored then we would reach Gilgit and check-in at Hotel
Serena Gilgit Hotel or Riverdale Hotel""",
  """After entertaining 05 Days,, our Journey turns towards the end. We shall head towards Besham Valley. It would take near 10 Hours
Besham Hilton Hotel""",
  """So guys, today is final day of Hunza Honeymoon deluxe tour. Easy Drive from Besham to Islamabad, takes only 6 Hours normally as roads are very good."""
];

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
    callHotelInfo();
  }

  callHotelInfo() async {
    HotelRepository hotelRepository = HotelRepository();
    List detailResponse =
        await hotelRepository.detail(propertyId: widget.property.id!);
    context.read<HotelSearchProvider>().hotelImages = detailResponse[0];
    context.read<HotelSearchProvider>().address = detailResponse[1];
    context.read<HotelSearchProvider>().coordinates = detailResponse[2];
    context.read<HotelSearchProvider>().amenities = detailResponse[3];
    context.read<HotelSearchProvider>().description = detailResponse[4];

    context.read<HotelSearchProvider>().hotelReviews =
        await hotelRepository.reviews(propertyId: widget.property.id!);
    context.read<HotelSearchProvider>().hotelRooms =
        await hotelRepository.getOffers(
            adults: context.read<HotelSearchProvider>().adults,
            checkIn:
                DateTime.parse(context.read<HotelSearchProvider>().checkIn),
            checkOut:
                DateTime.parse(context.read<HotelSearchProvider>().checkOut),
            regionId: widget.property.regionId!,
            propertyId: widget.property.id!);

  }

  @override
  Widget build(BuildContext context) {
    var hotelProvider = context.watch<HotelSearchProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: hotelProvider.hotelImages.isEmpty ||
              // hotelProvider.hotelReviews.isEmpty &&
              hotelProvider.hotelRooms.isEmpty
          ? lottieLoader()
          : WillPopScope(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    floating: false,
                    title: const backButton(),
                    pinned: true,
                    backgroundColor: Colors.white,
                    expandedHeight: 300,
                    flexibleSpace: FlexibleSpaceBar(
                      background: imageSlider(
                        propertyImages: hotelProvider.hotelImages,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Column(
                    children: [
                      returnLayout(),
                    ],
                  ),
                  ),
                ],
              ),
              onWillPop: () async {
                hotelProvider.clearHotelDetail();
                return true;
              },
            ),
    );
  }

  Widget returnLayout() {
    if (widget.detailsType == 'package') {
      return const PackageLayout(
        detailsType: 'package',
      );
    } else if (widget.detailsType == 'hotel') {
      return HotelLayout(
        detailsType: 'hotel',
        property: widget.property,
      );
    } else {
      return Container();
    }
  }
}

class HotelLayout extends StatefulWidget {
  const HotelLayout(
      {super.key, required this.detailsType, required this.property});

  final String detailsType;
  final PropertySearchListing property;

  @override
  State<HotelLayout> createState() => _HotelLayoutState();
}

class _HotelLayoutState extends State<HotelLayout> {
  @override
  Widget build(BuildContext context) {
    var hotelProvider = context.read<HotelSearchProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: poppinsText(
              text: /* Shelton's Rezidor*/
                  widget.property.name,
              size: 30.0),
        ),
        const SizedBox(height: 15),

        // Location
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  'assets/images/Location.svg',
                ),
              ),
              const SizedBox(width: 8),
              Container(
                  width: MediaQuery.of(context).size.width * 0.82,
                  child: poppinsText(text: hotelProvider.address, size: 16.0)),
            ],
          ),
        ),
        const SizedBox(height: 15),

        DateFormat("yyyy-MM-dd")
                    .parse(hotelProvider.checkIn)
                    .difference(DateTime.now())
                    .inDays >
                14
            ? InkWell(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.sunny_snowing,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 10),
                      poppinsText(
                          text: 'Check the weather on your arrival',
                          color: Colors.blue)
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WeatherScreen(
                      q: hotelProvider.to.city.split(',')[0],
                      dt: hotelProvider.checkIn,
                    ),
                  ));
                },
              )
            : Container(),

        // Gallery Photos
        InkWell(
          onTap: () {
            Get.to(
              HotelGallery(
                hotelImages: hotelProvider.hotelImages,
              ),
              transition: Transition.rightToLeft,
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                poppinsText(text: "Gallery Photos", size: 20.0),
                poppinsText(
                    text: "See All", size: 16.0, color: Constants.primaryColor),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: 5,
            padding: const EdgeInsets.only(left: 20),
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  height: 100,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(
                      image:
                          NetworkImage(hotelProvider.hotelImages[index]!.url!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),

        // Description
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: poppinsText(text: "Description", size: 20.0),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ExpandableText(text: hotelProvider.description),
        ),
        const SizedBox(height: 20),

        // Facilities
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: poppinsText(text: "Facilities", size: 20.0),
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 200,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hotelProvider.amenities!.length < 6
                  ? hotelProvider.amenities?.length
                  : 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 80,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.bottomLeft,
                  child: poppinsText(
                      text: hotelProvider.amenities![index].text!
                          .replaceAll(' ', '\n')),
                );
              }),
        ),

        // Location Map
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: poppinsText(text: "Location", size: 20.0),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            // Get.to(
            //   const HotelLocationScreen(),
            //   transition: Transition.rightToLeft,
            // );
          },
          child: InkWell(
            onTap: () {
              _launchMap(hotelProvider.coordinates);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/map.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Rooms
        hotelRooms(widget.detailsType == 'hotel', hotelProvider),

        // Reviews
        InkWell(
          onTap: () {
            if (hotelProvider.hotelReviews.isNotEmpty) {
              Get.to(
                Reviews(
                  property: widget.property,
                ),
                transition: Transition.rightToLeft,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                poppinsText(text: "Reviews", size: 20.0),
                const SizedBox(width: 14),
                const Icon(
                  Icons.star,
                  color: Color(0xffFFD300),
                  size: 15,
                ),
                poppinsText(
                  text: widget.property.reviews!.score
                      .toString(), // text: ' 4.9 ',
                  size: 14.0,
                  color: Constants.primaryColor,
                ),
                poppinsText(
                    text: //'(4,567) reviews',
                        " (${widget.property.reviews?.total.toString()}) reviews",
                    size: 14.0),
                const Expanded(child: SizedBox()),
                poppinsText(
                  text: "See All",
                  size: 16.0,
                  color: Constants.primaryColor,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        hotelProvider.hotelReviews.isEmpty
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < 3; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        poppinsText(
                                            text: 'Anonymous', size: 16.0),
                                        const SizedBox(height: 5),
                                        poppinsText(
                                            text: hotelProvider.hotelReviews[i]
                                                .submissionTimeLocalized,
                                            size: 12.0)
                                      ],
                                    ),
                                    const Expanded(child: SizedBox()),
                                    ratingCard(
                                        hotelProvider.hotelReviews[i]
                                            .reviewScoreWithDescription!.value!
                                            .split(' ')
                                            .first,
                                        Constants.primaryColor),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                poppinsText(
                                    text: hotelProvider.hotelReviews[i].text,
                                    size: 14.0)
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
      ],
    );
  }
}

class PackageLayout extends StatefulWidget {
  const PackageLayout({super.key, required this.detailsType});

  final String detailsType;

  @override
  State<PackageLayout> createState() => _PackageLayoutState();
}

class _PackageLayoutState extends State<PackageLayout> {
  @override
  Widget build(BuildContext context) {
    var hotelProvider = context.watch<HotelSearchProvider>();
    return Container();
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     // Title
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
    //       child: poppinsText(
    //           text: "Shelton's Rezidor",
    //           // widget.property!.name,
    //           size: 30.0),
    //     ),
    //     const SizedBox(height: 15),
    //
    //     // Location
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20, right: 20),
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             height: 20,
    //             width: 20,
    //             child: SvgPicture.asset(
    //               'assets/images/Location.svg',
    //             ),
    //           ),
    //           const SizedBox(width: 8),
    //           poppinsText(text: hotelProvider.address, size: 14.0),
    //         ],
    //       ),
    //     ),
    //     const SizedBox(height: 15),
    //
    //     // Gallery Photos
    //     InkWell(
    //       onTap: () {
    //         Get.to(
    //           HotelGallery(
    //             hotelImages: hotelProvider.hotelImages,
    //           ),
    //           transition: Transition.rightToLeft,
    //         );
    //       },
    //       child: Padding(
    //         padding: const EdgeInsets.only(left: 20, right: 20),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             poppinsText(text: "Gallery Photos", size: 20.0),
    //             poppinsText(
    //                 text: "See All", size: 16.0, color: Constants.primaryColor),
    //           ],
    //         ),
    //       ),
    //     ),
    //     const SizedBox(height: 10),
    //     SizedBox(
    //       height: 100,
    //       width: MediaQuery.of(context).size.width,
    //       child: ListView.builder(
    //         itemCount: 5,
    //         padding: const EdgeInsets.only(left: 20),
    //         physics: const ClampingScrollPhysics(),
    //         scrollDirection: Axis.horizontal,
    //         itemBuilder: (BuildContext context, int index) {
    //           return Padding(
    //             padding: const EdgeInsets.only(right: 20),
    //             child: Container(
    //               height: 100,
    //               width: 140,
    //               decoration: BoxDecoration(
    //                 image: DecorationImage(
    //                   image: NetworkImage(hotelProvider.hotelImages[index]!.url!
    //                       // index == 0
    //                       //     ? 'assets/images/g1.png'
    //                       //     : index == 1
    //                       //         ? 'assets/images/g2.png'
    //                       //         : index == 2
    //                       //             ? 'assets/images/g3.png'
    //                       //             : index == 3
    //                       //                 ? 'assets/images/g4.png'
    //                       //                 : 'assets/images/g5.png',
    //                       ),
    //                   fit: BoxFit.fill,
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //     const SizedBox(height: 20),
    //
    //     // Details
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20, right: 20),
    //       child: poppinsText(
    //         text: "Details",
    //         size: 20.0,
    //       ),
    //     ),
    //     const SizedBox(height: 20),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         //Put in ListView
    //         detailCard('assets/images/i2.png', "Hotels"),
    //       ],
    //     ),
    //     const SizedBox(height: 20),
    //
    //     // Description
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20, right: 20),
    //       child: poppinsText(text: "Description", size: 20.0),
    //     ),
    //     const SizedBox(height: 20),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20, right: 20),
    //       child: ExpandableText(text: desc),
    //     ),
    //     const SizedBox(height: 20),
    //
    //     // Facilities
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20, right: 20),
    //       child: poppinsText(text: "Facilities", size: 20.0),
    //     ),
    //     const SizedBox(height: 20),
    //
    //     //Put in GridView
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         detailCard('assets/images/i6.png', "Swimming Pool"),
    //       ],
    //     ),
    //     //const SizedBox(height: 20),
    //     // Row(
    //     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     //   children: [
    //     //     detailCard('assets/images/i10.png', "Meeting Room"),
    //     //     detailCard('assets/images/i11.png', "Elevator"),
    //     //     detailCard('assets/images/i12.png', "Fitness Center"),
    //     //     detailCard('assets/images/i2.png', "24-hours Open"),
    //     //   ],
    //     // ),
    //     const SizedBox(height: 20),
    //
    //     // Day wise Details
    //     dayWiseDetail(widget.detailsType == 'package', daywise),
    //
    //     // Location Map
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20, right: 20),
    //       child: poppinsText(text: "Location", size: 20.0),
    //     ),
    //     const SizedBox(height: 20),
    //     InkWell(
    //       onTap: () {
    //         // Get.to(
    //         //   const HotelLocationScreen(),
    //         //   transition: Transition.rightToLeft,
    //         // );
    //       },
    //       child: InkWell(
    //         onTap: _launchMap(hotelProvider.coordinates),
    //         child: Padding(
    //           padding: const EdgeInsets.only(left: 20, right: 20),
    //           child: SizedBox(
    //             height: 180,
    //             width: MediaQuery.of(context).size.width,
    //             child: Image.asset(
    //               'assets/images/map.png',
    //               fit: BoxFit.fill,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //     const SizedBox(height: 20),
    //
    //     // Reviews
    //     InkWell(
    //       onTap: () {
    //         // Get.to(
    //         //   Reviews(
    //         //     property: widget.property,
    //         //   ),
    //         //   transition: Transition.rightToLeft,
    //         // );
    //       },
    //       child: Padding(
    //         padding: const EdgeInsets.only(left: 20, right: 20),
    //         child: Row(
    //           children: [
    //             poppinsText(text: "Reviews", size: 20.0),
    //             const SizedBox(width: 14),
    //             const Icon(
    //               Icons.star,
    //               color: Color(0xffFFD300),
    //               size: 15,
    //             ),
    //             poppinsText(
    //               // text: widget.property!.reviews!.score
    //               //     .toString(),
    //               text: ' 4.9 ',
    //               size: 14.0,
    //               color: Constants.primaryColor,
    //             ),
    //             poppinsText(
    //                 text: '(4,567) reviews',
    //                 // " (${widget.property!.reviews!.total.toString()}) reviews",
    //                 size: 14.0),
    //             const Expanded(child: SizedBox()),
    //             poppinsText(
    //               text: "See All",
    //               size: 16.0,
    //               color: Constants.primaryColor,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     const SizedBox(height: 20),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 20, right: 20),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           for (var i = 0; i < 3; i++)
    //             Padding(
    //               padding: const EdgeInsets.only(bottom: 20),
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   color: Colors.grey.withOpacity(0.1),
    //                   borderRadius: BorderRadius.circular(16),
    //                 ),
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(16.0),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           const SizedBox(width: 14),
    //                           Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               poppinsText(
    //                                   text: hotelProvider.hotelReviews[i].title,
    //                                   // text: i == 0
    //                                   //     ? "Jenny Wilson"
    //                                   //     : i == 1
    //                                   //         ? "Guy Hawkins"
    //                                   //         : "Kristin Watson",
    //                                   size: 16.0),
    //                               const SizedBox(height: 5),
    //                               poppinsText(
    //                                   text: hotelProvider.hotelReviews[i]
    //                                       .submissionTimeLocalized,
    //                                   // text: i == 0
    //                                   //     ? "Dec 10, 2024"
    //                                   //     : i == 1
    //                                   //         ? "Dec 10, 2024"
    //                                   //         : "Dec 09, 2024",
    //                                   size: 12.0)
    //                             ],
    //                           ),
    //                           const Expanded(child: SizedBox()),
    //                           ratingCard(
    //                               // ' 4.8 ',
    //                               hotelProvider.hotelReviews[i]
    //                                   .reviewScoreWithDescription!.value!
    //                                   .split(' ')[0],
    //                               Constants.primaryColor),
    //                         ],
    //                       ),
    //                       const SizedBox(height: 15),
    //                       poppinsText(
    //                         text: hotelProvider.hotelReviews[i].text,
    //                         // text: i == 0
    //                         //     ? "Very nice and comfortable hotel, thank you for accompanying my vacation!"
    //                         //     : i == 0
    //                         //         ? "Very beautiful hotel, my family and I are very satisfied with the service!"
    //                         //         : "The rooms are very comfortable and the natural views are amazing, can't wait to come back again!",
    //                         // size: 14.0
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           const SizedBox(height: 20),
    //           InkWell(
    //             onTap: () {
    //               // Get.to(
    //               //   Reviews(
    //               //     property: widget.property,
    //               //   ),
    //               //   transition: Transition.rightToLeft,
    //               // );
    //             },
    //             child: Container(
    //               height: 50,
    //               width: MediaQuery.of(context).size.width,
    //               decoration: BoxDecoration(
    //                 color: Constants.primaryColor.withOpacity(0.2),
    //                 borderRadius: BorderRadius.circular(100),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   poppinsText(
    //                     text: "More  ",
    //                     size: 16.0,
    //                     color: Constants.primaryColor,
    //                     fontBold: FontWeight.w700,
    //                   ),
    //                   const Icon(
    //                     Icons.keyboard_arrow_down,
    //                     color: Constants.primaryColor,
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //           const SizedBox(height: 20),
    //         ],
    //       ),
    //     )
    //   ],
    // );
  }
}

Widget dayWiseDetail(bool show, daywise) {
  return show
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: poppinsText(text: "Day wise Itinerary", size: 20.0),
            ),
            ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: daywise.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: poppinsText(
                        text: 'Day $index: ${daywise[index]} \n', size: 14.0),
                  );
                }),
            const SizedBox(height: 20),
          ],
        )
      : Container();
}

Widget hotelRooms(bool show, HotelSearchProvider hotelProvider) {
  return show
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: poppinsText(text: "Rooms", size: 20.0),
            ),
            hotelProvider.hotelRooms.isEmpty
                ? Container(
                    child: poppinsText(text: 'No Rooms available !'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: hotelProvider.hotelRooms.length,
                    itemBuilder: (context, index) {
                      return hotelProvider
                              .hotelRooms[index].ratePlans!.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    hotelProvider.hotelRooms[index].unitGallery!
                                            .gallery!.isNotEmpty
                                        ? SizedBox(
                                            height: 220,
                                            child: ListView.builder(
                                              shrinkWrap: false,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: hotelProvider
                                                  .hotelRooms[index]
                                                  .unitGallery!
                                                  .gallery!
                                                  .length,
                                              itemBuilder: (context, idx) {
                                                return Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: GestureDetector(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                          hotelProvider
                                                              .hotelRooms[index]
                                                              .unitGallery!
                                                              .gallery![idx]
                                                              .image!
                                                              .url!),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FullScreenImagePage(
                                                                  image: hotelProvider
                                                                      .hotelRooms[
                                                                          index]
                                                                      .unitGallery!
                                                                      .gallery![
                                                                          idx]
                                                                      .image!
                                                                      .url!),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : Container(),
                                    poppinsText(
                                        text: hotelProvider
                                            .hotelRooms[index].header!.text,
                                        size: 18.0,
                                        fontBold: FontWeight.w500),
                                    poppinsText(
                                        text: 'Show details',
                                        color: Constants.primaryColor,
                                        size: 14.0),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            poppinsText(
                                                text: 'Room Only',
                                                fontBold: FontWeight.w500,
                                                size: 18.0),
                                            poppinsText(
                                                text: 'Double Room, Balcony',
                                                color: Constants.secondaryColor,
                                                size: 14.0),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.info,
                                                  color: Colors.amber,
                                                ),
                                                poppinsText(
                                                    text: ' Non-refundable',
                                                    color: Colors.amber)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.info,
                                                  color: Constants.primaryColor,
                                                ),
                                                poppinsText(
                                                    text: ' Free-cancellation',
                                                    color:
                                                        Constants.primaryColor)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                poppinsText(
                                                    text: hotelProvider
                                                        .hotelRooms[index]
                                                        .ratePlans![0]
                                                        .priceDetails![0]
                                                        .price!
                                                        .lead!
                                                        .amount
                                                        .toStringAsFixed(2),
                                                    color:
                                                        Constants.primaryColor,
                                                    size: 22.0),
                                                poppinsText(
                                                    text: ' /night',
                                                    color: Constants
                                                        .secondaryColor,
                                                    size: 12.0),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          RoomDetails(
                                                              details: hotelProvider
                                                                  .hotelRooms[
                                                                      index]
                                                                  .description!),
                                                    ));
                                                  },
                                                  child: Container(
                                                    width: 150,
                                                    height: 40,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: Constants
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Center(
                                                      child: poppinsText(
                                                          text: 'Book Now',
                                                          color: Colors.white,
                                                          fontBold:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container();
                    },
                  ),
            const SizedBox(height: 20),
          ],
        )
      : Container();
}

class backButton extends StatefulWidget {
  const backButton({super.key});

  @override
  State<backButton> createState() => _backButtonState();
}

class _backButtonState extends State<backButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.7),
          borderRadius: BorderRadius.circular(50)),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          context.read<HotelSearchProvider>().clearHotelDetail();
        },
        child: Center(
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white.withOpacity(0.9),
            size: 30,
          ),
        ),
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({super.key, required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? poppinsText(
              text: firstHalf,
              color: Colors.grey,
            )
          : Column(
              children: <Widget>[
                poppinsText(
                  text: flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  color: Colors.black87,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      poppinsText(
                        text: flag ? "Show more" : "Show less",
                        color: Constants.primaryColor,
                        size: 16.0,
                      ),
                      Icon(
                        flag
                            ? Icons.arrow_drop_down_outlined
                            : Icons.arrow_drop_up,
                        color: Constants.primaryColor,
                      )
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}

class imageSlider extends StatefulWidget {
  const imageSlider({Key? key, required this.propertyImages}) : super(key: key);

  final List<ImageImage?> propertyImages;

  @override
  State<imageSlider> createState() => _imageSliderState();
}

class _imageSliderState extends State<imageSlider> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: widget.propertyImages.length,
        pageSnapping: true,
        itemBuilder: (context, pagePosition) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Image.network(
                  widget.propertyImages[pagePosition]!.url!,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: 370,
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5)),
                      child: poppinsText(
                          text:
                              '${pagePosition + 1}/${widget.propertyImages.length}',
                          color: Colors.white)),
                )
              ],
            ),
          );
        });
  }
}

Widget detailCard(String image, String text) {
  return Column(
    children: [
      Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
          ),
        ),
      ),
      const SizedBox(height: 8),
      poppinsText(text: text, size: 12.0),
    ],
  );
}

Widget ratingCard(String text, Color bgColor) {
  return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.star,
            color: Colors.white,
            size: 15,
          ),
          const SizedBox(width: 10),
          poppinsText(text: text, size: 16.0, color: Colors.white),
        ],
      ),
    ),
  );
}

_launchMap(Coordinates coord) async {
  final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${coord.latitude},${coord.longitude}');
  try {
    await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    );
  } catch (e) {
    print(e);
  }
}
