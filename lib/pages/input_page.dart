import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants.dart';

class InputPage extends StatefulWidget {
  InputPage({required this.currentLocation});

  final LatLng currentLocation;


  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  late GoogleMapController _controller;
  var _initialCamPos;

  double? lat;
  double? long;

  Marker? _currentLocMarker;

  @override
  void initState(){
    super.initState();
    _initialCamPos = CameraPosition(target: widget.currentLocation, zoom: 19);
    lat = widget.currentLocation.latitude;
    long = widget.currentLocation.longitude;
    _currentLocMarker = Marker(
      markerId: MarkerId('current_location'),
      infoWindow: const InfoWindow(title: 'Your Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: LatLng(lat!,long!),
    );
  }
  //List<Marker> markerList = someMethod;
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: defaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: ListTile(
                  leading: Image.asset(
                    'images/greetings.png',
                    height: 48,
                  ),
                  title: AutoSizeText(
                    'Hey there!',
                    style: labelInputPage,
                  ),
                  subtitle: const AutoSizeText(
                    'Where are you going today?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              defaultSizedBoxTwentyFiveHeight,
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  'Starting location',
                                  style: labelInputPage,
                                ),
                                subtitle: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 60, 0),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      hintText: 'Your current location',
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Image.asset(
                              'images/pen.JPG',
                              width: 24,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  'Destination location',
                                  style: labelInputPage,
                                ),
                                subtitle: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 60, 0),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      hintText: 'Your desired location',
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Image.asset(
                              'images/pen.JPG',
                              width: 24,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.1,
                        width: double.infinity,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF625FFD),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/map_page');
                          },
                          child: AutoSizeText(
                            'Get The Route',
                            style: blueStyleIconButton,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              defaultSizedBoxTwentyFiveHeight,
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Place Near You',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          GoogleMap(
                              myLocationButtonEnabled: false,
                              zoomControlsEnabled: false,
                              initialCameraPosition: _initialCamPos,
                              onMapCreated: (controller) => _controller = controller,
                              markers: {
                                if(_currentLocMarker != null)_currentLocMarker!
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
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF625FFD),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Image.asset(
                          'images/menu/home.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: TextButton(
                        style: noSplashEffect,
                        onPressed: () {
                          Navigator.pushNamed(context, '/weather_page');
                        },
                        child: Image.asset(
                          'images/menu/cloud-cut-version.png',
                          color: const Color(0xFFC4C4C4),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: TextButton(
                        style: noSplashEffect,
                        onPressed: () {
                          Navigator.pushNamed(context, '/proximity_page');
                        },
                        child: Image.asset(
                          'images/menu/radar.png',
                          color: const Color(0xFFC4C4C4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
