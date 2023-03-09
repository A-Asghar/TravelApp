import 'dart:convert';

import 'package:fyp/models/RecommendedCities.dart';

import '../network/RecommendationNetwork.dart';

class RecommendationRepository {
  getRecommendedCities({required List cityIatas}) async {
    var response = await RecommendationNetwork()
        .getRecommendedCities(cityIatas: cityIatas);

    response = jsonDecode(response);
    Cities cities = Cities.fromJson(response);

    return cities.data;
  }

  // updateUserSearchedCities({required String iata}) async {
  //   await RecommendationNetwork().updateUserSearchedCities(iata: iata);
  // }
}
