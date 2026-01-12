import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_project/api/weather_api.dart';
import 'package:weather_project/model/weather_model.dart';
import 'package:weather_project/screens/city_screen.dart';
import 'package:weather_project/widgets/bottom_list_view.dart';
import 'package:weather_project/widgets/city_view.dart';
import 'package:weather_project/widgets/detai_view.dart';
import 'package:weather_project/widgets/temp_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  final locationWeather;
  WeatherForecastScreen({super.key, this.locationWeather});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late String _cityName;
  late Future<WeatherModel> forecastObject;

  @override
  void initState() {
    super.initState();

    if (widget.locationWeather != null) {
      forecastObject = WeatherApi().fetchWeatherForecastWithCity();
    }

    /* forecastObject = WeatherApi().fetchWeatherForecastWithCity(
      cityName: _cityName,
      isCity: true,
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'openweathermap.org',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              forecastObject = WeatherApi().fetchWeatherForecastWithCity();
            });
          },
          icon: Icon(Icons.my_location, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              var tapName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CityScreen();
                  },
                ),
              );
              if (tapName != null) {
                setState(() {
                  _cityName = tapName;
                  forecastObject = WeatherApi().fetchWeatherForecastWithCity(
                    cityName: _cityName,
                    isCity: true,
                  );
                });
              }
            },
            icon: Icon(Icons.location_city, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            child: FutureBuilder<WeatherModel>(
              future: forecastObject,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitDoubleBounce(color: Colors.red, size: 100.0);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(height: 50),
                      CityView(snapshot: snapshot),
                      SizedBox(height: 50),
                      TempView(snapshot: snapshot),
                      SizedBox(height: 50),
                      DetailView(snapshot: snapshot),
                      SizedBox(height: 50),
                      BottomListView(snapshot: snapshot),
                    ],
                  );
                } else {
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
