import 'package:flutter/material.dart';
import 'package:weather_project/model/weather_model.dart';
import 'package:weather_project/utilities/forecast_util.dart';

// Виджет отображения названия города и страны, а также текущей даты
class CityView extends StatelessWidget {
  // Снимок (snapshot) асинхронных данных о погоде
  final AsyncSnapshot<WeatherModel> snapshot;
  // Конструктор с обязательным параметром snapshot
  const CityView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var city = snapshot
        .data!
        .city!
        .name; // Извлечение названия города из данных погоды
    var country = snapshot
        .data!
        .city!
        .country; // Извлечение названия страны (сокращенное)
    // Преобразование временной метки (в секундах) в объект DateTime (в миллисекундах)
    var formattedDate = DateTime.fromMillisecondsSinceEpoch(
      snapshot.data!.list[0].dt * 1000,
    );
    // Возвращает контейнер с колонкой, содержащей название города и дату
    return Container(
      child: Column(
        children: [
          // Отображение названия города и страны
          Text(
            '$city, $country',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black87,
            ),
          ),
          // Отображение отформатированной даты с помощью утилиты
          Text(
            '${Util.getFormattedDate(formattedDate)}',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
