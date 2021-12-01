import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:padyak/models/location_model.dart';
import 'package:padyak/models/proximity_pois_model.dart';
import 'package:padyak/services/proximity_helper.dart';
import 'proximity_page.dart';

class ProximityLoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProximityLoadingScreenState();
  }
}

class _ProximityLoadingScreenState extends State<ProximityLoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var currentLocation = await LocationModel().getUserLocation();
    ProximityPoi? _info =
        await POIs().getPois(centerPoint: currentLocation, context: context);

    if (_info!.poisLatLng.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ProximityPage(
          currentLocation: currentLocation,
          poiPoints: _info.poisLatLng,
          poiNames: _info.poisNames,
        );
      }));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ProximityPage(
          currentLocation: currentLocation,
        );
      }));
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
