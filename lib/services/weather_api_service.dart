import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApiService {
  static Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    var apikey = "WEATHER_API_KEY";

    var response = await http.get(Uri.parse('https://api.weatherapi.com/v1/current.json?key=${apikey}&q=$lat,$lon'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
