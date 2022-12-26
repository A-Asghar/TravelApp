import 'dart:convert';

import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/models/PropertyUnits.dart';

import '../network/HotelNetwork.dart';

class HotelRepository {

  // TODO: v2/detail for images, address
  // TODO: Reviews

  // https://rapidapi.com/apidojo/api/hotels4
  HotelNetwork network = HotelNetwork();

  hotelSearch({required String city}) async {
    // Gets Hotels List
    // TODO: implement propertiesList params into hotelSearch

    var response = await network.hotelSearch(city);

    response = jsonDecode(response);

    var regionId = response['sr'][0]['gaiaId'];
    print('regionId : $regionId');

    customHotelDate checkInDate = customHotelDate(day: 10, month: 1, year: 2023);
    customHotelDate checkOutDate = customHotelDate(day: 15, month: 1, year: 2023);

    var response2 = await network.propertiesList(
      regionId: regionId,
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
      adults: 2,
    );

    response2 = jsonDecode(response2);
    var data = response2['data']['propertySearch']['propertySearchListings'];

    List<PropertySearchListing> hotels = [];
    data.forEach((d) {
      if (d['__typename'] == 'Property') {
        hotels.add(PropertySearchListing.fromJson(d));
      }
    });

    for(int i = 0 ; i < 6 ; i++){
      print(hotels[i].id!+ ' ' + hotels[i].name!);
    }
  }

  getOffers(
      // {required String propertyId,
      // required String regionId,
      // required checkInDate,
      // required checkOutDate,
      // required adults}
      ) async {
    // Get List of Hotel Rooms
    customHotelDate checkInDate =
        customHotelDate(day: 10, month: 1, year: 2023);
    customHotelDate checkOutDate =
        customHotelDate(day: 15, month: 1, year: 2023);

    var response = await network.getOffers(
        propertyId: '522878',
        regionId: '1809',
        checkInDate: checkInDate,
        checkOutDate: checkOutDate,
        adults: 2);

    response = jsonDecode(response);

    var data = response['data']['propertyOffers'];
    PropertyUnits propertyUnits = PropertyUnits.fromJson(data);
    // propertyUnits.units?.forEach((e) {print(e.header!.text);});
    return propertyUnits.units;
  }
}

class customHotelDate {
  int day;
  int month;
  int year;

  customHotelDate({
    required this.day,
    required this.month,
    required this.year,
  });
}
