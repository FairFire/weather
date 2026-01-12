import 'package:weather_project/utilities/constans.dart';

// Модель данных для прогноза погоды, соответствует ответу OpenWeather API.
// Содержит информацию о городе, списке погодных данных на несколько дней и служебных полях.
class WeatherModel {
  City? city;
  late String cod;
  late double message;
  late int cnt;
  late List<WeatherList> list;

  WeatherModel({
    this.city,
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      cod: json['cod'],
      message: (json['message'] as num).toDouble(),
      cnt: json['cnt'],
      list:
          (json['list'] as List<dynamic>?)
              ?.map((e) => WeatherList.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    data['list'] = list.map((e) => e.toJson()).toList();
    return data;
  }
}

// Класс City представляет информацию о городе: координаты, название, страна, население и временные данные (восход/закат).

class City {
  late int id;
  late String name;
  late Coord coord;
  late String country;
  late int population;
  late int timezone;
  late int sunrise;
  late int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: Coord.fromJson(json['coord']),
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coord': coord.toJson(),
      'country': country,
      'population': population,
      'timezone': timezone,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}

// Класс Coord хранит географические координаты (широту и долготу).

class Coord {
  late double lat;
  late double lon;

  Coord({required this.lat, required this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lon': lon};
  }
}

// WeatherList — элемент прогноза погоды на конкретный момент времени (например, каждые 3 часа).
// Включает температуру, погодные условия, ветер, облака и другие параметры.

class WeatherList {
  late int dt;
  late Main main;
  late List<Weather> weather;
  late Clouds clouds;
  late Wind wind;
  late int visibility;
  Rain? rain;
  Snow? snow;
  late Sys sys;
  late String dtTxt;

  // Поля, которые могли быть в других API, но отсутствуют здесь
  double? pop; // может быть null

  WeatherList({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    this.rain,
    this.snow,
    required this.sys,
    required this.dtTxt,
    this.pop,
  });

  factory WeatherList.fromJson(Map<String, dynamic> json) {
    return WeatherList(
      dt: json['dt'],
      main: Main.fromJson(json['main']),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'] ?? 0,
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      snow: json['snow'] != null ? Snow.fromJson(json['snow']) : null,
      sys: Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
      pop: json['pop'] != null ? (json['pop'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['dt'] = dt;
    data['main'] = main.toJson();
    data['weather'] = weather.map((e) => e.toJson()).toList();
    data['clouds'] = clouds.toJson();
    data['wind'] = wind.toJson();
    data['visibility'] = visibility;
    if (rain != null) data['rain'] = rain!.toJson();
    if (snow != null) data['snow'] = snow!.toJson();
    data['sys'] = sys.toJson();
    data['dt_txt'] = dtTxt;
    if (pop != null) data['pop'] = pop;
    return data;
  }

  // Метод getIconUrl() формирует URL для загрузки иконки погоды на основе кода иконки.
  // Использует константу из Constants.WEATHER_IMAGES_URL.

  String getIconUrl() {
    return Constants.WEATHER_IMAGES_URL + weather[0].icon + '.png';
  }
}

// Класс Main содержит основные метеопараметры: температуру, ощущаемую температуру, давление и влажность.

class Main {
  late double temp;
  late double feelsLike;
  late double tempMin;
  late double tempMax;
  late int pressure;
  late int seaLevel;
  late int grndLevel;
  late int humidity;
  late double tempKf;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      tempMin: (json['temp_min'] as num).toDouble(),
      tempMax: (json['temp_max'] as num).toDouble(),
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: (json['temp_kf'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
      'humidity': humidity,
      'temp_kf': tempKf,
    };
  }
}

// Класс Weather описывает погодное состояние (облачность, дождь и т.п.) по ID, основному описанию и иконке.
// Иконка используется для отображения погоды через метод getIconUrl().

class Weather {
  late int id;
  late String main;
  late String description;
  late String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'main': main, 'description': description, 'icon': icon};
  }
}

class Clouds {
  late int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all']);
  }

  Map<String, dynamic> toJson() {
    return {'all': all};
  }
}

class Wind {
  late double speed;
  late int deg;
  double? gust;

  Wind({required this.speed, required this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] as num).toDouble(),
      deg: json['deg'],
      gust: json['gust'] != null ? (json['gust'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    if (gust != null) data['gust'] = gust;
    return data;
  }
}

// Классы Rain и Snow содержат данные об осадках за последние 3 часа ('3h').
// Поле помечено аннотацией @JsonKey, чтобы корректно сериализоваться/десериализоваться.

class Rain {
  @JsonKey(name: '3h')
  late double h3;

  Rain({required this.h3});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(h3: (json['3h'] as num).toDouble());
  }

  Map<String, dynamic> toJson() {
    return {'3h': h3};
  }
}

class Snow {
  @JsonKey(name: '3h')
  late double h3;

  Snow({required this.h3});

  factory Snow.fromJson(Map<String, dynamic> json) {
    return Snow(h3: (json['3h'] as num).toDouble());
  }

  Map<String, dynamic> toJson() {
    return {'3h': h3};
  }
}

class Sys {
  late String pod;

  Sys({required this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(pod: json['pod']);
  }

  Map<String, dynamic> toJson() {
    return {'pod': pod};
  }
}

// Вспомогательный класс для аннотаций (если используете json_annotation)
class JsonKey {
  final String name;

  const JsonKey({required this.name});
}
