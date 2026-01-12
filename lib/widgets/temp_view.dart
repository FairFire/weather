import 'package:flutter/material.dart';
import 'package:weather_project/model/weather_model.dart';

// Виджет отображения текущей температуры и погодных условий
// ignore: must_be_immutable
class TempView extends StatelessWidget {
  AsyncSnapshot<WeatherModel> snapshot;
  // Конструктор виджета с обязательным параметром snapshot
  TempView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;
    // Получение URL иконки погоды (например, солнечно, облачно и т.д.)
    var icon = forecastList[0].getIconUrl();
    // Текущая температура, округлённая до целого числа
    var temp = forecastList[0].main.temp.toStringAsFixed(0);
    // Описание погоды (например, "облачно", "дождь") — в верхнем регистре
    var description = forecastList[0].weather[0].description.toUpperCase();
    // Возвращает контейнер с горизонтальным рядом (Row), отображающим иконку и температуру
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(icon, scale: 0.4, color: Colors.black87),
          SizedBox(width: 20),
          Column(
            children: [
              // Отображение температуры
              Text(
                '$temp °C',
                style: TextStyle(fontSize: 54, color: Colors.black87),
              ),
              // Отображение описания погоды (например, "ОБЛАЧНО")
              Text('$description', style: TextStyle(fontSize: 20)),
            ],
          ),
        ],
      ),
    );
  }
}
