import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padyak/models/polyline_model.dart';

class ProximityPoi{

  final List<LatLng> poisLatLng;
  final List<String> poisNames;
  final String? totalDistance;
  final String? totalDuration;


  const ProximityPoi({
    required this.poisNames,
    required this.poisLatLng,
    required this.totalDistance,
    required this.totalDuration});

  factory ProximityPoi.fromMap(Map<String, dynamic> map){
    //results
    //results[0].position.lat
    //results[1].position.lat
    final data = List<dynamic>.from(map['results']);



    String? distance = '';
    String? duration = '';

    if ((data).isNotEmpty) {

      var resultLen = data.length;
      print('length of points array in json is $resultLen');

      List<LatLng> poiLatLng = PolylinePointsJson().addPoisLatLng(data, resultLen);
      List<String> poisNames = PolylinePointsJson().getNames(data, resultLen);

      return ProximityPoi(
        poisNames: poisNames,
        poisLatLng: poiLatLng,
        totalDistance: distance,
        totalDuration: duration,
      );
    }
    else{
      throw Exception('Oh no something went wrong');
    }
  }
}