import 'package:flutter/material.dart';
import 'package:weather_project/model/weather_model.dart';

// ignore: must_be_immutable
class TempView extends StatelessWidget {
  AsyncSnapshot<WeatherModel> snapshot;
  TempView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;
    var icon = forecastList[0].getIconUrl();
    var temp = forecastList[0].main.temp.toStringAsFixed(0);
    var description = forecastList[0].weather[0].description.toUpperCase();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(icon, scale: 0.4, color: Colors.black87),
          SizedBox(width: 20),
          Column(
            children: [
              Text(
                '$temp C',
                style: TextStyle(fontSize: 54, color: Colors.black87),
              ),
              Text('$description', style: TextStyle(fontSize: 20)),
            ],
          ),
        ],
      ),
    );
  }
}
