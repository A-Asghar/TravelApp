import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../network/BookingNetwork.dart';
import '../../widgets/poppinsText.dart';

class FlightsOnGoingView extends StatefulWidget {
  const FlightsOnGoingView({Key? key}) : super(key: key);

  @override
  State<FlightsOnGoingView> createState() => _FlightsOnGoingViewState();
}

class _FlightsOnGoingViewState extends State<FlightsOnGoingView> {
  void initState() {
    super.initState();
    getTravelerBookings();
  }

  bool isLoading = false;
  List bookingsFromFirebase = [];

  getTravelerBookings() async {
    setState(() => isLoading = true);
    BookingNetwork bookingNetwork = BookingNetwork();
    var snapshot = await bookingNetwork.getTravelerFlightBooking(
        travelerId: FirebaseAuth.instance.currentUser?.uid);
    bookingsFromFirebase = snapshot.docs.map((doc) => doc.data()).toList();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator(),)
        : bookingsFromFirebase.isEmpty ? Center(
        child: poppinsText(text: "No Bookings Yet!")) : Expanded(
      child: ListView.builder(
        itemCount: bookingsFromFirebase.length,
        padding: const EdgeInsets.only(bottom: 60),
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Constants.secondaryColor.withOpacity(0.05) ,
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Flight Carrier
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: poppinsText(
                                      text: 'Flight Duration',
                                      size: 16.0,
                                      fontBold: FontWeight.w500),
                                ),

                                // Trip Duration
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: poppinsText(
                                    text: bookingsFromFirebase[index]['flightDuration'],
                                    // text: '${Constants.minutesToDuration(flight.segments.last.arrival.at.difference(flight.segments[0].departure.at).inMinutes)}',
                                    color: Constants.secondaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Departure Time
                                  poppinsText(
                                      text: bookingsFromFirebase[index]['fromTime'],
                                      size: 22.0,
                                      fontBold: FontWeight.w400),
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
                                    child: const Icon(
                                      Icons.flight,
                                      color: Constants.primaryColor,
                                      size: 25,
                                    ),
                                  ),

                                  const Expanded(
                                      child: Divider(
                                    color: Constants.secondaryColor,
                                    indent: 10,
                                    endIndent: 20,
                                  )),

                                  // Arrival Time
                                  poppinsText(
                                      text: bookingsFromFirebase[index]['toTime'],
                                      size: 22.0,
                                      fontBold: FontWeight.w400),
                                ]),
                          ),

                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                poppinsText(
                                    text: bookingsFromFirebase[index]['fromCity'],
                                    color: Constants.secondaryColor),
                                poppinsText(
                                    text: bookingsFromFirebase[index]['toCity'],
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
                                    const Icon(
                                      Icons.event_seat,
                                      color: Constants.secondaryColor,
                                      size: 15,
                                    ),
                                    const SizedBox(width: 5),
                                    poppinsText(
                                        text: bookingsFromFirebase[index]['cabin'],
                                        color: Constants.secondaryColor,
                                        size: 14.0,
                                        fontBold: FontWeight.w500)
                                  ],
                                ),

                                const Spacer(),


                                const SizedBox(
                                  width: 10,
                                ),
                                // Trip Price
                                poppinsText(
                                    text: "\$" + bookingsFromFirebase[index]['price'],
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
                    Row(
                      children: [
                        poppinsText(text: "   Booked On : ${bookingsFromFirebase[index]['bookingDate']}",size: 22.0, fontBold: FontWeight.w500)
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
