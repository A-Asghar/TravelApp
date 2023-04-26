import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/Flight.dart';
import 'package:fyp/providers/FlightSearchProvider.dart';
import 'package:fyp/widgets/poppinsText.dart';

class FlightCardView extends StatefulWidget {
  const FlightCardView(
      {super.key, required this.flight, required this.flightProvider});

  final Flight flight;
  final FlightSearchProvider flightProvider;

  @override
  State<FlightCardView> createState() => _FlightCardViewState();
}

class _FlightCardViewState extends State<FlightCardView> {
  @override
  Widget build(BuildContext context) {
    Itinerary flight = widget.flight.itineraries[0];
    int connectingFlights = flight.segments.length - 1;
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
                flightCarrier(widget.flightProvider, flight),

                // Trip Duration
                tripDuration(flight)
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
                      text: Constants.convertTime(
                          flight.segments[0].departure.at),
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
                      text: Constants.convertTime(
                          flight.segments.last.arrival.at),
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
                        '${flight.segments[0].departure.iataCode} (${Constants.iataList[flight.segments[0].departure.iataCode]![1]})',
                    color: Constants.secondaryColor),
                poppinsText(
                    text:
                        '${flight.segments.last.arrival.iataCode} (${Constants.iataList[flight.segments.last.arrival.iataCode]![1]})',
                    color: Constants.secondaryColor),
              ],
            ),
          ),

          // Number of connecting Flights
          connectingFlightsWidget(connectingFlights),
          const SizedBox(height: 10),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                // Flight Class
                flightClass(
                    widget.flight.fareDetailsBySegment[0].cabin),

                const Spacer(),

                poppinsText(text: 'From', color: Constants.secondaryColor),
                const SizedBox(
                  width: 10,
                ),
                // Trip Price
                tripPrice(widget.flight.price.total),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget flightCarrier(destProvider, flight) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * 0.4,
      child: poppinsText(
          text: '${destProvider.dictionary['carriers'][flight.segments[0].carrierCode]}',
          size: 16.0,
          fontBold: FontWeight.w500),
    );
  }

  Widget tripDuration(Itinerary flight) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: poppinsText(
        text: flight.duration.replaceAll('PT', '').replaceAll('H', 'H ').toLowerCase(),
          // text: '${Constants.minutesToDuration(flight.segments.last.arrival.at.difference(flight.segments[0].departure.at).inMinutes)}',
          color: Constants.secondaryColor,
          ),
    );
  }

  Widget connectingFlightsWidget(connectingFlights) {
    return connectingFlights > 0
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
        const Icon(Icons.event_seat,color: Constants.secondaryColor,size: 15,),
        const SizedBox(width: 5),
        poppinsText(text: cabin, color: Constants.secondaryColor, size: 14.0, fontBold: FontWeight.w500)
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
}
