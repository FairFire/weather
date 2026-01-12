import 'package:flutter/material.dart';
import 'package:weather_project/model/weather_model.dart';
import 'package:weather_project/utilities/forecast_util.dart';

class CityView extends StatelessWidget {
  final AsyncSnapshot<WeatherModel> snapshot;
  const CityView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var city = snapshot.data!.city!.name;
    var country = snapshot.data!.city!.country;
    var formattedDate = DateTime.fromMillisecondsSinceEpoch(
      snapshot.data!.list[0].dt * 1000,
    );
    return Container(
      child: Column(
        children: [
          Text(
            '$city, $country',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black87,
            ),
          ),
          Text(
            '${Util.getFormattedDate(formattedDate)}',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
