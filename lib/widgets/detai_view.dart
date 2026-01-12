import 'package:flutter/material.dart';
import 'package:weather_project/model/weather_model.dart';
import 'package:weather_project/utilities/forecast_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Виджет отображения детальной информации о погоде: давление, влажность, ветер
// ignore: must_be_immutable
class DetailView extends StatelessWidget {
  AsyncSnapshot<WeatherModel> snapshot;
  // Конструктор виджета с обязательным параметром snapshot
  DetailView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    // Получение списка прогнозов погоды
    var forecastList = snapshot.data!.list;
    // Давление в паскалях преобразуется в мм рт. ст. (умножение на коэффициент)
    var pressure = forecastList[0].main.pressure * 0.750062;
    // Влажность воздуха в процентах
    var humidity = forecastList[0].main.humidity;
    // Скорость ветра в м/с
    var wind = forecastList[0].wind.speed;
    // Возвращает контейнер с горизонтальным рядом (Row) из трёх элементов
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Отображение давления с иконкой термометра (условно — для давления)
          Util.getItem(FontAwesomeIcons.thermometer, pressure.round(), 'mm Hg'),
          // Отображение влажности с иконкой дождя
          Util.getItem(FontAwesomeIcons.cloudRain, humidity, '%'),
          // Отображение скорости ветра с иконкой ветра
          Util.getItem(FontAwesomeIcons.wind, wind.toInt(), 'м/с'),
        ],
      ),
    );
  }
}
