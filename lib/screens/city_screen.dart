import 'package:flutter/material.dart';

/// Экран для ввода названия города.
/// Позволяет пользователю ввести название города и вернуть его в предыдущий экран.
class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  // Переменная для хранения введённого названия города
  String cityName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // Поле ввода для названия города
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  cursorColor: Colors.blueGrey.shade500, // Цвет курсора
                  style: TextStyle(color: Colors.white), // Стиль текста (белый)
                  decoration: InputDecoration(
                    hintText:
                        'Введите название города', // Подсказка внутри поля
                    hintStyle: TextStyle(color: Colors.white), // Цвет подсказки
                    filled: true, // Включение заливки поля
                    fillColor: Colors.black87, // Цвет фона поля ввода
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ), // Закруглённые углы
                      borderSide: BorderSide.none, // Убираем границу
                    ),
                    icon: Icon(
                      Icons.location_city, // Иконка города слева
                      color: Colors.black87,
                      size: 50,
                    ),
                  ),
                  // Обработка изменения текста
                  onChanged: (value) {
                    cityName = value; // Сохраняем введённый текст
                  },
                ),
              ),
            ),
            // Кнопка для подтверждения ввода
            Container(
              width: 200,
              height: 50,
              child: FloatingActionButton(
                backgroundColor: Colors.black87, // Цвет кнопки
                onPressed: () {
                  // Возвращаемся на предыдущий экран и передаём введённое название города
                  Navigator.pop(context, cityName);
                },
                child: Text(
                  'Получить!', // Текст на кнопке
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
