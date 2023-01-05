import 'dart:convert';

import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/models/PropertyUnits.dart';
import 'package:fyp/models/Review.dart';

import '../models/Detail.dart';
import '../network/HotelNetwork.dart';

class HotelRepository {
  // https://rapidapi.com/apidojo/api/hotels4
  HotelNetwork network = HotelNetwork();

  hotelSearch({required String city}) async {
    // Gets Hotels List
    // TODO: implement propertiesList params into hotelSearch

    var response = await network.hotelSearch(city);

    response = jsonDecode(response);

    var regionId = response['sr'][0]['gaiaId'];
    print('regionId : $regionId');

    customHotelDate checkInDate =
        customHotelDate(day: 10, month: 1, year: 2023);
    customHotelDate checkOutDate =
        customHotelDate(day: 15, month: 1, year: 2023);

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

    // for (int i = 0; i < 6; i++) {
    //   print(hotels[i].id! + ' ' + hotels[i].name!);
    // }
  }

  getOffers(
      // {required String propertyId,
      // required String regionId,
      // required checkInDate,
      // required checkOutDate,
      // required adults}
      ) async {
    // Get List of Hotel Rooms

    // TODO: implement params into method
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

  detail() async {
    // TODO: implement params into method
    // TODO: return co-ordinates for google map
    // TODO: return images list
    // TODO: return address

    var response = await network.detail(propertyId: "4164");

    response = jsonDecode(response);

    Detail detail = Detail.fromJson(response);

    List<ImageImage?>? images = detail
        .data?.propertyInfo?.propertyGallery?.images
        ?.map((e) => e.image)
        .toList();

    String? address =
        detail.data?.propertyInfo?.summary?.location?.address?.addressLine;

    Coordinates? coordinates =
        detail.data?.propertyInfo?.summary?.location?.coordinates;

    // print('Hotel Images:');
    // images.forEach((i) {
    //   print(i!.url);
    // });
  }

  reviews() async {
    // TODO: implement params into method

    var response = await network.reviews(propertyId: "4164");

    response = jsonDecode(response);

    Review review = Review.fromJson(response);

    List<ReviewElement>? reviews =
        review.data!.propertyInfo!.reviewInfo!.reviews;

    return reviews;
    // reviews?.forEach((r) {
    //   print(r.text);
    // });
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
