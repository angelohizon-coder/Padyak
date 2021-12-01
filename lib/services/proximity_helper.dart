

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:padyak/models/proximity_pois_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padyak/constants.dart';
import 'package:padyak/pages/proximity_loading_page.dart';
import 'package:padyak/pages/proximity_page.dart';

class POIs{

  final Dio _dio;

  POIs({Dio? dio}): _dio = dio ?? Dio();

  Future<ProximityPoi?> getPois({required LatLng centerPoint, required BuildContext context}) async{
    print('Origin lat and long: ${centerPoint.latitude} and ${centerPoint.longitude}');
    //https://api.tomtom.com/search/2/poiSearch/bike.json?
    String _tomPoiUrl = tomPOIsUrl;

    //bike.json?countrySet=PH&lat=14.6441519&lon=121.0502258&radius=10000&key=kKqkcovj3TB0E8EkJbPQ1bqzBHFo3AWp
    final Response poisResponse = await _dio.get(
      _tomPoiUrl,
      queryParameters: {
        'countrySet': 'PH',
        'lat': centerPoint.latitude,
        'lon': centerPoint.longitude,
        'radius': 3000,
        'key': kTomAPIKey
      },
    );

    //results
    //results[0].position.lat
    //results[1].position.lat
    //['routes'][0]['legs'][0]['points'][0]
    if(poisResponse.statusCode == 200){
      print(poisResponse.data);
      if((poisResponse.data['results'] as List).isEmpty){
        print('Results are not found');

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Center(child: Text('Notice')),
              content: const Text('No bikeshops found near you'),
              actions: [
                Center(
                  child: TextButton(
                    child: const Text('Ok'),
                    onPressed: (){
                      Navigator.popAndPushNamed(context, '/loading_page');
                    },
                  ),
                ),
              ],
            );
          }
        );
      }
      return ProximityPoi.fromMap(poisResponse.data);
    }
    else{
      throw Exception('Something went wrong');
    }
  }
}