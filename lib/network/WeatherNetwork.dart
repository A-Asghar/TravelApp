import 'package:http/http.dart' as http;

import '../Constants.dart';

class WeatherNetwork {
  getWeather({required String q, required String dt}) async {
    // q = City Name
    // dt = date ; Format 2023-02-26 ; YYYY-MM-DD
    final url = Uri.parse(
        '${Constants.weather_base_uri}future.json?key=${Constants.weatherAPIKey}&q=$q&dt=$dt');

    var response = await http.get(url);

    print('WeatherNetwork.getWeather.response.statusCode: ${response.statusCode}');
    // print('WeatherNetwork.getWeather.response.body: ${response.body}' );

    return response.body;
  }
}
