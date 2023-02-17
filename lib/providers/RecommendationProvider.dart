import 'package:get/get.dart';

import '../models/RecommendedCities.dart';

class RecommendationProvider extends GetxController {
  List<City>? _recommendedCities;
  set recommendedCities(value) {
    _recommendedCities = value;
    update();
  }

  List<City>? get recommendedCities => _recommendedCities;
}
