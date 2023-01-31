import 'package:flutter/material.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:get/get.dart';

import '../Constants.dart';
import '../screens/Home.dart';
import '../screens/Profile.dart';

class BookingFilterView extends StatelessWidget {
  const BookingFilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height - 450,
      decoration: const BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Icon(
                Icons.horizontal_rule_rounded,
                size: 60,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                 const Expanded(child: SizedBox()),
                poppinsText(text: "Filter Bookings", size: 24.0),
                const Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  poppinsText(
                    text: "Accomodation Type",
                    size: 18.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: Get.width,
              child: ListView.builder(
                itemCount: 3,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: Row(
                      children: [
                        tickCard(
                          index == 0
                              ? "Flights"
                              : index == 1
                              ? "Hotels"
                              : index == 2
                              ? "Vacations"
                              : "Restaurant",
                          index == 0 || index == 1
                              ? Constants.primaryColor
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Expanded(
            //   child: ListView(
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.only(right: 20),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 poppinsText(text: "Country", size: 18.0),
            //                 poppinsText(
            //                   text: "See All",
            //                   size: 18.0,
            //                   color: Constants.primaryColor,
            //                 ),
            //               ],
            //             ),
            //           ),
            //           const SizedBox(height: 15),
            //           SizedBox(
            //             height: 40,
            //             width: Get.width,
            //             child: ListView.builder(
            //               itemCount: 4,
            //               padding: EdgeInsets.zero,
            //               scrollDirection: Axis.horizontal,
            //               itemBuilder: (BuildContext context, int index) {
            //                 return Padding(
            //                   padding: const EdgeInsets.only(right: 14),
            //                   child: Row(
            //                     children: [
            //                       searchCard(
            //                         index == 0
            //                             ? "France"
            //                             : index == 1
            //                             ? "Italia"
            //                             : index == 2
            //                             ? "Turkiye"
            //                             : "Germany",
            //                         index == 0
            //                             ? Constants.primaryColor
            //                             : Colors.transparent,
            //                             () {},
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               },
            //             ),
            //           ),
            //           const SizedBox(height: 20),
            //           Padding(
            //             padding: const EdgeInsets.only(right: 20),
            //             child: poppinsText(
            //               text: "Sort Results",
            //               size: 18.0,
            //             ),
            //           ),
            //           const SizedBox(height: 15),
            //           SizedBox(
            //             height: 40,
            //             width: Get.width,
            //             child: ListView.builder(
            //               itemCount: 4,
            //               padding: EdgeInsets.zero,
            //               scrollDirection: Axis.horizontal,
            //               itemBuilder: (BuildContext context, int index) {
            //                 return Padding(
            //                   padding: const EdgeInsets.only(right: 14),
            //                   child: Row(
            //                     children: [
            //                       searchCard(
            //                         index == 0
            //                             ? "Highest Popularity"
            //                             : index == 1
            //                             ? "Highest Price"
            //                             : "Lowest Price",
            //                         index == 0
            //                             ? Constants.primaryColor
            //                             : Colors.transparent,
            //                             () {},
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               },
            //             ),
            //           ),
            //           const SizedBox(height: 20),
            //           Padding(
            //             padding: const EdgeInsets.only(right: 20),
            //             child: poppinsText(
            //               text: "Star Rating",
            //               size: 18.0,
            //             ),
            //           ),
            //           const SizedBox(height: 15),
            //           SizedBox(
            //             height: 40,
            //             width: Get.width,
            //             child: ListView.builder(
            //               itemCount: 5,
            //               padding: EdgeInsets.zero,
            //               scrollDirection: Axis.horizontal,
            //               itemBuilder: (BuildContext context, int index) {
            //                 return Padding(
            //                   padding: const EdgeInsets.only(right: 14),
            //                   child: Row(
            //                     children: [
            //                       ratingCard(
            //                         index == 0
            //                             ? "5"
            //                             : index == 1
            //                             ? "4"
            //                             : index == 2
            //                             ? "3"
            //                             : index == 3
            //                             ? "2"
            //                             : "1",
            //                         index == 0
            //                             ? Constants.primaryColor
            //                             : Colors.transparent,
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               },
            //             ),
            //           ),
            //           const SizedBox(height: 20),
            //           Padding(
            //             padding: const EdgeInsets.only(right: 20),
            //             child: poppinsText(
            //               text: "Price Range Per Night",
            //               size: 18.0,
            //             ),
            //           ),
            //           const SizedBox(height: 20),
            //           Container(
            //             height: 47,
            //             width: Get.width,
            //             decoration: const BoxDecoration(
            //               image: DecorationImage(
            //                 image: AssetImage(
            //                   'assets/images/divider.png',
            //                 ),
            //                 fit: BoxFit.fill,
            //               ),
            //             ),
            //           ),
            //           const SizedBox(height: 20),
            //           Padding(
            //             padding: const EdgeInsets.only(right: 20),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 poppinsText(
            //                   text: "Facilities",
            //                   size: 18.0,
            //                 ),
            //                 poppinsText(
            //                   text: "See All",
            //                   size: 18.0,
            //                   color: Constants.primaryColor,
            //                 ),
            //               ],
            //             ),
            //           ),
            //           const SizedBox(height: 15),
            //           SizedBox(
            //             height: 40,
            //             width: Get.width,
            //             child: ListView.builder(
            //               itemCount: 4,
            //               padding: EdgeInsets.zero,
            //               scrollDirection: Axis.horizontal,
            //               itemBuilder: (BuildContext context, int index) {
            //                 return Padding(
            //                   padding: const EdgeInsets.only(right: 14),
            //                   child: Row(
            //                     children: [
            //                       tickCard(
            //                         index == 0
            //                             ? "WiFi"
            //                             : index == 1
            //                             ? "Swimming Pool"
            //                             : index == 2
            //                             ? "Parking"
            //                             : "Restaurant",
            //                         index == 0 || index == 1
            //                             ? Constants.primaryColor
            //                             : Colors.transparent,
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               },
            //             ),
            //           ),
            //           const SizedBox(height: 20),
            //           Padding(
            //             padding: const EdgeInsets.only(right: 20),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 poppinsText(
            //                   text: "Accommodation Type",
            //                   size: 18.0,
            //                 ),
            //                 poppinsText(
            //                   text: "See All",
            //                   size: 18.0,
            //                   color: Constants.primaryColor,
            //                 ),
            //               ],
            //             ),
            //           ),
            //           const SizedBox(height: 15),
            //           SizedBox(
            //             height: 40,
            //             width: Get.width,
            //             child: ListView.builder(
            //               itemCount: 4,
            //               padding: EdgeInsets.zero,
            //               scrollDirection: Axis.horizontal,
            //               itemBuilder: (BuildContext context, int index) {
            //                 return Padding(
            //                   padding: const EdgeInsets.only(right: 14),
            //                   child: Row(
            //                     children: [
            //                       tickCard(
            //                         index == 0
            //                             ? "Hotels"
            //                             : index == 1
            //                             ? "Resorts"
            //                             : index == 2
            //                             ? "Villas"
            //                             : "Apartments",
            //                         index == 0 || index == 2
            //                             ? Constants.primaryColor
            //                             : Colors.transparent,
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               },
            //             ),
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            const SizedBox(height: 15),
            const Divider(color: Color(0xffEEEEEE)),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "Reset",
                      onTap: () {
                        Navigator.pop(context);
                      },
                      bgColor: Constants.primaryColor.withOpacity(0.1),
                      textColor: Constants.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: CustomButton(
                      text: "Apply Filter",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
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
          Icon(
            Icons.star,
            color: bgColor == Constants.primaryColor
                ? Colors.white
                : Constants.primaryColor,
            size: 15,
          ),
          const SizedBox(width: 10),
          poppinsText(
            text: text,
            size: 16.0,
            color: bgColor == Constants.primaryColor
                ? Colors.white
                : Constants.primaryColor,
          ),
        ],
      ),
    ),
  );
}

Widget tickCard(String text, Color bgColor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(
            color: Constants.primaryColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.check,
          size: 16,
          color: bgColor == Constants.primaryColor
              ? Colors.white
              : Colors.transparent,
        ),
      ),
      const SizedBox(width: 14),
      poppinsText(
        text: text,
        size: 16.0,
      ),
    ],
  );
}