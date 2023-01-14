import 'dart:convert';

import 'package:get/get.dart';

import '../Providers/AccessTokenProvider.dart';
import '../models/AccessToken.dart';
import '../network/FlightNetwork.dart';

class AccessTokenRepository {
  FlightNetwork network = FlightNetwork();

  getAccessToken({required bool getNew}) async {
    final controller = Get.put(AccessTokenProvider());
    AccessToken? accessToken;

    if (controller.accessToken == null || getNew) {
      print('Getting New AccessToken . . .');

      var response = await network.getAccessToken();

      accessToken = AccessToken.fromJson(json.decode(response.body));
      controller.accessToken = accessToken;
      print(controller.accessToken?.accessToken);
    } else {
      // print('AccessToken already Exists: ${controller.accessToken?.accessToken}');
      accessToken = controller.accessToken;
    }

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    // print(s.accessToken);
    return accessToken;
  }
}
