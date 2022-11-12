import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fyp/providers/SearchProvider.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';
import '../models/Flight.dart';
import 'FlightDetails.dart';

class FlightSearchResult extends StatefulWidget {
  const FlightSearchResult({Key? key}) : super(key: key);

  @override
  State<FlightSearchResult> createState() => _FlightSearchResultState();
}

class _FlightSearchResultState extends State<FlightSearchResult> {
  @override
  Widget build(BuildContext context) {
    Clear(){
      context.read<SearchProvider>().clearFlights();
      context.read<SearchProvider>().dictionary = null;
      context.read<SearchProvider>().count = null;
    }

    var destProvider = context.watch<SearchProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Constants.primaryColor),
          onPressed: () {
            Clear();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Clear();
          return true;
        },
        child: Column(
          children: [
            // Departure Options
            // Container(
            //   margin: const EdgeInsets.only(left: 10),
            //   alignment: Alignment.centerLeft,
            //   child: poppinsText(
            //       text: 'Departure Options',
            //       size: 20.0,
            //       fontBold: FontWeight.w600),
            // ),

            // Number of results returned
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: poppinsText(
                  text:context.read<SearchProvider>().flights.isNotEmpty
                      ? '${context.read<SearchProvider>().count} flights available'
                      : '',
                  color: Constants.secondaryColor,
                )),

            Expanded(
              child: (context.watch<SearchProvider>().flights.isEmpty &&
                      context.watch<SearchProvider>().count == null)
                  ? Center(
                      child: Lottie.asset('assets/lf30_editor_pdzneexn.json',height: 100),
                    )
                  : context.read<SearchProvider>().count! == 0
                      ? Center(
                          child: poppinsText(text: 'Not Found', size: 30.0))
                      : ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: destProvider.flights.length,
                          itemBuilder: (context, index) {
                            Itinerary flight = destProvider.flights[index].itineraries[0];
                            int connectingFlights = flight.segments.length - 1;
                            return GestureDetector(
                              onTap: (){
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context)=> FlightDetails(trip: destProvider.flights[index])));
                              },
                              child: Card(
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
                                          flightCarrier(destProvider, flight),

                                          // Trip Duration
                                          tripDuration(flight)
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 10,),
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal:10),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                            poppinsText(text: Constants.convertTime(flight.segments[0].departure.at),
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
                                              angle: 90 * math.pi / 180,
                                              child: const Icon(Icons.flight,color: Constants.primaryColor,size: 25,),
                                            ),

                                            const Expanded(
                                                child: Divider(
                                                  color: Constants.secondaryColor,
                                                  indent: 10,
                                                  endIndent: 20,
                                                )),

                                            // Arrival Time
                                            poppinsText(text: Constants.convertTime(flight.segments.last.arrival.at),
                                                size: 22.0,fontBold: FontWeight.w400),
                                          ]
                                      ),
                                    ),


                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal:10),
                                      child: Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        children: [
                                          poppinsText(text:'${flight.segments[0].departure.iataCode} (${Constants.iataList[flight.segments[0].departure.iataCode]![1]})',
                                              color: Constants.secondaryColor),
                                          poppinsText(text:'${flight.segments.last.arrival.iataCode} (${Constants.iataList[flight.segments.last.arrival.iataCode]![1]})',
                                              color: Constants.secondaryColor),
                                        ],
                                      ),
                                    ),


                                    // Number of connecting Flights
                                    connectingFlightsWidget(connectingFlights),
                                    const SizedBox(height: 10),


                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        children: [

                                          // Flight Class
                                          flightClass(destProvider.flights[index]
                                              .fareDetailsBySegment[0].cabin),

                                          const Spacer(),

                                          poppinsText(text: 'From',color: Constants.secondaryColor),
                                          const SizedBox(width: 10,),
                                          // Trip Price
                                          tripPrice(destProvider.flights[index].price.total),

                                          // More Info
                                          // moreInfoButton(context, destProvider.flights[index])
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            )
          ],
        ),
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

  Widget locationAndTime(location, time) {
    return Expanded(
      child: ListTile(
        title: poppinsText(
            text: location,
            size: 20.0,
            color: Constants.primaryColor,
            fontBold: FontWeight.w500),
        subtitle: poppinsText(
            text: Constants.convertTime(time),
            size: 12.0,
            color: Constants.secondaryColor,
            fontBold: FontWeight.w500),
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
        Icon(Icons.event_seat,color: Constants.secondaryColor,size: 15,),
        const SizedBox(width: 5,),
        poppinsText(text: cabin, color: Constants.secondaryColor, size: 14.0, fontBold: FontWeight.w500)
      ],
    );
  }

  Widget tripPrice(price) {
    return poppinsText(
        text: '\$$price  ',
        color: Colors.black,
        fontBold: FontWeight.w600,
        size: 20.0);
  }

  Widget moreInfoButton(context,trip) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FlightDetails(trip:trip)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Constants.primaryColor),
        ),
        child: poppinsText(text: 'More Info', color: Constants.primaryColor),
      ),
    );
  }
}
