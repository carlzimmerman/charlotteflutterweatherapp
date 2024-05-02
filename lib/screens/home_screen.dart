import 'package:charlotteflutterweatherapp/widgets/wind_speed_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/weather_stuff.dart';
import '../providers/location_provider.dart';
import '../providers/weather_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blueGrey,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              onPressed: () => fetchWeatherWithLocation(context),
              child: Text('Get Weather'),
            ),
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                return weatherProvider.weather != null
                    ? WeatherDetails(weather: weatherProvider.weather!)
                    : Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Press the button to fetch weather!", style: TextStyle(fontSize: 16)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void fetchWeatherWithLocation(BuildContext context) async {
    try {
      await Provider.of<LocationProvider>(context, listen: false).fetchLocation();
      double lat = Provider.of<LocationProvider>(context, listen: false).latitude;
      double lon = Provider.of<LocationProvider>(context, listen: false).longitude;
      await Provider.of<WeatherProvider>(context, listen: false).fetchWeather(lat, lon);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to fetch data: $e")));
    }
  }
}

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


        Text('Wind: ${weather.current.windMph} mph (${weather.current.windKph} kph) ${weather.current.windDir}', style: TextStyle(fontSize: 18)),

        WindSpeedChart(windMph: weather.current.windMph),

        Text('Humidity: ${weather.current.humidity}%', style: TextStyle(fontSize: 18)),
        Text('Pressure: ${weather.current.pressureMb} mb (${weather.current.pressureIn} in)', style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text('Visibility: ${weather.current.visKm} km (${weather.current.visMiles} miles)', style: TextStyle(fontSize: 18)),
        SizedBox(height: 20),
      ],
    );
  }
}
