import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants.dart';
import '../../widgets/poppinsText.dart';

class FlightsCompletedView extends StatefulWidget {
  const FlightsCompletedView({Key? key}) : super(key: key);

  @override
  State<FlightsCompletedView> createState() => _FlightsCompletedViewState();
}

class _FlightsCompletedViewState extends State<FlightsCompletedView> {
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
                                    color: Constants.secondaryColor,
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
                    Container(
                      height: 34,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.primaryColor.withOpacity(0.20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Constants.primaryColor,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                                size: 10,
                              ),
                            ),
                            const SizedBox(width: 14),
                            poppinsText(
                              text: "Yeay, you have completed it!",
                              size: 10.0,
                              color: Constants.primaryColor,
                            ),
                          ],
                        ),
                      ),
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
