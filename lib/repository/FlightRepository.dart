import 'dart:convert';

import 'package:fyp/models/Flight.dart';
import 'package:fyp/providers/SearchProvider.dart';

import '../network.dart';

class FlightRepository {
  Network network = Network();

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

    // Flight Class
    // print(listOfFlights.toList()[0].fareDetailsBySegment[0].cabin);

    // Departure City
    // print(listOfFlights.toList()[0].itineraries[0].segments[0].departure.iataCode);

    // Flight Company
    // print(listOfFlights.toList()[0].itineraries[0].segments[0].carrierCode);

    // Type of Aircraft
    // print(listOfFlights.toList()[0].itineraries[0].segments[0].aircraft.code);

    return [dictionary, listOfFlights.toList(), count];
  }

  citySearch({required String keyword}) async {
    var response = await network.citySearch(keyword: keyword);
    response = jsonDecode(response);

    List<Destination> cities = response['data']
        .map<Destination>((c) => Destination(
        city: c['address']['cityName'] + ', ' + c['address']['countryName'],
        iata: c['iataCode']))
        .toList();

    // print(cities[0].iata);
    return cities;
  }
}