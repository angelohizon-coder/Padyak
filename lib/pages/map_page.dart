import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padyak/models/direction_model.dart';
import 'package:padyak/services/direction_helper.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'panel_widget.dart';

class MapPage extends StatefulWidget {
  MapPage({this.originData, this.destinationData});

  final originData;
  final destinationData;
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
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
  void placeLocationData(dynamic originData, dynamic destinationData) {
    setState(() {
      originName = originData['results'][0]['poi']['name'];
      originLatitude = originData['results'][0]['position']['lat'];
      originLongitude = originData['results'][0]['position']['lon'];

      destinationName = destinationData['results'][0]['poi']['name'];
      destinationLatitude = destinationData['results'][0]['position']['lat'];
      destinationLongitude = destinationData['results'][0]['position']['lon'];
      destinationAddress = destinationData['results'][0]['address']['freeformAddress'];

      // For debugging purposes.
      print(originName);
      print(originLatitude);
      print(originLongitude);
    });
  }

  var _initialCamPos;
  double? lat;
  double? long;

  //<Type>? means that its variable can be null
  late GoogleMapController _controller;
  late Marker _origin;
  late Marker _destination;
  Directions? _info;


  @override
  void initState(){
    super.initState();
    // Extracts the data to respective variables.
    placeLocationData(widget.originData, widget.destinationData);
    _initialCamPos = CameraPosition(target: LatLng(originLatitude!,originLongitude!), zoom: 13.0);
    _addMarker();
    /*lat = widget.currentLocation.latitude;
    long = widget.currentLocation.longitude;*/
  }
  //<variable_name>! null checks each variable that is declared <Type>?
  @override
  void dispose(){

    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.125;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Route'),
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
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
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
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: const Text('Destination'),
          ),
        ],
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
              markers: {
                if(_origin != null) _origin,
                if(_destination != null) _destination,

              },
              polylines: {
                if(_info != null)
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

    );
  }
  void _addMarker() async{
    LatLng start = LatLng(originLatitude!, originLongitude!);
    LatLng end = LatLng(destinationLatitude!,destinationLongitude!);
    setState(() {
      _origin = Marker(
        markerId: MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'You'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        position: start,
      );
      _destination = Marker(
        markerId: MarkerId('destination'),
        infoWindow: InfoWindow(title: destinationName),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        position: end,
      );
    });
    print('Origin = $end');
    print('Destination = $start');
    final directions = await Direction().getDirection(
      origin: start,
      destination: end,
    );
    setState(() {
      _info = directions;
      duration = (_info!.totalDuration/60).roundToDouble();
      distance = (_info!.totalDistance/1000).roundToDouble();
    });
  }
}