import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/Destination.dart';
import 'package:fyp/models/Detail.dart';
import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/models/PropertyUnits.dart';
import 'package:fyp/models/Review.dart';

class HotelSearchProvider extends ChangeNotifier {
  Destination _to = Destination(city: '', iata: '');
  Destination get to => _to;
  set to(Destination t) {
    _to = Destination(city: t.city, iata: t.iata);
    notifyListeners();
  }

  String _checkIn = Constants.convertDate(DateTime.now());
  String get checkIn => _checkIn;
  set checkIn(checkIn) {
    _checkIn = checkIn;
    notifyListeners();
  }

  String _checkOut = Constants.convertDate(DateTime.now());
  String get checkOut => _checkOut;
  set checkOut(checkOut) {
    _checkOut = checkOut;
    notifyListeners();
  }

  int _adults = 1;
  int get adults => _adults;
  set adults(adults) {
    _adults = adults;
    notifyListeners();
  }

  List<PropertySearchListing> _hotels = [];
  List<PropertySearchListing> get hotels => _hotels;
  set hotels(h) {
    _hotels = h;
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

  String _regionId = '';
  String get regionId => _regionId;
  set regionId(r) {
    _regionId = r;
    notifyListeners();
  }

  String _address = '';
  String get address => _address;
  set address(a) {
    _address = a;
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

  clearHotels() {
    _hotels = [];
    notifyListeners();
  }

  clearHotelDetail() {
    _hotelRooms = [];
    _hotelReviews = [];
    _hotelImages = [];
    notifyListeners();
  }

  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  set errorMessage(e) {
    _errorMessage = e;
    notifyListeners();
  }
}
