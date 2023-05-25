import 'package:flutter/material.dart';
import 'package:travel_agency/models/Destination.dart';

import '../models/package.dart';

class PackageProvider extends ChangeNotifier {
  List<Package> _allPackages = [];
  List<Package> _agencyPackages = [];
  Destination _to = Destination(city: '', iata: '');
  Destination get to => _to;
  set to(Destination t) {
    _to = Destination(city: t.city, iata: t.iata);
    notifyListeners();
  }

  List<Package> get allPackages => _allPackages;
  set allPackages(List<Package> allPackages) {
    _allPackages = allPackages;
    notifyListeners();
  }

  List<Package> get agencyPackages => _agencyPackages;
  set agencyPackages(List<Package> agencyPackages) {
    _agencyPackages = agencyPackages;
    notifyListeners();
  }

  clearDestination() {
    to = Destination(city: '', iata: '');
    notifyListeners();
  }
}
