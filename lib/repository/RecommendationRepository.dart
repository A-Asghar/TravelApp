import 'dart:convert';

import 'package:fyp/models/RecommendedCities.dart';
import 'package:get/get.dart';

import '../network/RecommendationNetwork.dart';
import '../providers/RecommendationProvider.dart';

class RecommendationRepository {
  getRecommendedCities({required List cityIatas}) async {
    var response = await RecommendationNetwork()
        .getRecommendedCities(cityIatas: cityIatas);

    response = jsonDecode(response);
    Cities cities = Cities.fromJson(response);

    final RecommendationProvider controller = Get.put(RecommendationProvider());
    controller.recommendedCities = cities.data!;
  }

  updateUserSearchedCities({required String iata}) async {
    await RecommendationNetwork().updateUserSearchedCities(iata: iata);
  }
}
