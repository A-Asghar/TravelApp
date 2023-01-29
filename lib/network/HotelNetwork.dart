import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Constants.dart';

class HotelNetwork {
  hotelSearch(String city) async {
    // Gets regionId to pass to propertiesList() method
    final url = Uri.parse(
        '${Constants.hotels}${Constants.locations_v3_search}?q=$city&locale=en_US&langid=1033&siteid=300000001');

    var response = await http.get(
      url,
      headers: {
        "X-RapidAPI-Host": 'hotels4.p.rapidapi.com',
        "X-RapidAPI-Key": Constants.rapidAPIKey,
      },
    );
    print('Network hotelSearch().statusCode: ${response.statusCode}');
    return response.body;
  }

  propertiesList(
      {required regionId,
      required checkInDate,
      required checkOutDate,
      required adults}) async {
    // Returns Hotel List for the regionId
    final url = Uri.parse('${Constants.hotels}${Constants.properties_v2_list}');

    final Map<String, dynamic> body = {
      "currency": "USD",
      "eapid": 1,
      "locale": "en_US",
      "siteId": 300000001,
      "destination": {"regionId": regionId.toString()},
      "checkInDate": {
        "day": checkInDate.day,
        "month": checkInDate.month,
        "year": checkInDate.year
      },
      "checkOutDate": {
        "day": checkOutDate.day,
        "month": checkOutDate.month,
        "year": checkOutDate.year
      },
      "rooms": [
        {"adults": adults}
      ],
    };

    final response = await http.post(
      url,
      headers: {
        "X-RapidAPI-Host": 'hotels4.p.rapidapi.com',
        "X-RapidAPI-Key": Constants.rapidAPIKey,
        "content-type": "application/json"
      },
      body: json.encode(body),
    );

    // print('Network propertiesList() response.request.url:');
    // print(response.request?.url);

    print('Network propertiesList().statusCode: ${response.statusCode}');
    print('Network propertiesList().body: ${response.body}');

    return response.body;
  }

  getOffers(
      {required String propertyId,
      required String regionId,
      required checkInDate,
      required checkOutDate,
      required adults}) async {
    // Gets Hotel Rooms

    final url =
        Uri.parse('${Constants.hotels}${Constants.properties_v2_get_offers}');

    Map<String, dynamic> body = {
      "currency": "USD",
      "eapid": 1,
      "locale": "en_US",
      "siteId": 300000001,
      "propertyId": propertyId,
      "checkInDate": {
        "day": checkInDate.day,
        "month": checkInDate.month,
        "year": checkInDate.year
      },
      "checkOutDate": {
        "day": checkOutDate.day,
        "month": checkOutDate.month,
        "year": checkOutDate.year
      },
        "destination": {"regionId": regionId},
      "rooms": [
        {"adults": 2}
      ]
    };

    final response = await http.post(
      url,
      headers: {
        "X-RapidAPI-Host": 'hotels4.p.rapidapi.com',
        "X-RapidAPI-Key": Constants.rapidAPIKey,
        "content-type": "application/json"
      },
      body: json.encode(body),
    );

    print('network.getOffers().statusCode: ${response.statusCode}');

    return response.body;
  }

  detail({required String propertyId}) async {
    final url =
        Uri.parse('${Constants.hotels}${Constants.properties_v2_detail}');

    Map<String, dynamic> body = {
      "currency": "USD",
      "eapid": 1,
      "locale": "en_US",
      "siteId": 300000001,
      "propertyId": propertyId
    };

    final response = await http.post(
      url,
      headers: {
        "X-RapidAPI-Host": 'hotels4.p.rapidapi.com',
        "X-RapidAPI-Key": Constants.rapidAPIKey,
        "content-type": "application/json"
      },
      body: json.encode(body),
    );

    print('network.detail().statusCode: ${response.statusCode}');

    return response.body;
  }

  reviews({required String propertyId, startingIndex}) async {
    final url = Uri.parse('${Constants.hotels}${Constants.reviews_v3_list}');

    Map<String, dynamic> body = {
      "currency": "USD",
      "eapid": 1,
      "locale": "en_US",
      "siteId": 300000001,
      "propertyId": propertyId,
      "size": 10,
      "startingIndex": startingIndex
    };

    final response = await http.post(
      url,
      headers: {
        "X-RapidAPI-Host": 'hotels4.p.rapidapi.com',
        "X-RapidAPI-Key": Constants.rapidAPIKey,
        "content-type": "application/json"
      },
      body: json.encode(body),
    );

    print('network.reviews().statusCode: ${response.statusCode}');

    return response.body;
  }
}
