import 'package:flutter/material.dart';


import '../models/Package.dart';


class PackageHomeProvider extends ChangeNotifier {
  List<Package> _packages = [];
  List<Package> get packages => _packages;
  set packages(List<Package> packages) {
    _packages = packages;
    notifyListeners();
  }
}
