import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/Review.dart';
import 'package:fyp/repository/HotelRepository.dart';
import 'package:provider/provider.dart';

import '../models/PropertySearchListings.dart';
import '../providers/HotelSearchProvider.dart';
import '../widgets/filterView.dart';
import '../widgets/poppinsText.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key, required this.property}) : super(key: key);
  final PropertySearchListing property;

  @override
  State<Reviews> createState() => _ReviewsState();
}

int startingIndex = 0;
bool isLoading = false;

class _ReviewsState extends State<Reviews> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() async {
    print(controller.position.extentAfter);
    HotelRepository hotelRepository = HotelRepository();

    if (!isLoading && controller.position.extentAfter == 0) {
      setState(() => isLoading = true);
      setState(() => startingIndex += 10);
      List<ReviewElement> reviews = await hotelRepository.reviews(
          propertyId: widget.property.id!, startingIndex: startingIndex);
      setState(() => isLoading = false);
      setState(() {
        context.read<HotelSearchProvider>().hotelReviews.addAll(reviews);
      });
      // if (controller.position.extentAfter == 0) {
      //
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    var hotelProvider = context.watch<HotelSearchProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title:
            poppinsText(text: "Reviews", size: 18.0, fontBold: FontWeight.w600),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Rating Row
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                poppinsText(text: "Rating", size: 16.0),
                const SizedBox(width: 14),
                const Icon(
                  Icons.star,
                  color: Color(0xffFFD300),
                  size: 15,
                ),
                poppinsText(
                  text: "  ${widget.property.reviews?.score}  ",
                  size: 14.0,
                  color: Constants.primaryColor,
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              controller: controller,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: hotelProvider.hotelReviews.length,
              itemBuilder: (context, index) {
                return Padding(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        poppinsText(
                                          text: 'Anonymous',
                                          color: Constants.primaryColor,
                                          size: 16.0,
                                        ),
                                        const Spacer(),
                                        ratingCard(
                                            hotelProvider
                                                .hotelReviews[index]
                                                .reviewScoreWithDescription!
                                                .value!
                                                .split(' ')
                                                .first,
                                            Constants.primaryColor),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  poppinsText(
                                    text:
                                        hotelProvider.hotelReviews[index].title,
                                    size: 16.0,
                                  ),
                                  const SizedBox(height: 5),
                                  poppinsText(
                                    text: hotelProvider.hotelReviews[index]
                                        .submissionTimeLocalized
                                        .toString(),
                                    size: 12.0,
                                  )
                                ],
                              ),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                          const SizedBox(height: 15),
                          poppinsText(
                            text: hotelProvider.hotelReviews[index].text,
                            size: 14.0,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          isLoading
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
