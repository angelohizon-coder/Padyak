import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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
  final panelController = PanelController();
  String originName = "";
  double? originLatitude;
  double? originLongitude;

  String destinationName = "";
  double? destinationLatitude;
  double? destinationLongitude;

  @override
  void initState() {
    super.initState();

    // Extracts the data to respective variables.
    placeLocationData(
        widget.originData, widget.destinationData, widget.isCurrentLocation);
  }

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

      // For debugging purposes.
      print(originName);
      print(originLatitude);
      print(originLongitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Takes the height of the object and multiply it by 10%. btw the object is the height
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.125;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Your Route',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SlidingUpPanel(
        // rounded corner
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(18),
        ),
        maxHeight: panelHeightOpen,
        minHeight: panelHeightClosed,
        controller: panelController,
        body: const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Text('Map Goes Here'),
          ),
        ),
        panelBuilder: (controller) => PanelWidget(
          controller: controller,
          panelController: panelController,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
