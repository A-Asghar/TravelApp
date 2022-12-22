import 'dart:convert';

import 'package:fyp/models/Flight.dart';

import '../network/FlightNetwork.dart';

class FlightRepository {
  FlightNetwork network = FlightNetwork();

  flightOffersSearch({
    required originLocationCode, // KHI
    required destinationLocationCode, // DXB
    required departureDate, // 2022-09-25
    returnDate = '', // 2022-09-27
    required adults, // 1
    nonStop = 'false', // false
    travelClass =
        'ECONOMY', // Available values : ECONOMY, PREMIUM_ECONOMY, BUSINESS, FIRST
    maxPrice = '9999',
  }) async {
    // https://developers.amadeus.com/self-service/category/air/api-doc/flight-offers-search/api-reference

    var response = await network.flightOffersSearch(
      originLocationCode,
      destinationLocationCode,
      departureDate,
      returnDate,
      adults,
      nonStop,
      travelClass,
      maxPrice,
    );

    print('FlightRepository flightOffersSearch() Response: $response');

    // var response = jsonDecode(r);
    response = jsonDecode(response);

    // print(response);
    // Number of search results returned
    int count = response['meta']['count'];
    print('Number of SearchResults Returned: $count');

    // Dictionary
    var dictionary = response['dictionaries'];
    // print('dictionary.runtimeType ${dictionary.runtimeType}');

    // List of all flights
    List listOfData = response['data'];

    Iterable<Flight> listOfFlights = listOfData.map((e) => Flight(
          oneWay: e['oneWay'],
          numberOfBookableSeats: e['numberOfBookableSeats'],
          itineraries: e['itineraries']
              .map<Itinerary>((i) => Itinerary(
                    duration: i['duration'],
                    segments: i['segments']
                        .map<Segment>((s) => Segment(
                            departure: Arrival.fromJson(s['departure']),
                            arrival: Arrival.fromJson(s['arrival']),
                            carrierCode: s['carrierCode'],
                            aircraft: Aircraft.fromJson(s['aircraft']),
                            duration: s['duration']))
                        .toList(),
                  ))
              .toList(),
          price: FlightPrice.fromJson(e['price']),
          validatingAirlineCodes: e['validatingAirlineCodes'],
          fareDetailsBySegment: e['travelerPricings'][0]['fareDetailsBySegment']
              .map<FareDetailsBySegment>(
                  (f) => FareDetailsBySegment(cabin: f['cabin']))
              .toList(),
        ));

    return [dictionary, listOfFlights.toList(), count];
  }
}
