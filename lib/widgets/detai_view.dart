import 'package:flutter/material.dart';
import 'package:weather_project/model/weather_model.dart';
import 'package:weather_project/utilities/forecast_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class DetailView extends StatelessWidget {
  AsyncSnapshot<WeatherModel> snapshot;
  DetailView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;
    var pressure = forecastList[0].main.pressure * 0.750062;
    var humidity = forecastList[0].main.humidity;
    var wind = forecastList[0].wind.speed;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Util.getItem(FontAwesomeIcons.thermometer, pressure.round(), 'mm Hg'),
          Util.getItem(FontAwesomeIcons.cloudRain, humidity, '%'),
          Util.getItem(FontAwesomeIcons.wind, wind.toInt(), 'м/с'),
        ],
      ),
    );
  }
}
