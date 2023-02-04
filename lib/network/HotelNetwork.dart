import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/Detail.dart';
import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/models/PropertyUnits.dart';
import 'package:fyp/models/Review.dart';
import 'package:http/http.dart' as http;

class HotelNetwork {
  hotelsAPIKey() {
    return Constants
        .rapidAPIKey[Random().nextInt(Constants.rapidAPIKey.length)];
  }

  hotelSearch(String city) async {
    // Gets regionId to pass to propertiesList() method
    final url = Uri.parse(
        '${Constants.hotels}${Constants.locations_v3_search}?q=$city&locale=en_US&langid=1033&siteid=300000001');

    var response = await http.get(
      url,
      headers: {
        "X-RapidAPI-Host": 'hotels4.p.rapidapi.com',
        "X-RapidAPI-Key": hotelsAPIKey(),
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
        "X-RapidAPI-Key": hotelsAPIKey(),
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
        {"adults": adults}
      ]
    };

    final response = await http.post(
      url,
      headers: {
        "X-RapidAPI-Host": 'hotels4.p.rapidapi.com',
        "X-RapidAPI-Key": hotelsAPIKey(),
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
        "X-RapidAPI-Key": hotelsAPIKey(),
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
        "X-RapidAPI-Key": hotelsAPIKey(),
        "content-type": "application/json"
      },
      body: json.encode(body),
    );

    print('network.reviews().statusCode: ${response.statusCode}');

    return response.body;
  }

  getHotels() async {
    CollectionReference hotels =
        FirebaseFirestore.instance.collection('propertySearchListing');
    QuerySnapshot snapshot = await hotels.get();
    List<dynamic> allHotels = snapshot.docs.map((doc) => doc.data()).toList();
    print("hotel: ${allHotels[0]}");
    return allHotels;
  }

  Future<List<Map<String, dynamic>>> getPropertyListings() async {
    List<Map<String, dynamic>> listings = [];

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("propertySearchListing")
        .get();

    snapshot.docs.forEach((document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      data["property"] = PropertySearchListing.fromJson(data["property"]);
      listings.add(data);
    });

    return listings;
  }

  Future<List<Unit>> getHotelRooms(
      {required propertyId, required regionId}) async {
    List<Unit> hotelRooms = [];

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('propertyUnits')
        .where('propertyId', isEqualTo: propertyId)
        .where('regionId', isEqualTo: regionId)
        .get();

    snapshot.docs.forEach((document) {
      print("before mapping: $document");
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      for (var room in data['hotelRooms']) {
        room = Unit.fromJson(room);
        hotelRooms.add(room);
      }
      // print("after mapping: ${data['hotelRooms']}");
    });
    print(hotelRooms[0].description);
    return hotelRooms;
  }

  Future<List<ReviewElement>> getHotelReviews({required propertyId}) async {
    List<ReviewElement> hotelReviews = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('reviews')
        .where('propertyId', isEqualTo: propertyId)
        .get();

    snapshot.docs.forEach((document) {
      print("before mapping: $document");
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      for (var review in data['hotelReviews']) {
        review = ReviewElement.fromJson(review);
        hotelReviews.add(review);
      }
    });
    print(hotelReviews[0].id);
    return hotelReviews;
  }

  Future<List<dynamic>> getHotelDetails({required propertyId}) async {
    List<ImageImage?> hotelImages = [];
    List<TopAmenitiesItem> amenities = [];
    Coordinates coordinates = Coordinates(latitude: 0.0, longitude: 0.0);
    String description = '';
    String address = '';

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('propertyDetails')
        .where('propertyId', isEqualTo: propertyId)
        .get();

    snapshot.docs.forEach((document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      for (var image in data['hotelImages']) {
        image = ImageImage.fromJson(image);
        hotelImages.add(image);
      }
      for (var amenity in data['amenities']) {
        amenity = TopAmenitiesItem.fromJson(amenity);
        amenities.add(amenity);
      }
      coordinates = Coordinates.fromJson(data['coordinates']);
      description = data['description'];
      address = data['address'];
    });

    return [hotelImages, amenities, coordinates, description, address];
  }
}
