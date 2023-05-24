import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/Package.dart';
import 'package:intl/intl.dart';

import '../widgets/poppinsText.dart';
import '../widgets/ratingCard.dart';

class PackageReviews extends StatefulWidget {
  const PackageReviews({Key? key, required this.package}) : super(key: key);
  final Package package;

  @override
  State<PackageReviews> createState() => _PackageReviewsState();
}

class _PackageReviewsState extends State<PackageReviews> {
  @override
  Widget build(BuildContext context) {
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
                    size: 16,
                  ),
                  poppinsText(
                    text: widget.package.rating.toString(),
                    size: 16.0,
                    color: Constants.primaryColor,
                  ),
                  poppinsText(
                    text: " (${widget.package.packageReviews!.length}) reviews",
                    size: 14.0,
                    color: Constants.secondaryColor,
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            const SizedBox(height: 20),
    
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: widget.package.packageReviews!.length,
                itemBuilder: (context, index) {
                  var review = widget.package.packageReviews![index];
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
                                            text: review.reviewerName,
                                            size: 16.0),
                                      ),
                                      const SizedBox(height: 5),
    
                                      // review time
                                      poppinsText(
                                          text: DateFormat('MMM dd, yyyy').format(
                                              DateTime.parse(review.reviewDate)),
                                          size: 12.0)
                                    ],
                                  ),
                                  const Expanded(child: SizedBox()),
    
                                  // review rating
                                  ratingCard(review.reviewRating.toString(),
                                      Constants.primaryColor),
                                ],
                              ),
                              const SizedBox(height: 15),
    
                              // review text
                              poppinsText(text: review.reviewText, size: 14.0)
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
      ),
    );
  }
}
