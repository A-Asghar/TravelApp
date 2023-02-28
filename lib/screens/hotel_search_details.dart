import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/providers/HotelSearchProvider.dart';
import 'package:fyp/repository/HotelRepository.dart';
import 'package:fyp/screens/FullScreenImagePage.dart';
import 'package:fyp/screens/HotelGallery.dart';
import 'package:fyp/screens/Reviews.dart';
import 'package:fyp/screens/WeatherScreen.dart';
import 'package:fyp/screens/hotel/RoomDetails.dart';
import 'package:fyp/widgets/back_button.dart';
import 'package:fyp/widgets/errorSnackBar.dart';
import 'package:fyp/widgets/expandable_text.dart';
import 'package:fyp/widgets/image_slider.dart';
import 'package:fyp/widgets/launch_map.dart';
import 'package:fyp/widgets/lottie_loader.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:fyp/widgets/ratingCard.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HotelSearchDetails extends StatefulWidget {
  const HotelSearchDetails({super.key, required this.property});

  final PropertySearchListing property;

  @override
  State<HotelSearchDetails> createState() => _HotelSearchDetailsState();
}

class _HotelSearchDetailsState extends State<HotelSearchDetails> {
  @override
  void initState() {
    super.initState();
    callHotelInfo();
  }

  bool isLoading = false;
  callHotelInfo() async {
    var s = DateTime.now();
    setState(() => isLoading = true);
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
    setState(() => isLoading = false);
    var e = DateTime.now();
    print(e.difference(s).inSeconds);
    print(
        'context.read<HotelSearchProvider>().hotelReviews.length: ${context.read<HotelSearchProvider>().hotelReviews.length}');
  }

  @override
  Widget build(BuildContext context) {
    var hotelProvider = context.watch<HotelSearchProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? lottieLoader()
          : WillPopScope(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    floating: false,
                    title: backButton(onTap: () {
                      Navigator.pop(context);
                      context.read<HotelSearchProvider>().clearHotelDetail();
                    }),
                    pinned: true,
                    backgroundColor: Colors.white,
                    expandedHeight: 300,
                    flexibleSpace: FlexibleSpaceBar(
                      background: HotelImageSlider(
                        propertyImages: hotelProvider.hotelImages,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
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
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.82,
                                  child: poppinsText(
                                      text: hotelProvider.address, size: 16.0)),
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
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.sunny_snowing,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(width: 10),
                                      poppinsText(
                                          text:
                                              'Check the weather on your arrival',
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
                                    text: "See All",
                                    size: 16.0,
                                    color: Constants.primaryColor),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(hotelProvider
                                          .hotelImages[index]!.url!),
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
                          child:
                              ExpandableText(text: hotelProvider.description),
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
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisExtent: 60,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: Alignment.bottomLeft,
                                  child: poppinsText(
                                      text: hotelProvider
                                          .amenities![index].text!
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
                              launchMap(hotelProvider.coordinates);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
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
                        hotelRooms2(hotelProvider),

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
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var i = 0; i < 3; i++)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          child: poppinsText(
                                                              text: hotelProvider
                                                                      .hotelReviews[
                                                                          i]
                                                                      .stayDuration ??
                                                                  'Anonymous',
                                                              size: 16.0),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        poppinsText(
                                                            text: hotelProvider
                                                                .hotelReviews[i]
                                                                .submissionTimeLocalized,
                                                            size: 12.0)
                                                      ],
                                                    ),
                                                    const Expanded(
                                                        child: SizedBox()),
                                                    ratingCard(
                                                        hotelProvider
                                                            .hotelReviews[i]
                                                            .reviewScoreWithDescription!
                                                            .value!
                                                            .split(' ')
                                                            .first,
                                                        Constants.primaryColor),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                poppinsText(
                                                    text: hotelProvider
                                                        .hotelReviews[i].text,
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
}

Widget hotelRooms2(HotelSearchProvider hotelProvider) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: poppinsText(text: "Rooms", size: 20.0),
      ),
      hotelProvider.hotelRooms.isEmpty
          ? Container(
              margin: const EdgeInsets.only(left: 20),
              child: poppinsText(text: 'No Rooms available !'),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: hotelProvider.hotelRooms.length,
              itemBuilder: (context, index) {
                return hotelProvider.hotelRooms[index].ratePlans!.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              hotelProvider.hotelRooms[index].unitGallery!
                                      .gallery!.isNotEmpty
                                  ? SizedBox(
                                      height: 220,
                                      child: ListView.builder(
                                        shrinkWrap: false,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: hotelProvider
                                            .hotelRooms[index]
                                            .unitGallery!
                                            .gallery!
                                            .length,
                                        itemBuilder: (context, idx) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: GestureDetector(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                                                .gallery![idx]
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
                                  : Container(
                                      height: 220,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: poppinsText(
                                    text: hotelProvider
                                        .hotelRooms[index].header!.text,
                                    size: 18.0,
                                    fontBold: FontWeight.w500),
                              ),
                              // poppinsText(
                              //     text: 'Show details',
                              //     color: Constants.primaryColor,
                              //     size: 14.0),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_right,
                                            color: Colors.red,
                                          ),
                                          poppinsText(
                                              text: hotelProvider
                                                      .hotelRooms[index]
                                                      .ratePlans![0]
                                                      .priceDetails![0]
                                                      .availability
                                                      ?.scarcityMessage ??
                                                  '',
                                              fontBold: FontWeight.w400,
                                              color: Colors.red,
                                              size: 18.0),
                                        ],
                                      ),
                                      // poppinsText(
                                      //     text: 'Double Room, Balcony',
                                      //     color: Constants.secondaryColor,
                                      //     size: 14.0),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.info,
                                            color: Colors.amber,
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 5),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: InkWell(
                                              onTap: () {
                                                errorSnackBar(
                                                    context,
                                                    hotelProvider
                                                            .hotelRooms[index]
                                                            .ratePlans![0]
                                                            .highlightedMessages![
                                                                0]
                                                            .content!
                                                            .join(' ') ??
                                                        '');
                                              },
                                              child: poppinsText(
                                                  text: hotelProvider
                                                      .hotelRooms[index]
                                                      .ratePlans![0]
                                                      .priceDetails![0]
                                                      .cancellationPolicy
                                                      ?.type,
                                                  color: Colors.amber),
                                            ),
                                          )
                                        ],
                                      ),
                                      // Row(
                                      //   children: [
                                      //     const Icon(
                                      //       Icons.info,
                                      //       color: Constants.primaryColor,
                                      //     ),
                                      //     poppinsText(
                                      //         text: ' Free-cancellation',
                                      //         color:
                                      //             Constants.primaryColor)
                                      //   ],
                                      // ),
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
                                              color: Constants.primaryColor,
                                              size: 22.0),
                                          poppinsText(
                                              text: ' /night',
                                              color: Constants.secondaryColor,
                                              size: 12.0),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    RoomDetails(
                                                        details: hotelProvider
                                                            .hotelRooms[index]
                                                            .description!),
                                              ));
                                            },
                                            child: Container(
                                              width: 150,
                                              height: 40,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                color: Constants.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Center(
                                                child: poppinsText(
                                                    text: 'Book Now',
                                                    color: Colors.white,
                                                    fontBold: FontWeight.w500),
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
  );
}
