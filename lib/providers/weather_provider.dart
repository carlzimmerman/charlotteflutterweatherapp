import 'package:flutter/material.dart';

import '../models/weather_stuff.dart';
import '../services/weather_api_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherStuff? _weather;

  WeatherStuff? get weather => _weather;

  Future<void> fetchWeather(double lat, double lon) async {
    var response = await WeatherApiService.fetchWeather(lat, lon);
    _weather = WeatherStuff.fromJson(response);
    notifyListeners();
  }
}
