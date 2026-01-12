import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_project/api/weather_api.dart';
import 'package:weather_project/screens/weather_forecast_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  void getLocationData() async {
    var weatherInfo = await WeatherApi().fetchWeatherForecastWithCity();
    print('Weather Info $weatherInfo');
    if (weatherInfo == null) {
      print('Weather Info was null $weatherInfo');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WeatherForecastScreen(locationWeather: weatherInfo);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.black87, size: 100),
      ),
    );
  }
}
