import 'package:flutter/material.dart';
import 'package:weather_project/utilities/forecast_util.dart';

// Функция, возвращающая виджет карточки прогноза погоды на определённый момент времени
// Принимает снимок данных (snapshot) и индекс элемента в списке прогнозов
Widget forecastCard(AsyncSnapshot snapshot, int index) {
  var forecastList = snapshot.data!.list;
  // Преобразование временной метки (в секундах) в объект DateTime (в миллисекундах)
  DateTime date = DateTime.fromMillisecondsSinceEpoch(
    forecastList[index].dt * 1000,
  );
  // Получение полной отформатированной даты (например, "Пн, 10 июня")
  var fullDate = Util.getFormattedDate(date);
  // Извлечение дня недели (например, "Пн") из строки даты
  var dayOfWeek = fullDate.split(',')[0];
  // Минимальная температура на этот период (округлённая до целого числа)
  var temp_min = forecastList[index].main.tempMin.toStringAsFixed(0);
  // Получение URL иконки погоды (например, облачно, солнечно и т.д.)
  var icon = forecastList[index].getIconUrl();
  // Получение отформатированного времени (часы:минуты)
  var timeDate = Util.getFormattedDateTime(date);
  // Возвращает колонку — карточку с информацией о прогнозе погоды
  return Column(
    // Выравнивание по вертикали: в начале контейнера
    mainAxisAlignment: MainAxisAlignment.start,
    // Выравнивание по горизонтали: по левому краю
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Центрированное отображение дня недели
      Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            dayOfWeek,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
      // Центрированное отображение времени (часы:минуты)
      Center(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(1.0),
          child: Text('$timeDate', style: TextStyle(color: Colors.white)),
        ),
      ),
      // Строка с температурой и иконкой погоды
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  // Отображение минимальной температуры
                  Padding(
                    padding: const EdgeInsetsGeometry.all(4),
                    child: Text(
                      '$temp_min *C',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  // Отображение иконки погоды из сети
                  Image.network(icon, scale: 1.2, color: Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
