import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:padyak/pages/map_page.dart';
import 'package:padyak/services/networking.dart';
import 'package:padyak/constants.dart';

class MapLoadingScreen extends StatefulWidget {
  MapLoadingScreen(
      {required this.originQuery,
      required this.destinationQuery,
      this.currentLocation});

  final String originQuery;
  final String destinationQuery;
  final currentLocation;

  @override
  _MapLoadingScreenState createState() => _MapLoadingScreenState();
}

class _MapLoadingScreenState extends State<MapLoadingScreen> {
  double? lat;
  double? long;

  @override
  void initState() {
    super.initState();
    lat = widget.currentLocation.latitude;
    long = widget.currentLocation.longitude;
    processLocationData(widget.originQuery, widget.destinationQuery);
  }

  // Returns the the data for each location.
  void processLocationData(String originQuery, String destinationQuery) async {
    var originData;
    bool isCurrentLocation = false;

    if (originQuery != "") {
      NetworkHelper nhOrigin = NetworkHelper(
          'https://api.tomtom.com/search/2/poiSearch/$originQuery.json?typeahead=true&limit=5&countrySet=PH&key=$kTomAPIKey');
      originData = await nhOrigin.getData();
    } else {
      print('The current location is $lat, $long');

      NetworkHelper nhOrigin = NetworkHelper(
          'https://api.tomtom.com/search/2/reverseGeocode/$lat%2C%20$long.json?key=$kTomAPIKey');
      originData = await nhOrigin.getData();
      isCurrentLocation = true;
    }

    NetworkHelper nhDestination = NetworkHelper(
        'https://api.tomtom.com/search/2/poiSearch/$destinationQuery.json?typeahead=true&limit=5&countrySet=PH&key=$kTomAPIKey');
    var destinationData = await nhDestination.getData();

    //  Proceed to /map_page carrying this data.
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MapPage(
        originData: originData,
        destinationData: destinationData,
        isCurrentLocation: isCurrentLocation,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.black12,
          size: 100.0,
        ),
      ),
    );
  }
}
