import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/widgets/tealButton.dart';

import '../../Constants.dart';
import '../../widgets/poppinsText.dart';
import 'canceled_booking.dart';

class OnGoingView extends StatefulWidget {
  const OnGoingView({Key? key}) : super(key: key);

  @override
  State<OnGoingView> createState() => _OnGoingViewState();
}

class _OnGoingViewState extends State<OnGoingView> {
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: poppinsText(
                                text: index == 0
                                    ? "Royale President Hotel"
                                    : index == 1
                                        ? "Monte-Carlo Hotel"
                                        : "Lagonissi Royal Villa",
                                size: 18.0,
                                fontBold: FontWeight.w700,
                              ),
                            ),
                            poppinsText(
                              text: index == 0
                                  ? "Paris, France"
                                  : index == 1
                                      ? "Rome, Italia"
                                      : "London, United Kingdom",
                              size: 14.0,
                              color: const Color(0xff616161),
                            ),
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
                                  height: 330,
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
                                        // const SizedBox(height: 10),
                                        const Divider(color: Color(0xffEEEEEE)),
                                        // const SizedBox(height: 10),
                                        Text(
                                          "Are you sure you want to cancel your hotel\nbooking?",
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
                                        const SizedBox(height: 10),
                                        Column(
                                          children: [
                                            TealButton(
                                                text: 'Cancel',
                                                bgColor:
                                                    Colors.red.withOpacity(0.3),
                                                txtColor: Colors.red,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                            // const SizedBox(width: 15),
                                            TealButton(
                                                text: 'Yes, Continue',
                                                bgColor: Constants.primaryColor,
                                                txtColor: Colors.white,
                                                onPressed: () {
                                                  Get.to(
                                                    const CancelBookingScreen(),
                                                    transition:
                                                        Transition.rightToLeft,
                                                  );
                                                })
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
