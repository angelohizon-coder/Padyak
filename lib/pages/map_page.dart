import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padyak/models/direction_model.dart';
import 'package:padyak/pages/result_page.dart';
import 'package:padyak/services/direction_helper.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location/location.dart';
import 'panel_widget.dart';

class MapPage extends StatefulWidget {
  MapPage({this.originData, this.destinationData, this.isCurrentLocation});

  final originData;
  final destinationData;
  final isCurrentLocation;
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Timer _timer;
  int timerCount = 0;

  final panelController = PanelController();
  String originName = "";
  double? originLatitude;
  double? originLongitude;

  String destinationName = "";
  double? destinationLatitude;
  double? destinationLongitude;
  String destinationAddress = "";

  double duration = 0;
  double distance = 0;

  // Method used to extract the needed data from this JSON.
  void placeLocationData(
      dynamic originData, dynamic destinationData, bool isCurrentLocation) {
    setState(() {
      if (!isCurrentLocation) {
        originName = originData['results'][0]['poi']['name'];
        originLatitude = originData['results'][0]['position']['lat'];
        originLongitude = originData['results'][0]['position']['lon'];
      } else {
        originName = originData['addresses'][0]['address']['freeformAddress'];
        String pos = originData['addresses'][0]['position'];
        List<String> temp = pos.split(',');
        originLatitude = double.parse(temp[0]);
        originLongitude = double.parse(temp[1]);
      }

      destinationName = destinationData['results'][0]['poi']['name'];
      destinationLatitude = destinationData['results'][0]['position']['lat'];
      destinationLongitude = destinationData['results'][0]['position']['lon'];
      destinationAddress =
          destinationData['results'][0]['address']['freeformAddress'];

      // For debugging purposes.
      print(originName);
      print(originLatitude);
      print(originLongitude);
    });
  }

  var _initialCamPos;
  double? lat;
  double? long;

  late Location location;
  late StreamSubscription<LocationData> locationSub;

  final Set<Marker> _marker = <Marker>{};
  //<Type>? means that its variable can be null
  late GoogleMapController _controller;
  late Marker _origin;
  late Marker _curUserLoc;
  late Marker _destination;



  Directions? _info;
  int counter = 0;
  @override
  void initState() {
    super.initState();

    // Extracts the data to respective variables.
    placeLocationData(
        widget.originData, widget.destinationData, widget.isCurrentLocation);
    _initialCamPos = CameraPosition(
        target: LatLng(originLatitude!, originLongitude!), zoom: 13.0);
    _addMarker();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timerCount+=1;
      });
    });

    /*lat = widget.currentLocation.latitude;
    long = widget.currentLocation.longitude;*/
  }

  //<variable_name>! null checks each variable that is declared <Type>?
  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Route'),
        content: const Text('Do you want to try another route?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/loading_page');
              locationSub.cancel();
              _timer.cancel();
              print('Time elapsed $timerCount seconds');
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return shouldPop;
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.2;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.25;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            TextButton(
              onPressed: () => _controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin.position,
                    zoom: 18,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.cyan,
                textStyle: const TextStyle(fontWeight: FontWeight.w900),
              ),
              child: const Text('Your Location'),
            ),
            TextButton(
              onPressed: () => _controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination.position,
                    zoom: 18,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.orange,
                textStyle: const TextStyle(fontWeight: FontWeight.w900),
              ),
              child: const Text('Destination'),
            ),
          ],
          title: const Text(
            'Route',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SlidingUpPanel(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(18),
          ),
          maxHeight: panelHeightOpen,
          minHeight: panelHeightClosed,
          controller: panelController,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: _initialCamPos,
                onMapCreated: (controller) => _controller = controller,
                markers: _marker,
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: PolylineId('overview_polyline'),
                      color: Colors.deepPurple,
                      width: 10,
                      points: _info!.polylinePoints,
                    ),
                },
              ),
            ),
          ),
          panelBuilder: (controller) => PanelWidget(
            address: destinationAddress,
            duration: duration.toInt(),
            distance: distance,
            controller: controller,
            panelController: panelController,
          ),
        ),
      ),
    );
  }

  void updateMapMarker(LatLng curLoc) async{
    setState(() {
      _marker.removeWhere((m) => m.markerId.value == 'userLocation');
      _marker.add(Marker(
        markerId: MarkerId('userLocation'),
        infoWindow: const InfoWindow(title: 'You'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        position: curLoc,
      ));
    });
  }
  void _addMarker() async {
    LatLng start = LatLng(originLatitude!, originLongitude!);
    LatLng end = LatLng(destinationLatitude!, destinationLongitude!);
    setState(() {
      _curUserLoc = Marker(
        markerId: MarkerId('userLocation'),
        infoWindow: const InfoWindow(title: 'You'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        position: start,
      );
      _origin = Marker(
        markerId: MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Current Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        position: start,
      );
      _destination = Marker(
        markerId: MarkerId('destination'),
        infoWindow: InfoWindow(title: destinationName),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        position: end,
      );
      _marker.add(_origin);
      _marker.add(_destination);
    });
    print('Origin = $end');
    print('Destination = $start');
    final directions = await Direction().getDirection(
      origin: start,
      destination: end,
    );
    setState(() {
      _info = directions;
      duration = (_info!.totalDuration / 60);
      distance = (_info!.totalDistance / 1000);
    });
    LatLng currentLoc;
    location = Location();

    //Dynamically Update userMarker(current location of user on the map)
    locationSub =
    location.onLocationChanged.distinct().listen((LocationData cLoc) {
      location.changeSettings(interval: 5000, distanceFilter: 1);
      lat = cLoc.latitude;
      long = cLoc.longitude;
      print('lat: $lat and long: $long');
      print('Number of times called: ${counter}');
      counter++;
      currentLoc = LatLng(lat!,long!);
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentLoc,
            zoom: 18,
            tilt: 20,
          ),
        ),
      );
      updateMapMarker(currentLoc);
      reachedDestination(currentLoc, end);
    });
  }
  void reachedDestination(LatLng currentLoc, LatLng destination){
    double resultLat = 0;
    double resultLong = 0;
    double travelDuration = 0;
    resultLat = currentLoc.latitude - destination.latitude;
    resultLong = currentLoc.longitude - destination.longitude;
    print('ResultLat = $resultLat');
    print('ResultLong = $resultLong');
    if((resultLat > -0.00006 && resultLat < 0.00006) && (resultLong > -0.00006 && resultLong < 0.00006)){
      _timer.cancel();
      locationSub.cancel();
      travelDuration = timerCount/60;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ResultPage(
              estimatedTime: travelDuration,
              distance: distance,
            );
          },
        ),
      );
    }
    else{
      print('Destination not reached');
    }
  }
}