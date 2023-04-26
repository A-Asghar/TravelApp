import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Constants.dart';
import '../Providers/AccessTokenProvider.dart';
import '../providers/UserProvider.dart';
import '../repository/AccessTokenRepository.dart';

class RecommendationNetwork {
  getRecommendedCities({required List cityIatas}) async {
    final AccessTokenProvider controller = Get.put(AccessTokenProvider());
    AccessTokenRepository accessTokenRepository = AccessTokenRepository();

    String cityCodes = cityIatas.join(",");
    // curl -X GET "https://test.api.amadeus.com/v1/reference-data/recommended-locations?cityCodes=KHI%2CPAR%2CDXB" -H  "accept: application/vnd.amadeus+json" -H  "Authorization: Bearer 2VvzTmLfQUrsTSmNvRXT36Oyxf8B"
    final url = Uri.parse(
        'https://${Constants.flight_uri}${Constants.city_similarity}?cityCodes=$cityCodes');

    var response = await http.get(
      url,
      headers: {
        "Authorization": 'Bearer ${controller.accessToken?.accessToken}',
        "accept": 'application/vnd.amadeus+json',
      },
    );

    if (response.statusCode == 401) {
      // print('Network Error: ');

      await accessTokenRepository.getAccessToken(getNew: true);

      response = await http.get(
        url,
        headers: {
          "Authorization": 'Bearer ${controller.accessToken?.accessToken}',
          "accept": 'application/vnd.amadeus+json',
        },
      );
    }

    // print(response.body);
    return response.body;
  }

  updateUserSearchedCities({required String iata}) async {
    final UserProvider controller = Get.put(UserProvider());
    controller.user!.searchedCities.add(iata);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'searchedCities': controller.user!.searchedCities});
  }
}
