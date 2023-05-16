import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  String _loadingUpdate = '';
  String get loadingUpdate => _loadingUpdate;
  set loadingUpdate(loadingUpdate) {
    _loadingUpdate = loadingUpdate;
    notifyListeners();
  }
  clearLocationUpdate() {
    _loadingUpdate = '';
    notifyListeners();
  }
}