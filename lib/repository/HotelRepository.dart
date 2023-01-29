import 'dart:convert';

import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/models/PropertyUnits.dart';
import 'package:fyp/models/Review.dart';

import '../models/Detail.dart';
import '../network/HotelNetwork.dart';

class HotelRepository {
  // https://rapidapi.com/apidojo/api/hotels4
  HotelNetwork network = HotelNetwork();

  hotelSearch(
      {required String city,
      required DateTime checkIn,
      required DateTime checkOut,
      required int adults}) async {
    // Gets Hotels List
    // TODO: implement propertiesList params into hotelSearch

    var response = await network.hotelSearch(city);
    // print('from repo' + response);

    response = jsonDecode(response);

    var regionId = response['sr'][0]['gaiaId'];
    // print('regionId : $regionId');

    customHotelDate checkInDate = customHotelDate(
        day: checkIn.day, month: checkIn.month, year: checkIn.year);
    customHotelDate checkOutDate = customHotelDate(
        day: checkOut.day, month: checkOut.month, year: checkOut.year);

    var response2 = await network.propertiesList(
      regionId: regionId,
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
      adults: adults,
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
    // print("Hotels: ${hotels.length}");
    // print("Hotels: ${regionId}");
    return [hotels, regionId];
  }

  getOffers(
      {required String propertyId,
      required String regionId,
      required DateTime checkIn,
      required DateTime checkOut,
      required adults}) async {
    // Get List of Hotel Rooms

    // TODO: implement params into method
    customHotelDate checkInDate = customHotelDate(
        day: checkIn.day, month: checkIn.month, year: checkIn.year);
    customHotelDate checkOutDate = customHotelDate(
        day: checkOut.day, month: checkOut.month, year: checkOut.year);

    var response = await network.getOffers(
        propertyId: propertyId,
        regionId: regionId,
        checkInDate: checkInDate,
        checkOutDate: checkOutDate,
        adults: adults);

    response = jsonDecode(response);

    var data = response['data']['propertyOffers'];
    PropertyUnits propertyUnits = PropertyUnits.fromJson(data);
    // propertyUnits.units?.forEach((e) {print(e.header!.text);});
    // print("Hotel Rooms: ${propertyUnits.units}");
    return propertyUnits.units;
  }

  detail({required String propertyId}) async {
    // TODO: implement params into method OK
    // TODO: return co-ordinates for google map OK
    // TODO: return images list OK
    // TODO: return address OK

    var response = await network.detail(propertyId: propertyId);

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

    List<TopAmenitiesItem>? amenities = detail
        .data?.propertyInfo?.summary?.amenities?.topAmenities?.items
        ?.map((e) => TopAmenitiesItem(text: e.text, icon: e.icon))
        .toList();

    String? description = detail
        .data
        ?.propertyInfo
        ?.propertyContentSectionGroups
        ?.aboutThisProperty
        ?.sections![0]
        .bodySubSections![0]
        .elements![0]
        .items![0]
        .content
        ?.text;
    // print('Hotel Images:');
    // images.forEach((i) {
    //   print(i!.url);
    // });
    // print(
    //     "Hotel Images: ${images!.length}\n Hotel Address: ${address}, \n Coordinates: ${coordinates}");
    return [images, address, coordinates, amenities, description];
  }

  reviews({required String propertyId, startingIndex=0}) async {
    // TODO: implement params into method

    var response = await network.reviews(
        propertyId: propertyId, startingIndex: startingIndex);

    response = jsonDecode(response);

    Review review = Review.fromJson(response);

    List<ReviewElement>? reviews =
        review.data!.propertyInfo!.reviewInfo!.reviews;

    // print("Hotel reviews: ${reviews!.length}");
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
