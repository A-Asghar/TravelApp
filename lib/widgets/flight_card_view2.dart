import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/FlightBooking.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'dart:math' as math;

class FlightCardView2 extends StatefulWidget {
  const FlightCardView2({super.key, required this.flightBooking});

  final FlightBooking flightBooking;

  @override
  State<FlightCardView2> createState() => _FlightCardView2State();
}

class _FlightCardView2State extends State<FlightCardView2> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // // Flight Carrier
                // flightCarrier(context, widget.flightProvider, flight),

                // // Trip Duration
                // tripDuration(flight)
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Departure Time
                  poppinsText(
                      text: widget.flightBooking.fromTime,
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
                    angle: 90 * math.pi / 180,
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
                      text: widget.flightBooking.toTime,
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
                    text: widget.flightBooking.fromCity,
                    color: Constants.secondaryColor),
                poppinsText(
                    text: widget.flightBooking.toCity,
                    color: Constants.secondaryColor),
              ],
            ),
          ),

          // Number of connecting Flights
          connectingFlightsWidget(widget.flightBooking.connectingFlights),
          const SizedBox(height: 10),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                // Flight Class
                flightClass(widget.flightBooking.cabin),

                const Spacer(),

                poppinsText(text: 'From', color: Constants.secondaryColor),
                const SizedBox(
                  width: 10,
                ),
                // Trip Price
                tripPrice(widget.flightBooking.price),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ReturnFlightCardView2 extends StatefulWidget {
  const ReturnFlightCardView2({super.key, required this.flightBooking});

  final FlightBooking flightBooking;

  @override
  State<ReturnFlightCardView2> createState() => _ReturnFlightCardView2State();
}

class _ReturnFlightCardView2State extends State<ReturnFlightCardView2> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Flight Carrier
                flightCarrier(context, widget.flightBooking),

                // Trip Duration
                tripDuration(widget.flightBooking)
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Departure Time
                  poppinsText(
                      text: widget.flightBooking.fromTime,
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
                    angle: 90 * math.pi / 180,
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
                      text: widget.flightBooking.toTime,
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
                    text:
                        widget.flightBooking.toCity,
                    color: Constants.secondaryColor),
                poppinsText(
                    text:
                        widget.flightBooking.fromCity,
                    color: Constants.secondaryColor),
              ],
            ),
          ),

          // Number of connecting Flights
          connectingFlightsWidget(widget.flightBooking.connectingFlights),
          const SizedBox(height: 10),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                // Flight Class
                flightClass(widget.flightBooking.cabin),

                const Spacer(),

                poppinsText(text: 'From', color: Constants.secondaryColor),
                const SizedBox(
                  width: 10,
                ),
                // Trip Price
                tripPrice(widget.flightBooking.price),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget flightCarrier(BuildContext context, FlightBooking flightBooking) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    width: MediaQuery.of(context).size.width * 0.4,
    child: poppinsText(
        text:
            flightBooking.carrierName,
        size: 16.0,
        fontBold: FontWeight.w500),
  );
}

Widget tripDuration(FlightBooking flightBooking) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    child: poppinsText(
      text: flightBooking.flightDuration
          .replaceAll('PT', '')
          .replaceAll('H', 'H ')
          .toLowerCase(),
      // text: '${Constants.minutesToDuration(flight.segments.last.arrival.at.difference(flight.segments[0].departure.at).inMinutes)}',
      color: Constants.secondaryColor,
    ),
  );
}

Widget connectingFlightsWidget(connectingFlights) {
  return int.parse(connectingFlights) > 0
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.compare_arrows, color: Constants.secondaryColor),
            poppinsText(
                text: connectingFlights == 1
                    ? ' $connectingFlights connecting flight'
                    : ' $connectingFlights connecting flights',
                size: 12.0)
          ],
        )
      : Container();
}

Widget flightClass(cabin) {
  return Row(
    children: [
      const Icon(
        Icons.event_seat,
        color: Constants.secondaryColor,
        size: 15,
      ),
      const SizedBox(width: 5),
      poppinsText(
          text: cabin,
          color: Constants.secondaryColor,
          size: 14.0,
          fontBold: FontWeight.w500)
    ],
  );
}

Widget tripPrice(price) {
  return poppinsText(
      text: '\$$price  ',
      color: Constants.secondaryColor,
      fontBold: FontWeight.w600,
      size: 20.0);
}
