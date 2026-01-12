import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_project/api/weather_api.dart';
import 'package:weather_project/model/weather_model.dart';
import 'package:weather_project/screens/city_screen.dart';
import 'package:weather_project/widgets/bottom_list_view.dart';
import 'package:weather_project/widgets/city_view.dart';
import 'package:weather_project/widgets/detai_view.dart';
import 'package:weather_project/widgets/temp_view.dart';

/// Экран отображения прогноза погоды.
/// Показывает текущую погоду и прогноз для выбранного местоположения.
/// Поддерживает обновление по геолокации и ввод города вручную.

class WeatherForecastScreen extends StatefulWidget {
  final locationWeather; // Данные о погоде, переданные с предыдущего экрана (например, с LocationScreen)

  WeatherForecastScreen({super.key, this.locationWeather});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  // Название города, введённое пользователем
  late String _cityName;
  // Асинхронный объект для получения данных о погоде
  late Future<WeatherModel> forecastObject;

  /// Вызывается при инициализации состояния экрана.
  /// Определяет, откуда брать данные о погоде:
  /// - Если есть переданные данные — можно использовать их (опционально)
  /// - По умолчанию запрашиваем погоду по текущей геолокации

  @override
  void initState() {
    super.initState();

    // Если данные о погоде переданы (например, с экрана локации)
    if (widget.locationWeather != null) {
      // Запрашиваем прогноз снова — лучше обновить данные при входе
      forecastObject = WeatherApi().fetchWeatherForecastWithCity();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Аппбар с навигацией и действиями
        backgroundColor: Colors.black87,
        title: Text(
          'openweathermap.org',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          // Кнопка "Мое местоположение"
          onPressed: () {
            // Обновляем данные, используя геолокацию
            setState(() {
              forecastObject = WeatherApi().fetchWeatherForecastWithCity();
            });
          },
          icon: Icon(Icons.my_location, color: Colors.white),
        ),
        actions: <Widget>[
          // Кнопка для ввода города вручную
          IconButton(
            onPressed: () async {
              // Переход на экран ввода города
              var tapName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CityScreen();
                  },
                ),
              );
              // Если пользователь ввёл название города
              if (tapName != null) {
                setState(() {
                  _cityName = tapName; // Сохраняем введённое название
                  forecastObject = WeatherApi().fetchWeatherForecastWithCity(
                    cityName: _cityName,
                    isCity: true, // Указывает, что запрос по названию города
                  );
                });
              }
            },
            icon: Icon(Icons.location_city, color: Colors.white),
          ),
        ],
      ),
      // Основное содержимое — список виджетов с погодой
      body: ListView(
        children: [
          Container(
            child: FutureBuilder<WeatherModel>(
              future: forecastObject, // Асинхронный запрос погоды
              builder: (context, snapshot) {
                // Если данные ещё загружаются
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitDoubleBounce(color: Colors.red, size: 100.0);
                } else if (snapshot.hasError) {
                  // Если произошла ошибка
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  // Если данные успешно получены
                  return Column(
                    children: [
                      SizedBox(height: 50),
                      CityView(snapshot: snapshot), // Отображение города
                      SizedBox(height: 50),
                      TempView(snapshot: snapshot), // Отображение температуры
                      SizedBox(height: 50),
                      DetailView(
                        snapshot: snapshot,
                      ), // Детали погоды (влажность и т.д.)
                      SizedBox(height: 50),
                      BottomListView(
                        snapshot: snapshot,
                      ), // Прогноз на несколько дней
                    ],
                  );
                }
                // Если данных нет
                else {
                  return const Center(child: Text('Нет данных'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
