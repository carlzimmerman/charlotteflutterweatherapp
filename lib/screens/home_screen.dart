import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_details.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charlotte Flutter Weather App'),
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView( // Allows the content to be scrollable
        child: Center(
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
