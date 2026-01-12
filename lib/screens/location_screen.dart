import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_project/api/weather_api.dart';
import 'package:weather_project/screens/weather_forecast_screen.dart';

/// Экран определения местоположения.
/// Автоматически получает данные о погоде по текущему местоположению
/// и переходит на экран прогноза погоды.

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  /// Асинхронный метод для получения данных о погоде.
  /// Вызывает API для получения прогноза погоды по текущему местоположению.
  void getLocationData() async {
    // Запрашиваем прогноз погоды через WeatherApi
    var weatherInfo = await WeatherApi().fetchWeatherForecastWithCity();
    print('Weather Info $weatherInfo');
    // Проверяем, успешно ли получены данные
    if (weatherInfo == null) {
      print('Weather Info was null $weatherInfo');
      return; // Если данные не пришли — выходим
    }

    // Переходим на экран отображения прогноза погоды
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          // Передаём полученные данные о погоде в следующий экран
          return WeatherForecastScreen(locationWeather: weatherInfo);
        },
      ),
    );
  }

  /// Вызывается при инициализации состояния экрана.
  /// Запускает получение данных о погоде сразу после загрузки экрана.
  ///
  @override
  void initState() {
    super.initState();
    getLocationData(); // Немедленно запрашиваем данные о погоде
  }

  /// Строит интерфейс экрана.
  /// Отображает анимацию загрузки во время получения данных.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Показываем анимированную иконку загрузки
        child: SpinKitDoubleBounce(
          color: Colors.black87, // Цвет анимации и размер
          size: 100,
        ),
      ),
    );
  }
}
