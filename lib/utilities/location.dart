import 'package:geolocator/geolocator.dart';

// Класс для работы с геолокацией пользователя.
// Использует пакет geolocator для получения текущих координат.
class Location {
  late double
  latitude; // Широта текущего местоположения (будет заполнена после вызова getCurrentLocation)
  late double
  longitude; // Долгота текущего местоположения (будет заполнена после вызова getCurrentLocation)

  // Асинхронно получает текущие координаты пользователя с помощью Geolocator.
  // Устанавливает ограничение времени выполнения — 5 секунд.
  // В случае успеха сохраняет широту и долготу в соответствующие поля.
  // В случае ошибки (например, отсутствие доступа к геолокации) выбрасывает исключение
  // с описанием проблемы.

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition().timeout(
        Duration(seconds: 5),
      );
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      throw 'Something goes wrong: $e';
    }
  }
}
