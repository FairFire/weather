import 'dart:convert';
import 'dart:developer';

import 'package:weather_project/model/weather_model.dart';
import 'package:weather_project/utilities/constans.dart';
import 'package:http/http.dart' as http;
import 'package:weather_project/utilities/location.dart';

class WeatherApi {
  Future<WeatherModel> fetchWeatherForecastWithCity({
    String? cityName,
    bool isCity = false,
  }) async {
    Location location = Location();
    await location.getCurrentLocation();
    Map<String, String>? parameters;

    if (isCity == true) {
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'q': cityName ?? 'Minsk',
      };
      parameters = queryParameters;
    } else {
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
      };
      parameters = queryParameters;
    }

    var uri = Uri.https(
      Constants.WEATHER_BASE_URL_DOMAIN,
      Constants.WEATHER_FORECAST_PATH,
      parameters,
    );

    log('request: ${uri.toString()}');

    var response = await http.get(uri);

    print('response: ${response?.body}');

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      if (jsonBody['cod'] != '200') {
        throw Exception(jsonBody['message'].toString());
      }
      return WeatherModel.fromJson(jsonBody);
    } else {
      throw Exception('HTTP Error: ${response.statusCode}');
    }
  }
}
