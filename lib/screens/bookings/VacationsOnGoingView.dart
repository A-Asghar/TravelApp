import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants.dart';
import '../../widgets/customButton.dart';
import '../../widgets/poppinsText.dart';
import 'CancelBookingScreen.dart';

/** TODO : Moiz baki k 2 ongoing me jo kaam kara hua hai vo isme bhi kardena
 * */

class VacationsOnGoingView extends StatefulWidget {
  const VacationsOnGoingView({Key? key}) : super(key: key);

  @override
  State<VacationsOnGoingView> createState() => _VacationsOnGoingViewState();
}

class _VacationsOnGoingViewState extends State<VacationsOnGoingView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 4,
        padding: const EdgeInsets.only(bottom: 60),
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff04060F).withOpacity(0.05),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                index == 0
                                    ? 'assets/images/d1.png'
                                    : index == 1
                                    ? 'assets/images/d2.png'
                                    : 'assets/images/d3.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            poppinsText(
                              text: index == 0
                                  ? "Paris"
                                  : index == 1
                                  ? "Rome"
                                  : "London",
                              size: 18.0,
                              fontBold: FontWeight.w700,
                            ),
                            const SizedBox(height: 15),
                            poppinsText(
                              text: index == 0
                                  ? "Paris, France"
                                  : index == 1
                                  ? "Rome, Italia"
                                  : "London, United Kingdom",
                              size: 14.0,
                              color: const Color(0xff616161),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 24,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Constants.primaryColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: poppinsText(
                                  text: "Paid",
                                  size: 10.0,
                                  color: Constants.primaryColor,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Divider(color: Color(0xffEEEEEE)),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                  height: 310,
                                  width: Get.width,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        Text(
                                          "Cancel Booking",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                            fontSize: 24,
                                            color: const Color(0xffF75555),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Divider(color: Color(0xffEEEEEE)),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Are you sure you want to cancel your vacations\nbooking?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                            fontSize: 16,
                                            height: 1.6,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Only 80% of the money you can refund from your payment according to our policy",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                            fontSize: 14,
                                            height: 1.6,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          children: [
                                            CustomButton(
                                              text: "Cancel",
                                              bgColor: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!
                                                  .withOpacity(0.1),
                                              textColor: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            const SizedBox(width: 15),
                                            CustomButton(
                                              text: "Yes, Continue",
                                              onTap: () {
                                                Get.to(
                                                  const CancelBookingScreen(),
                                                  transition:
                                                  Transition.rightToLeft,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 38,
                              width: Get.width,
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Constants.primaryColor),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: poppinsText(
                                  text: "Cancel Booking",
                                  size: 16.0,
                                  color: Constants.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 38,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Constants.primaryColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: poppinsText(
                                  text: "View Ticket",
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
