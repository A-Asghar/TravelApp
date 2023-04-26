import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/Package.dart';
import 'package:fyp/screens/ConfirmPayment.dart';
import 'package:fyp/screens/HotelGallery.dart';
import 'package:fyp/screens/PackageReviews.dart';
import 'package:fyp/widgets/back_button.dart';
import 'package:fyp/widgets/expandable_text.dart';
import 'package:fyp/widgets/image_slider.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:fyp/widgets/ratingCard.dart';
import 'package:fyp/widgets/tealButton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
        physics: BouncingScrollPhysics(),
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

                //Day wise Details
                widget.package.dayWiseDetails!.isEmpty
                    ? Container()
                    : DayWiseDetail(
                        daywise: widget.package.dayWiseDetails,
                      ),

                const SizedBox(
                  height: 20,
                ),
                // Reviews
                InkWell(
                  onTap: () {
                    Get.to(
                      PackageReviews(
                        package: widget.package,
                      ),
                      transition: Transition.rightToLeft,
                    );
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
                        poppinsText(
                            text:
                                '(${widget.package.packageReviews!.length}) reviews',
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
                                              text: widget
                                                  .package
                                                  .packageReviews![i]
                                                  .reviewerName,
                                              size: 16.0),
                                          const SizedBox(height: 5),
                                          poppinsText(
                                              text: DateFormat('MMM dd, yyyy')
                                                  .format(DateTime.parse(widget
                                                      .package
                                                      .packageReviews![i]
                                                      .reviewDate)),
                                              size: 12.0)
                                        ],
                                      ),
                                      const Expanded(child: SizedBox()),
                                      ratingCard(
                                          widget.package.packageReviews![i]
                                              .reviewRating
                                              .toString(),
                                          Constants.primaryColor),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: poppinsText(
                                        text: widget.package.packageReviews![i]
                                            .reviewText,
                                        size: 14.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 70),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Material(
          elevation: 10,
          color: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 75,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
              child: TealButton(
                bgColor: Constants.primaryColor,
                txtColor: Colors.white,
                text: 'Book Now',
                onPressed: () =>
                    Get.to(ConfirmPaymentScreen(package: widget.package,), transition: Transition.fade),
              ),
            ),
          )),
    );
  }
}

class DayWiseDetail extends StatefulWidget {
  final List<String>? daywise;

  const DayWiseDetail({Key? key, this.daywise}) : super(key: key);

  @override
  _DayWiseDetailState createState() => _DayWiseDetailState();
}

class _DayWiseDetailState extends State<DayWiseDetail> {
  bool showAllItems = false;

  @override
  Widget build(BuildContext context) {
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
            itemCount: showAllItems ? widget.daywise!.length : 1,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: poppinsText(
                      text: '${widget.daywise![index]} \n', size: 16.0));
            }),
        GestureDetector(
          onTap: () {
            setState(() {
              showAllItems = !showAllItems;
            });
          },
          child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  poppinsText(
                      text: showAllItems ? "Show less" : "Show more",
                      color: Constants.primaryColor,
                      size: 16.0),
                  Icon(
                    showAllItems ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Constants.primaryColor,
                  )
                ],
              )),
        ),
      ],
    );
  }
}
