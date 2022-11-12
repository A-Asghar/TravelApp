import 'package:get/get.dart';

import '../models/AccessToken.dart';
class AccessTokenProvider extends GetxController{
  AccessToken? _accessToken;
  set accessToken(value) {
    _accessToken = value;
    update();
  }
  AccessToken? get accessToken => _accessToken;
}