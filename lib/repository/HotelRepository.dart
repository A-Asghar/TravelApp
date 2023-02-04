import 'dart:convert';

import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/models/PropertyUnits.dart';
import 'package:fyp/models/Review.dart';
import 'package:fyp/screens/hotel_details.dart';

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

    String errorMessage = '';
    response2 = jsonDecode(response2);
    if (response2.containsKey('errors')) {
      // print('HotelRepository response2.containsKey(errors): ${response2.containsKey('errors')}');
      errorMessage = response2['errors'][0]['extensions']['event']['message'];
    }
    // print('response2.runtimeType: ${response2.runtimeType}');
    // print('response2.containsKey: ${response2.containsKey('errors')}');
    // print('response2.errorMessage: ${response2['errors'][0]['extensions']['event']['message']}');
    var data;
    List<PropertySearchListing> hotels = [];

    try {
      data = response2['data']['propertySearch']['propertySearchListings'];
      data.forEach((d) {
        if (d['__typename'] == 'Property') {
          hotels.add(PropertySearchListing.fromJson(d));
        }
      });
    } catch (e) {}

    // print('HotelRepository errorMessage: $errorMessage}');
    // for (int i = 0; i < 6; i++) {
    //   print(hotels[i].id! + ' ' + hotels[i].name!);
    // }
    // print("Hotels: ${hotels.length}");
    // print("Hotels: ${regionId}");
    return [hotels, regionId, errorMessage];
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

  reviews({required String propertyId, startingIndex = 0}) async {
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

  getHotels() async {
    List response = await network.getPropertyListings();
    List<PropertySearchListing> hotels = [];
    List<String> city = [];
    for (var value in response) {
      hotels.add(value['property']);
      city.add(value['city']);
    }
    return [hotels, city];
  }

  getHotelRooms({required propertyId, required regionId}) async {
    List response =
        await network.getHotelRooms(propertyId: propertyId, regionId: regionId);
    print("from repo: ${response[0]}");
    List<Unit> hotelRooms = [];
    for (var value in response) {
      hotelRooms.add(value);
      print(value.description);
    }
    print("from repo: ${hotelRooms[0]}");
    return hotelRooms;
  }

  getHotelReviews({required propertyId}) async {
    var response = await network.getHotelReviews(propertyId: propertyId);
    print("from repo: ${response[0]}");
    List<ReviewElement> reviews = [];
    for (var value in response) {
      reviews.add(value);
      print(value.id);
    }
    return reviews;
  }

  getHotelDetails({required propertyId}) async {
    List response = await network.getHotelDetails(propertyId: propertyId);
    List<ImageImage?> hotelImages = response[0];
    List<TopAmenitiesItem> amenities = response[1];
    Coordinates coordinates = response[2];
    String description = response[3];
    String address = response[4];

    return [hotelImages, amenities, coordinates, description, address];
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
