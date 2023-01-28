import 'dart:convert';

import 'package:fyp/network/WeatherNetwork.dart';

import '../models/Weather.dart';

class WeatherRepository {
  WeatherNetwork network = WeatherNetwork();

  getWeather({required String q, required String dt}) async {
    var response = await network.getWeather(q: q, dt: dt);

    response = jsonDecode(response);
    Weather weather = Weather.fromJson(response);

    return weather;
  }
}
