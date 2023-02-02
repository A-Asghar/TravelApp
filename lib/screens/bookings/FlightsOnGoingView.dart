import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants.dart';
import '../../widgets/customButton.dart';
import '../../widgets/poppinsText.dart';
import 'CancelBookingScreen.dart';

class FlightsOnGoingView extends StatefulWidget {
  const FlightsOnGoingView({Key? key}) : super(key: key);

  @override
  State<FlightsOnGoingView> createState() => _FlightsOnGoingViewState();
}

class _FlightsOnGoingViewState extends State<FlightsOnGoingView> {
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
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [

                                // Flight Carrier
                            Container(
                            margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.4,
                child: poppinsText(
                    text: 'Flight Duration',
                    size: 16.0,
                    fontBold: FontWeight.w500),
              ),

                                // Trip Duration
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: poppinsText(
                  text: '2 hrs',
                  // text: '${Constants.minutesToDuration(flight.segments.last.arrival.at.difference(flight.segments[0].departure.at).inMinutes)}',
                  color: Constants.secondaryColor,
                ),
              )
                              ],
                            ),
                          ),

                          const SizedBox(height: 10,),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal:10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[


                                  // Departure Time
                                  poppinsText(text: '15:00',
                                      size: 22.0,fontBold: FontWeight.w400),
                                  const Expanded(
                                    child: Divider(
                                      color: Constants.secondaryColor,
                                      indent: 20,
                                      endIndent: 10,
                                    ),
                                  ),

                                  // Airplane Icon
                                  Transform.rotate(
                                    angle: 90 * 3.1415 / 180,
                                    child: const Icon(Icons.flight,color: Constants.primaryColor,size: 25,),
                                  ),

                                  const Expanded(
                                      child: Divider(
                                        color: Constants.secondaryColor,
                                        indent: 10,
                                        endIndent: 20,
                                      )),

                                  // Arrival Time
                                  poppinsText(text: '17:00',
                                      size: 22.0,fontBold: FontWeight.w400),
                                ]
                            ),
                          ),


                          Container(
                            margin: const EdgeInsets.symmetric(horizontal:10),
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                poppinsText(text:'Khi',
                                    color: Constants.secondaryColor),
                                poppinsText(text:'Dubai',
                                    color: Constants.secondaryColor),
                              ],
                            ),
                          ),


                          // Number of connecting Flights
                          //connectingFlightsWidget(connectingFlights),
                          const SizedBox(height: 10),


                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              children: [

                                // Flight Class
                            Row(
                            children: [
                            const Icon(Icons.event_seat,color: Constants.secondaryColor,size: 15,),
                            const SizedBox(width: 5),
                            poppinsText(text: 'cabin', color: Constants.secondaryColor, size: 14.0, fontBold: FontWeight.w500)
                            ],
                          ),

                                const Spacer(),

                                poppinsText(text: 'From',color: Constants.secondaryColor),
                                const SizedBox(width: 10,),
                                // Trip Price
              poppinsText(
                  text: '\$200  ',
                  color: Colors.black,
                  fontBold: FontWeight.w600,
                  size: 20.0),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // const SizedBox(height: 15),
                    // const Divider(color: Color(0xffEEEEEE)),
                    // const SizedBox(height: 15),
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
                                          "Are you sure you want to cancel your flight\nbooking?",
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
