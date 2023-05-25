import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/providers/HomeProvider.dart';
import 'package:fyp/providers/loading_provider.dart';
import 'package:fyp/repository/HotelRepository.dart';
import 'package:fyp/screens/FullScreenImagePage.dart';
import 'package:fyp/screens/HotelGallery.dart';
import 'package:fyp/screens/Reviews.dart';
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
import 'package:provider/provider.dart';

class HotelHomeDetails extends StatefulWidget {
  HotelHomeDetails({super.key, required this.property});

  final PropertySearchListing property;

  @override
  State<HotelHomeDetails> createState() => _HotelHomeDetailsState();
}

class _HotelHomeDetailsState extends State<HotelHomeDetails> {
  @override
  void initState() {
    super.initState();
    fetchHotelData();
  }

  bool isLoading = false;

  fetchHotelData() async {
    var s = DateTime.now();
    HotelRepository hotelRepository = HotelRepository();

    Future.microtask(() {
      context.read<LoadingProvider>().loadingUpdate = 'Fetching Hotel Details';
    });

    setState(() => isLoading = true);

    context.read<HomeProvider>().hotelRooms =
        await hotelRepository.getHotelRooms(
            propertyId: widget.property.id, regionId: widget.property.regionId);

    // Future.microtask(() {
    //   context.read<LoadingProvider>().loadingUpdate = 'Fetching Hotel Reviews';
    // });

    List detailResponse =
        await hotelRepository.getHotelDetails(propertyId: widget.property.id);
    if (mounted) {
      context.read<HomeProvider>().hotelImages = detailResponse[0];
      context.read<HomeProvider>().amenities = detailResponse[1];
      context.read<HomeProvider>().coordinates = detailResponse[2];
      context.read<HomeProvider>().description = detailResponse[3];
      context.read<HomeProvider>().address = detailResponse[4];
      context.read<HomeProvider>().mapImage = detailResponse[5];
    }

    // Future.microtask(() {
    //   context.read<LoadingProvider>().loadingUpdate = 'Fetching Hotel Rooms';
    // });

    context.read<HomeProvider>().hotelReviews =
        await hotelRepository.getHotelReviews(propertyId: widget.property.id);
    if (mounted) {
      setState(() => isLoading = false);
    }
    var e = DateTime.now();
    print(e.difference(s).inSeconds);
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = context.watch<HomeProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? lottieLoader(context)
          : WillPopScope(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    floating: false,
                    title: backButton(onTap: () {
                      Navigator.pop(context);
                      context.read<HomeProvider>().clearHotelDetail();
                    }),
                    pinned: true,
                    backgroundColor: Colors.white,
                    expandedHeight: 300,
                    flexibleSpace: FlexibleSpaceBar(
                      background: HotelImageSlider(
                        propertyImages: homeProvider.hotelImages,
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
                              size: 30.0,
                              fontBold: FontWeight.w500),
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
                                      text: homeProvider.address, size: 16.0)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Gallery Photos
                        InkWell(
                          onTap: () {
                            Get.to(
                              HotelGallery(
                                hotelImages: homeProvider.hotelImages,
                              ),
                              transition: Transition.rightToLeft,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                poppinsText(text: "Gallery Photos", size: 20.0, fontBold: FontWeight.w500),
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
                                      image: NetworkImage(homeProvider
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
                          child: poppinsText(text: "Description", size: 20.0, fontBold: FontWeight.w500),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ExpandableText(text: homeProvider.description),
                        ),
                        const SizedBox(height: 20),

                        // Facilities
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: poppinsText(text: "Facilities", size: 20.0, fontBold: FontWeight.w500),
                        ),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          height: 200,
                          alignment: Alignment.topLeft,
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: homeProvider.amenities!.length < 6
                                  ? homeProvider.amenities?.length
                                  : 6,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisExtent: 70,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: Alignment.topLeft,
                                  child: poppinsText(
                                    text:
                                        "• ${homeProvider.amenities![index].text!.replaceAll(' ', ' \n  ')}",
                                  ),
                                );
                              }),
                        ),

                        // Location Map
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: poppinsText(text: "Location", size: 20.0, fontBold: FontWeight.w500),
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
                              launchMap(homeProvider.coordinates);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: homeProvider.mapImage!.isEmpty ||
                                                homeProvider.mapImage == null
                                            ? AssetImage(
                                                'assets/images/map.png',
                                              )
                                            : NetworkImage(
                                                homeProvider.mapImage!,
                                              ) as ImageProvider<Object>,
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Rooms
                        hotelRooms1(homeProvider, widget.property),

                        // Reviews
                        InkWell(
                          onTap: () {
                            if (homeProvider.hotelReviews.isNotEmpty) {
                              Get.to(
                                Reviews2(
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
                                poppinsText(text: "Reviews", size: 20.0, fontBold: FontWeight.w500),
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
                        homeProvider.hotelReviews.isEmpty
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
                                                              text: homeProvider
                                                                      .hotelReviews[
                                                                          i]
                                                                      .stayDuration ??
                                                                  'Anonymous',
                                                              size: 16.0),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        poppinsText(
                                                            text: homeProvider
                                                                .hotelReviews[i]
                                                                .submissionTimeLocalized,
                                                            size: 12.0)
                                                      ],
                                                    ),
                                                    const Expanded(
                                                        child: SizedBox()),
                                                    ratingCard(
                                                        homeProvider
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
                                                    text: homeProvider
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
                homeProvider.clearHotelDetail();
                return true;
              },
            ),
    );
  }
}

Widget hotelRooms1(HomeProvider homeProvider, PropertySearchListing property) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: poppinsText(text: "Rooms", size: 20.0, fontBold: FontWeight.w500),
      ),
      homeProvider.hotelRooms.isEmpty
          ? Container(
              margin: const EdgeInsets.only(left: 20),
              child: poppinsText(text: 'No Rooms available !'),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: homeProvider.hotelRooms.length,
              itemBuilder: (context, index) {
                return homeProvider.hotelRooms[index].ratePlans!.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              homeProvider.hotelRooms[index].unitGallery!
                                      .gallery!.isNotEmpty
                                  ? SizedBox(
                                      height: 220,
                                      child: ListView.builder(
                                        shrinkWrap: false,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: homeProvider
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
                                                    homeProvider
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
                                                            image: homeProvider
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
                                    text: homeProvider
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
                                      homeProvider
                                                  .hotelRooms[index]
                                                  .ratePlans![0]
                                                  .priceDetails![0]
                                                  .availability
                                                  ?.scarcityMessage !=
                                              null
                                          ? Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_right,
                                                  color: Colors.red,
                                                ),
                                                poppinsText(
                                                    text: homeProvider
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
                                            )
                                          : Container(),
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
                                                    homeProvider
                                                            .hotelRooms[index]
                                                            .ratePlans![0]
                                                            .highlightedMessages![
                                                                0]
                                                            .content!
                                                            .join(' ') ??
                                                        '');
                                              },
                                              child: poppinsText(
                                                  text: homeProvider
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
                                              text:
                                                  "\$${homeProvider.hotelRooms[index].ratePlans![0].priceDetails![0].price!.lead!.amount.toStringAsFixed(2)}",
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
                                                  unit: homeProvider
                                                      .hotelRooms[index],
                                                  property: property,
                                                ),
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
