
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padyak/models/polyline_model.dart';

class Directions {

  final List<LatLng> polylinePoints;
  final int totalDistance;
  final int totalDuration;


  const Directions({
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration});

  factory Directions.fromMap(Map<String, dynamic> map){

    final data = Map<String, dynamic>.from(map['routes'][0]);


    //routes[0].legs[0].summary.lengthInMeters
    int distance;
    //routes[0].legs[0].summary.travelTimeInSeconds
    int duration;

    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      final points = leg['points'];
      var pointLen = points.length;
      distance = leg['summary']['lengthInMeters'];
      duration = leg['summary']['travelTimeInSeconds'];
      print('distance:$distance');
      print('duration:$duration');
      print('length of points array in json is $pointLen');

      List<LatLng> polylineLatLng = PolylinePointsJson().addLatLng(points, pointLen);

      return Directions(
        polylinePoints: polylineLatLng,
        totalDistance: distance,
        totalDuration: duration,
      );
    }
    else{
      throw Exception('Oh no something went wrong');
    }
  }
}