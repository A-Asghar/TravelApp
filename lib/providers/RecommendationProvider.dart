import 'package:flutter/foundation.dart';

import '../models/RecommendedCities.dart';

class RecommendationProvider extends ChangeNotifier {
  List<City>? _recommendedCities;
  set recommendedCities(value) {
    _recommendedCities = value;
    notifyListeners();
  }

  List<City>? get recommendedCities => _recommendedCities;
}
