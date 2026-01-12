import 'package:flutter/material.dart';
import 'package:weather_project/utilities/forecast_util.dart';

Widget forecastCard(AsyncSnapshot snapshot, int index) {
  var forecastList = snapshot.data!.list;
  DateTime date = DateTime.fromMillisecondsSinceEpoch(
    forecastList[index].dt * 1000,
  );
  var fullDate = Util.getFormattedDate(date);
  var dayOfWeek = fullDate.split(',')[0];
  var temp_min = forecastList[index].main.tempMin.toStringAsFixed(0);
  var icon = forecastList[index].getIconUrl();
  var timeDate = Util.getFormattedDateTime(date);
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            dayOfWeek,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(1.0),
          child: Text('$timeDate', style: TextStyle(color: Colors.white)),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsetsGeometry.all(4),
                    child: Text(
                      '$temp_min *C',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Image.network(icon, scale: 1.2, color: Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
