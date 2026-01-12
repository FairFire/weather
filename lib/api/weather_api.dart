/// Класс для получения данных о погоде с API OpenWeather.
/// Поддерживает запросы по названию города или по текущему местоположению устройства.
import 'dart:convert';
import 'dart:developer';
import 'package:weather_project/model/weather_model.dart';
import 'package:weather_project/utilities/constans.dart';
import 'package:http/http.dart' as http;
import 'package:weather_project/utilities/location.dart';

class WeatherApi {
  /// Получает прогноз погоды на основе названия города или текущего местоположения.
  ///
  /// Параметры:
  /// - [cityName]: Название города (опционально). Обязательно, если [isCity] == true.
  /// - [isCity]: Если true — запрос по городу, иначе — по координатам устройства.
  ///
  /// Возвращает объект [WeatherModel] с распарсенными данными о погоде.
  ///
  /// Выбрасывает исключение, если:
  /// - API возвращает ошибку (например, город не найден).
  /// - HTTP-запрос завершился с кодом, отличным от 200.
  Future<WeatherModel> fetchWeatherForecastWithCity({
    String? cityName,
    bool isCity = false,
  }) async {
    // Инициализация сервиса определения местоположения
    Location location = Location();
    await location
        .getCurrentLocation(); // Получаем текущие координаты устройства

    Map<String, String>? parameters;

    // Формируем параметры запроса в зависимости от типа поиска
    if (isCity == true) {
      // Запрос по названию города
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric', // Единицы измерения: градусы Цельсия
        'q': cityName ?? 'Minsk', // Название города, по умолчанию — Минск
      };
      parameters = queryParameters;
    } else {
      // Запрос по географическим координатам
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'lat': location.latitude.toString(), // Широта
        'lon': location.longitude.toString(), // Долгота
      };
      parameters = queryParameters;
    }

    // Формируем URL с доменом, путём и параметрами

    var uri = Uri.https(
      Constants
          .WEATHER_BASE_URL_DOMAIN, // Базовый домен (например, api.openweathermap.org)
      Constants.WEATHER_FORECAST_PATH, // Путь к эндпоинту прогноза
      parameters, // Параметры запроса
    );

    // Логируем сформированный URL для отладки
    log('request: ${uri.toString()}');

    // Выполняем HTTP-запрос
    var response = await http.get(uri);

    print('response: ${response?.body}');

    // Проверяем статус ответа
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      // Проверяем, вернул ли API собственную ошибку (например, "city not found")
      if (jsonBody['cod'] != '200') {
        throw Exception(jsonBody['message'].toString());
      }
      // Успешный ответ — парсим данные в модель WeatherModel
      return WeatherModel.fromJson(jsonBody);
    } else {
      // Ошибка HTTP-запроса
      throw Exception('HTTP Error: ${response.statusCode}');
    }
  }
}
