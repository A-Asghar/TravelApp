import 'package:flutter/material.dart';
import 'package:fyp/models/Package.dart';

class PackageHomeProvider extends ChangeNotifier {
  List<Package> _packages = [];
  List<Package> get packages => _packages;
  set packages(p) {
    _packages = p;
    notifyListeners();
  }
}
