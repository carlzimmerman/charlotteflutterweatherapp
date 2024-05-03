import 'package:charlotteflutterweatherapp/widgets/wind_speed_chart.dart';
import 'package:flutter/cupertino.dart';

import '../models/weather_stuff.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherStuff weather;

  WeatherDetails({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text('Location: ${weather.location.name}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Temperature: ${weather.current.tempC} °C (${weather.current.tempF} °F)', style: TextStyle(fontSize: 20)),
        Text('Feels like: ${weather.current.feelslikeC} °C', style: TextStyle(fontSize: 20)),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https:${weather.current.condition.icon}', height: 50),
            SizedBox(width: 10),
            Text('${weather.current.condition.text}', style: TextStyle(fontSize: 18)),
          ],
        ),
        SizedBox(height: 10),

        Text('Humidity: ${weather.current.humidity}%', style: TextStyle(fontSize: 18)),
        Text('Pressure: ${weather.current.pressureMb} mb (${weather.current.pressureIn} in)', style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text('Visibility: ${weather.current.visKm} km (${weather.current.visMiles} miles)', style: TextStyle(fontSize: 18)),
        SizedBox(height: 20),
        Text('Wind: ${weather.current.windMph} mph (${weather.current.windKph} kph) ${weather.current.windDir}', style: TextStyle(fontSize: 18)),
        SizedBox(height: 100),
        SizedBox(
          height: 50,
          width: 50,
          child: WindSpeedChart(windMph: weather.current.windMph),
        ),

      ],
    );
  }
}
