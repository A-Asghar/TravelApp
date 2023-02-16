import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/Package.dart';
import 'package:fyp/screens/HotelGallery.dart';
import 'package:fyp/widgets/back_button.dart';
import 'package:fyp/widgets/detail_card.dart';
import 'package:fyp/widgets/expandable_text.dart';
import 'package:fyp/widgets/image_slider.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:fyp/widgets/ratingCard.dart';
import 'package:get/get.dart';

class PackageDetails extends StatefulWidget {
  const PackageDetails({super.key, required this.package});

  final Package package;

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            floating: false,
            title: backButton(onTap: () {
              Navigator.pop(context);
            }),
            pinned: true,
            backgroundColor: Colors.white,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background:
                  PackageImageSlider(propertyImages: widget.package.imgUrls),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: poppinsText(
                      text: widget.package.packageName,
                      // widget.property!.name,
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
                      poppinsText(text: widget.package.destination, size: 14.0),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // Gallery Photos
                InkWell(
                  onTap: () {
                    Get.to(
                      PackageGallery(
                        packageImages: widget.package.imgUrls,
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
                      var image = widget.package.imgUrls[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          height: 100,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(image),
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
                      ExpandableText(text: widget.package.packageDescription),
                ),
                const SizedBox(height: 20),

                // Facilities
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: poppinsText(text: "Facilities", size: 20.0),
                ),
                const SizedBox(height: 20),

                //Put in GridView
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      detailCard("Swimming Pool"),
                      detailCard("Elevator"),
                      detailCard("Fitness Center"),
                      detailCard("24-hours Open"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      detailCard("Meeting Room"),
                      detailCard("Elevator"),
                      detailCard("Fitness Center"),
                      detailCard("24-hours Open"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                //Day wise Details
                widget.package.dayWiseDetails!.isEmpty
                    ? Container()
                    : dayWiseDetail(widget.package.dayWiseDetails),

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
                    onTap: () {},
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

                // Reviews
                InkWell(
                  onTap: () {
                    // Get.to(
                    //   Reviews(
                    //     property: widget.property,
                    //   ),
                    //   transition: Transition.rightToLeft,
                    // );
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
                          text: widget.package.rating.toString(),
                          size: 14.0,
                          color: Constants.primaryColor,
                        ),
                        poppinsText(text: '(4,567) reviews', size: 14.0),
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
                Padding(
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
                                      const SizedBox(width: 14),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          poppinsText(
                                              text: i == 0
                                                  ? "Jenny Wilson"
                                                  : i == 1
                                                      ? "Guy Hawkins"
                                                      : "Kristin Watson",
                                              size: 16.0),
                                          const SizedBox(height: 5),
                                          poppinsText(
                                              text: i == 0
                                                  ? "Dec 10, 2024"
                                                  : i == 1
                                                      ? "Dec 10, 2024"
                                                      : "Dec 09, 2024",
                                              size: 12.0)
                                        ],
                                      ),
                                      const Expanded(child: SizedBox()),
                                      ratingCard(
                                          ' 4.8 ', Constants.primaryColor),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  poppinsText(
                                      text: i == 0
                                          ? "Very nice and comfortable hotel, thank you for accompanying my vacation!"
                                          : i == 0
                                              ? "Very beautiful hotel, my family and I are very satisfied with the service!"
                                              : "The rooms are very comfortable and the natural views are amazing, can't wait to come back again!",
                                      size: 14.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget dayWiseDetail(List<String>? daywise) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: poppinsText(text: "Day wise Itinerary", size: 20.0),
      ),
      ListView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: daywise!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: poppinsText(text: '${daywise[index]} \n', size: 14.0),
            );
          }),
      const SizedBox(height: 20),
    ],
  );
}
