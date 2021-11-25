import 'package:google_maps_flutter/google_maps_flutter.dart';

//Responsible for getting list of LatLng points
class PolylinePointsJson {

  List<LatLng> addLatLng(dynamic json, int length){
    List<LatLng> polyline = [];
    for(int x = 0; x < length; x++){
      print('Latitude: ${json[x]['latitude']} & Longitude: ${json[x]['longitude']}');
      //leg['points'][index]['latitude']
      polyline.add(LatLng(json[x]['latitude'] as double, json[x]['longitude'] as double));
    }
    return polyline;
  }
}