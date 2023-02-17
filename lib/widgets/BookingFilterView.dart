import 'package:flutter/material.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:get/get.dart';

import '../Constants.dart';
import '../screens/profile/Profile.dart';
import 'customButton.dart';

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
            const SizedBox(
              height: 20
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