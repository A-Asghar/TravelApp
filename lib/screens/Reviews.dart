import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/Review.dart';
import 'package:get/get.dart';

import '../widgets/filterView.dart';
import '../widgets/poppinsText.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key, required this.hotelReviews}) : super(key: key);

  final List<ReviewElement> hotelReviews;

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        title:
            poppinsText(text: "Reviews", size: 18.0, fontBold: FontWeight.w600),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),

              // Rating Selection
              // SizedBox(
              //   height: 38,
              //   width: Get.width,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.only(left: 20),
              //     itemCount: 6,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Padding(
              //         padding: const EdgeInsets.only(right: 14),
              //         child: ratingCard(
              //           index == 0
              //               ? "All"
              //               : index == 1
              //                   ? "5"
              //                   : index == 2
              //                       ? "4"
              //                       : index == 3
              //                           ? "3"
              //                           : index == 4
              //                               ? "2"
              //                               : index == 5
              //                                   ? "1"
              //                                   : "0.0",
              //           index == 0
              //               ? Constants.primaryColor
              //               : Colors.transparent,
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // const SizedBox(height: 20),

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
                      text: "  4.8  ",
                      size: 14.0,
                      color: Constants.primaryColor,
                    ),
                    poppinsText(
                      text:
                          "(${widget.hotelReviews.length.toString()} reviews)",
                      size: 14.0,
                      color: const Color(0xff757575),
                    ),
                    const Expanded(child: SizedBox()),
                    // poppinsText(
                    //   text: "See All",
                    //   size: 16.0,
                    //   color: Constants.primaryColor,
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Reviews List
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < widget.hotelReviews.length; i++)
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
                                          // text: i == 0
                                          //     ? "Jenny Wilson"
                                          //     : i == 1
                                          //         ? "Guy Hawkins"
                                          //         : "Kristin Watson",
                                          text: 'Anonymous',
                                          color: Constants.primaryColor,
                                          size: 16.0,
                                        ),
                                        const SizedBox(height: 5),
                                        poppinsText(
                                          // text: i == 0
                                          //     ? "Jenny Wilson"
                                          //     : i == 1
                                          //         ? "Guy Hawkins"
                                          //         : "Kristin Watson",
                                          text: widget.hotelReviews[i].title,
                                          size: 16.0,
                                        ),
                                        const SizedBox(height: 5),
                                        poppinsText(
                                          // text: i == 0
                                          //     ? "Dec 10, 2024"
                                          //     : i == 1
                                          //         ? "Dec 10, 2024"
                                          //         : "Dec 09, 2024",
                                          text: widget.hotelReviews[i]
                                              .submissionTimeLocalized
                                              .toString(),
                                          size: 12.0,
                                        )
                                      ],
                                    ),
                                    const Expanded(child: SizedBox()),
                                    ratingCard("5.0", Constants.primaryColor),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                poppinsText(
                                  // text: i == 0
                                  //     ? "Very nice and comfortable hotel, thank you for accompanying my vacation!"
                                  //     : i == 1
                                  //         ? "Very beautiful hotel, my family and I are very satisfied with the service!"
                                  text: widget.hotelReviews[i].text,
                                  size: 14.0,
                                )
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
        ],
      ),
    );
  }
}
