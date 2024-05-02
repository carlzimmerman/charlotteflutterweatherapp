import 'package:flutter/material.dart';

import '../services/location_service.dart';

class LocationProvider with ChangeNotifier {
  late double latitude;
  late double longitude;

  Future<void> fetchLocation() async {
    var location = await LocationService.getLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    notifyListeners();
  }
}
