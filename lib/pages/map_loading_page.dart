import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:padyak/pages/map_page.dart';
import 'package:padyak/services/networking.dart';
import 'package:padyak/constants.dart';
import 'package:padyak/exceptions.dart';

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

  Future<void> _exceptionDialog(String title, String desc) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(desc),
          actions: [
            TextButton(
              child: const Text(
                'Try again',
                style: TextStyle(fontSize: 16.0),
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/loading_page');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    lat = widget.currentLocation.latitude;
    long = widget.currentLocation.longitude;
    processLocationData(widget.originQuery, widget.destinationQuery);
  }

  // Returns the the data for each location.
  void processLocationData(String originQuery, String destinationQuery) async {
    try {
      var originData;
      bool isCurrentLocation = false;

      if (originQuery != "") {
        NetworkHelper nhOrigin = NetworkHelper(
            'https://api.tomtom.com/search/2/poiSearch/$originQuery.json?typeahead=true&limit=5&countrySet=PH&key=$kTomAPIKey');
        originData = await nhOrigin.getData();

        // If originQuery doesn't have results.
        if (originData['results'].length == 0)
          throw InvalidOriginLocationException('');
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

      // If destinationQuery doesn't have results.
      if (destinationData['results'].length == 0)
        throw InvalidDestinationLocationException('');

      // If the location inputs have the same coordinates.
      if (!isCurrentLocation) {
        if ((originData['results'][0]['position']['lat'] ==
                destinationData['results'][0]['position']['lat']) &&
            (originData['results'][0]['position']['lon'] ==
                destinationData['results'][0]['position']['lon']))
          throw SameLocationException('');
      }

      //  Proceed to /map_page carrying this data.
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MapPage(
          originData: originData,
          destinationData: destinationData,
          isCurrentLocation: isCurrentLocation,
        );
      }));
    } on InvalidOriginLocationException {
      print('No results for the originQuery.');
      _exceptionDialog('No Results',
          'The application cannot find the entered origin location.');
    } on InvalidDestinationLocationException {
      print('No results for the destinationQuery.');
      _exceptionDialog(
          'No Results', 'The application cannot find the destination.');
    } on SameLocationException {
      print('The location inputs are the same.');
      _exceptionDialog(
          'Same Location!', 'The locations you entered are the same.');
    } catch (e) {
      print(e);
      _exceptionDialog('Error', e.toString());
    }
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
