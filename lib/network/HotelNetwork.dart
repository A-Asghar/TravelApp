import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Constants.dart';

class HotelNetwork{
  hotelSearch(String city) async {
    // Gets regionId to pass to propertiesList() method
    final url = Uri.parse(
        '${Constants.hotels}${Constants.v3search}?q=$city&locale=en_US&langid=1033&siteid=300000001');

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
    final url = Uri.parse('${Constants.hotels}${Constants.v2list}');

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

    return response.body;
  }

  getOffers(
      {required String propertyId,
        required String regionId,
        required checkInDate,
        required checkOutDate,
        required adults}) async{
    // Gets Hotel Rooms

    final url = Uri.parse('${Constants.hotels}${Constants.v2getoffers}');

    Map<String, dynamic> body = {
      "currency": "USD",
      "eapid": 1,
      "locale": "en_US",
      "siteId": 300000001,
      "propertyId": propertyId,
      "checkInDate": {"day": checkInDate.day, "month": checkInDate.month, "year": checkInDate.year},
      "checkOutDate": {"day": checkOutDate.day, "month": checkOutDate.month, "year": checkOutDate.year},
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
}