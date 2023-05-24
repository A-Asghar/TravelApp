import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/Review.dart';
import 'package:fyp/repository/HotelRepository.dart';
import 'package:provider/provider.dart';

import '../models/PropertySearchListings.dart';
import '../providers/HotelSearchProvider.dart';
import '../widgets/poppinsText.dart';
import '../widgets/ratingCard.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key, required this.property}) : super(key: key);
  final PropertySearchListing property;

  @override
  State<Reviews> createState() => _ReviewsState();
}

int startingIndex = 0;
bool isLoading = false;
HotelRepository hotelRepository = HotelRepository();

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
    if (!isLoading && controller.position.extentAfter == 0) {
      setState(() => isLoading = true);
      setState(() => startingIndex += 10);
      List<ReviewElement> reviews = await hotelRepository.reviews(
          propertyId: widget.property.id!, startingIndex: startingIndex);
      setState(() => isLoading = false);
      setState(() {
        context.read<HotelSearchProvider>().hotelReviews.addAll(reviews);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var hotelProvider = context.watch<HotelSearchProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Constants.secondaryColor,
            ),
          ),
          title:
              poppinsText(text: "Reviews", size: 24.0, fontBold: FontWeight.w500),
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
                  var review = hotelProvider.hotelReviews[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0),
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
                                      // stayDuration ( name + stayDuration )
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.5,
                                        child: poppinsText(
                                            text: review.stayDuration ??
                                                'Anonymous',
                                            size: 16.0),
                                      ),
                                      const SizedBox(height: 5),
    
                                      // review time
                                      poppinsText(
                                          text: review.submissionTimeLocalized,
                                          size: 12.0)
                                    ],
                                  ),
                                  const Expanded(child: SizedBox()),
    
                                  // review rating
                                  ratingCard(
                                      review.reviewScoreWithDescription!.value!
                                          .split(' ')
                                          .first,
                                      Constants.primaryColor),
                                ],
                              ),
                              const SizedBox(height: 15),
    
                              // review text
                              poppinsText(text: review.text, size: 14.0)
                            ],
                          ),
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
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
