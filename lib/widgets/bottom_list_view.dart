// Виджет списка с семидневным прогнозом погоды.
// Отображает заголовок и горизонтальный список карточек прогноза на 7 дней.

import 'package:flutter/material.dart';
import 'package:weather_project/model/weather_model.dart';
import 'package:weather_project/widgets/forecast_card.dart';

class BottomListView extends StatelessWidget {
  // Объект AsyncSnapshot, содержащий данные о погоде (включая прогноз на 7 дней)
  final AsyncSnapshot<WeatherModel> snapshot;
  // Конструктор с обязательным параметром snapshot
  const BottomListView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Заголовок секции прогноза
        Text(
          '7 Day Weather Forecast',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Контейнер с горизонтальным списком карточек прогноза
        Container(
          height: 140,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: ListView.separated(
            // Разделитель между элементами
            separatorBuilder: (context, index) => SizedBox(width: 8),
            // Количество элементов — длина списка прогнозов
            itemCount: snapshot.data!.list.length,
            // Направление прокрутки — горизонтальное
            scrollDirection: Axis.horizontal,
            // Построение каждой карточки прогноза с помощью функции forecastCard
            itemBuilder: (context, index) => Container(
              width: MediaQuery.of(context).size.width / 2.7,
              height: 160,
              color: Colors.black87,
              child: forecastCard(snapshot, index),
            ),
          ),
        ),
      ],
    );
  }
}
