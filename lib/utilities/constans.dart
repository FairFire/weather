/// Класс для хранения констант приложения.
/// Содержит ключи API и базовые URL-адреса для взаимодействия с сервисом OpenWeatherMap.
class Constants {
  /// Уникальный API-ключ для доступа к сервису OpenWeatherMap.
  /// Должен оставаться приватным и не коммититься в публичные репозитории (в идеале — использовать скрытые переменные).
  static const String WEATHER_APP_ID = '1369dd6b5ae78fc9952261ab9aa236b4';

  /// Схема протокола для HTTPS-запросов к API погоды.
  static const String WEATHER_BASE_SCHEME = 'https';

  /// Домен основного API OpenWeatherMap.
  static const String WEATHER_BASE_URL_DOMAIN = 'api.openweathermap.org';

  /// Путь к эндпоинту прогноза погоды (5 дней с интервалом 3 часа).
  static const String WEATHER_FORECAST_PATH = '/data/2.5/forecast';

  /// Путь к изображениям погодных условий (иконки состояния погоды: облака, дождь и т.д.).
  static const String WEATHER_IMAGES_PATH = '/img/w/';

  /// Полный базовый URL для получения иконок погоды.
  /// Формируется как: https://api.openweathermap.org/img/w/
  /// Используется для отображения иконок (например, облачность, дождь) в приложении.

  static const String WEATHER_IMAGES_URL =
      WEATHER_BASE_SCHEME +
      '://' +
      WEATHER_BASE_URL_DOMAIN +
      WEATHER_IMAGES_PATH;
}
