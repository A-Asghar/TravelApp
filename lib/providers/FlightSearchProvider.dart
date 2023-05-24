import 'package:flutter/material.dart';
import 'package:fyp/models/Destination.dart';

import '../Constants.dart';
import '../models/Flight.dart';

class FlightSearchProvider extends ChangeNotifier {
  Destination _from = Destination(city: '', iata: '');
  Destination get from => _from;
  set from(Destination f) {
    _from = Destination(city: f.city, iata: f.iata);
    notifyListeners();
  }

  Destination _to = Destination(city: '', iata: '');
  Destination get to => _to;
  set to(Destination t) {
    _to = Destination(city: t.city, iata: t.iata);
    notifyListeners();
  }

  String _departDate = Constants.convertDate(DateTime.now());
  String get departDate => _departDate;
  set departDate(departDate) {
    _departDate = departDate;
    notifyListeners();
  }

  String _returnDate = Constants.convertDate(DateTime.now());
  String get returnDate => _returnDate;
  set returnDate(returnDate) {
    _returnDate = returnDate;
    notifyListeners();
  }

  int _adults = 1;
  int get adults => _adults;
  set adults(adults) {
    _adults = adults;
    notifyListeners();
  }

  List<Flight> _flights = [];
  List<Flight> get flights => _flights;
  set flights(f) {
    _flights = f;
    notifyListeners();
  }

  clearFlights() {
    _flights = [];
    _to = Destination(city: '', iata: '');
    notifyListeners();
  }

  Map<String, dynamic>? _dictionary;
  get dictionary => _dictionary;
  set dictionary(d) {
    _dictionary = d;
    notifyListeners();
  }

  int? _count;
  int? get count => _count;
  set count(count) {
    _count = count;
    notifyListeners();
  }
}
