import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padyak/models/direction_model.dart';
import 'package:padyak/models/location_model.dart';
import 'package:padyak/services/direction_helper.dart';

class ProximityPage extends StatefulWidget {
  ProximityPage({required this.currentLocation, this.poiPoints, this.poiNames});

  final LatLng currentLocation;
  final poiPoints;
  final poiNames;

  @override
  _ProximityPageState createState() => _ProximityPageState();
}

class _ProximityPageState extends State<ProximityPage> {
  late GoogleMapController _controller;
  var _initialCamPos;
  var updateLocation;

  Directions? _info;

  late BitmapDescriptor myIcon;

  double? curLat;
  double? curLong;
  late List<LatLng> poiPoints;
  late List<String> poiNames;

  late Set<Circle> circles;

  Marker? _currentLocMarker;
  void getLocationData() async {
    updateLocation = await LocationModel().getUserLocation();
  }

  @override
  void initState() {
    super.initState();
    _initialCamPos = CameraPosition(target: widget.currentLocation, zoom: 12);
    poiPoints = widget.poiPoints;
    poiNames = widget.poiNames;

    curLat = widget.currentLocation.latitude;
    curLong = widget.currentLocation.longitude;
    circles = {
      Circle(
        circleId: const CircleId('Current Location'),
        center: LatLng(curLat!, curLong!),
        radius: 3000,
        fillColor: Colors.blue.shade100.withOpacity(0.5),
        strokeColor: Colors.blue.shade100.withOpacity(0.1),
      )
    };

    _currentLocMarker = Marker(
      markerId: const MarkerId('current_location'),
      infoWindow: const InfoWindow(title: 'Your Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: LatLng(curLat!, curLong!),
    );
  }

  //List<Marker> markerList = someMethod;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit the map?'),
        content: const Text('Do you want to exit map?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/loading_page'),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return shouldPop;
  }

  @override
  Widget build(BuildContext context) {
    // Takes the height of the object and multiply it by 10%. btw the object is the height
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.125;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.2;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Proximity Map',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: _initialCamPos,
              onMapCreated: (controller) => _controller = controller,
              markers: {
                if (_currentLocMarker != null) _currentLocMarker!,
                if (poiPoints.isNotEmpty && poiNames.isNotEmpty)
                  for (int x = 0; x < poiPoints.length; x++)
                    Marker(
                      markerId: MarkerId(poiNames[x]),
                      infoWindow: InfoWindow(title: poiNames[x]),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRose),
                      position: poiPoints[x],
                      onTap: () {
                        print(poiPoints);
                        //Point of Interest or POI = bikeshop
                        _addMarker(poiPoints[x]);
                      },
                    ),
              },
              circles: circles,
              polylines: {
                if (_info != null)
                  Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Colors.deepPurple,
                      width: 10,
                      points: _info!.polylinePoints)
              },
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                onPressed: () {
                  _controller.animateCamera(
                    CameraUpdate.newCameraPosition(_initialCamPos),
                  );
                },
                child: const Icon(Icons.center_focus_strong),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    final directions = await Direction()
        .getDirection(origin: LatLng(curLat!, curLong!), destination: pos);
    setState(() => _info = directions);
  }
}
