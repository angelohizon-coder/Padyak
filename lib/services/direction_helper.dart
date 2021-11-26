
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padyak/models/direction_model.dart';

import '../constants.dart';

class Direction{

  final Dio _dio;

  Direction({Dio? dio}): _dio = dio ?? Dio();

  Future<Directions?> getDirection({required LatLng origin, required LatLng destination}) async{
    print('Origin lat and long: ${origin.latitude} and ${origin.longitude}');
    print('Destination lat and long: ${destination.latitude} and ${destination.longitude}');
    String _baseTomUrl = '$tomDirectionsUrl${origin.latitude}%2C${origin.longitude}%3A${destination.latitude}%2C${destination.longitude}/json?';

    //instructionsType=text&computeBestOrder=true&routeType=eco&avoid=unpavedRoads&travelMode=bicycle&key=$kTomAPIKey
    final Response directionResponse = await _dio.get(
      _baseTomUrl,
      queryParameters: {
        'computeBestOrder': true,
        'routeType': 'fastest',
        'travelMode': 'bicycle',
        'key': kTomAPIKey
      },
    );

    //routes[0].legs[0].points
    //['routes'][0]['legs'][0]['points'][0]
    if(directionResponse.statusCode == 200){
      print(directionResponse.data);
      if((directionResponse.data['routes'] as List).isEmpty){
        print('No route showed: it is null');
        return null;
      }
      return Directions.fromMap(directionResponse.data);
    }
    else{
      print('Something went wrong');
    }
  }
}