import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padyak/services/location.dart';

class LocationModel{
  Future<dynamic> getUserLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    double? lat = location.latitude;
    double? long = location.longitude;
    LatLng currentLocation = LatLng(lat!, long!);
    return currentLocation;
  }
}