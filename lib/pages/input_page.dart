import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padyak/pages/weather_loading_page.dart';
import 'package:padyak/pages/map_loading_page.dart';
import '../constants.dart';

class InputPage extends StatefulWidget {
  const InputPage({required this.currentLocation});

  final LatLng currentLocation;

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  late GoogleMapController _controller;
  var _initialCamPos;

  double? lat;
  double? long;

  var msgController1 = TextEditingController();
  var msgController2 = TextEditingController();
  Marker? _currentLocMarker;

  // Properties for storing the origin and destination.
  String origin = "";
  String destination = "";

  // Holds the string queries. This is seperated since queries require a specific format.
  String originQuery = "";
  String destinationQuery = "";

  @override
  void initState() {
    super.initState();
    _initialCamPos = CameraPosition(target: widget.currentLocation, zoom: 19);
    lat = widget.currentLocation.latitude;
    long = widget.currentLocation.longitude;
    _currentLocMarker = Marker(
      markerId: MarkerId('current_location'),
      infoWindow: const InfoWindow(title: 'Your Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: LatLng(lat!, long!),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit'),
        content: const Text('Do you want to exit app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return shouldPop;
  }

  Future<void> _destinationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Input Missing'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Please input a destination.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(fontSize: 16.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
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
                                    child: TextField(
                                      controller: msgController1,
                                      onChanged: (text) => setState(() {
                                        origin = text;
                                        print(
                                            text); // Would print the origin input. For debugging.
                                      }),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        hintText: 'Your current location',
                                      ),
                                      style: const TextStyle(
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
                                    child: TextField(
                                      controller: msgController2,
                                      onChanged: (text) => setState(() {
                                        destination = text;
                                        print(
                                            text); // Would print the destination input. For debugging.
                                      }),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        hintText: 'Your desired location',
                                      ),
                                      style: const TextStyle(
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
                              // Changes the format of the string and destination input.
                              originQuery =
                                  origin.trim().replaceAll(RegExp(' +'), '%20');
                              print(originQuery);
                              destinationQuery = destination
                                  .trim()
                                  .replaceAll(RegExp(' +'), '%20');
                              print(destinationQuery);

                              // Checks if there exists a destination input.
                              if (destinationQuery == "") {
                                _destinationDialog();
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MapLoadingScreen(
                                        originQuery: originQuery,
                                        destinationQuery: destinationQuery,
                                        currentLocation: widget.currentLocation,
                                      );
                                    },
                                  ),
                                );
                              }

                              // Clears the inputs.
                              msgController1.clear();
                              msgController2.clear();
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
                              onMapCreated: (controller) =>
                                  _controller = controller,
                              markers: {
                                if (_currentLocMarker != null)
                                  _currentLocMarker!
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
                                    CameraUpdate.newCameraPosition(
                                        _initialCamPos),
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const WeatherLoadingPage();
                                },
                              ),
                            );
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
                            Navigator.pushNamed(
                                context, '/proximity_loading_page');
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
      ),
    );
  }
}
