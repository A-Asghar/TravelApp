import 'package:flutter/material.dart';
import 'package:fyp/models/Detail.dart';
import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/models/PropertyUnits.dart';
import 'package:fyp/models/Review.dart';

class HomeProvider extends ChangeNotifier {
  List<PropertySearchListing> _hotels = [];
  List<PropertySearchListing> get hotels => _hotels;
  set hotels(h) {
    _hotels = h;
    notifyListeners();
  }

  List<String> _city = [];
  List<String> get city => _city;
  set city(c) {
    _city = c;
    notifyListeners();
  }

  List<Unit> _hotelRooms = [];
  List<Unit> get hotelRooms => _hotelRooms;
  set hotelRooms(hr) {
    _hotelRooms = hr;
    notifyListeners();
  }

  List<ReviewElement> _hotelReviews = [];
  List<ReviewElement> get hotelReviews => _hotelReviews;
  set hotelReviews(hr) {
    _hotelReviews = hr;
    notifyListeners();
  }

  String _address = '';
  String get address => _address;
  set address(a) {
    _address = a;
    notifyListeners();
  }

  List<ImageImage?> _hotelImages = [];
  List<ImageImage?> get hotelImages => _hotelImages;
  set hotelImages(hi) {
    _hotelImages = hi;
    notifyListeners();
  }

  Coordinates _coordinates = Coordinates(latitude: 0.0, longitude: 0.0);
  Coordinates get coordinates => _coordinates;
  set coordinates(c) {
    _coordinates = c;
    notifyListeners();
  }

  String _description = '';
  String get description => _description;
  set description(a) {
    _description = a;
    notifyListeners();
  }

  List<TopAmenitiesItem>? _amenities = [];
  List<TopAmenitiesItem>? get amenities => _amenities;
  set amenities(hi) {
    _amenities = hi;
    notifyListeners();
  }

  String? _mapImage = "";
  String? get mapImage => _mapImage;
  set mapImage(img) {
    _mapImage = img;
    notifyListeners();
  }

  clearHotelDetail() {
    _hotelRooms = [];
    _hotelReviews = [];
    _amenities = [];
    _coordinates = Coordinates(latitude: 0.0, longitude: 0.0);
    _address = '';
    _description = '';
    notifyListeners();
  }
}
