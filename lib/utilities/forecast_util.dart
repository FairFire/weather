import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Утилитный класс для работы с датами, форматированием и построением UI-элементов
// в приложении прогноза погоды.

class Util {
  // Форматирует дату в понятную строку вида: "Пн, Янв, 1, 2024"
  // Принимает объект DateTime, возвращает отформатированную строку.
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('E, MMM, d, y').format(dateTime);
  }

  // Форматирует дату и время в строку вида: "14:30, 1 - Янв"
  // Используется для отображения времени измерения или прогноза.
  static String getFormattedDateTime(DateTime dateTime) {
    return DateFormat('HH:mm, d - MMM').format(dateTime);
  }

  // Создаёт столбец с иконкой, значением и единицами измерения
  // Используется, например, для отображения влажности, давления и т.п.
  // Параметры:
  // - iconData: иконка (например, иконка капли для влажности)
  // - value: числовое значение
  // - units: строка с единицами измерения (например, "%", "м/с")
  // Возвращает виджет Column, готовый к использованию в интерфейсе.
  static getItem(IconData iconData, int value, String units) {
    return Column(
      children: [
        Icon(iconData, color: Colors.black87, size: 28),
        SizedBox(height: 10),
        Text('$value', style: TextStyle(fontSize: 20, color: Colors.black87)),
        SizedBox(height: 10),
        Text('$units', style: TextStyle(fontSize: 15, color: Colors.black87)),
      ],
    );
  }
}
