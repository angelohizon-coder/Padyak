import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
<<<<<<< HEAD
import 'package:google_maps_flutter/google_maps_flutter.dart';
=======
>>>>>>> 676e656 (refactor)
import 'package:padyak/models/location_model.dart';
import 'package:padyak/models/proximity_pois_model.dart';
import 'package:padyak/services/proximity_helper.dart';
import 'proximity_page.dart';

<<<<<<< HEAD

=======
>>>>>>> 676e656 (refactor)
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
<<<<<<< HEAD
  void getLocationData() async {
    var currentLocation = await LocationModel().getUserLocation();
    ProximityPoi? _info = await POIs().getPois(centerPoint: currentLocation,context: context);

    if(_info!.poisLatLng.isNotEmpty) {
=======

  void getLocationData() async {
    var currentLocation = await LocationModel().getUserLocation();
    ProximityPoi? _info =
        await POIs().getPois(centerPoint: currentLocation, context: context);

    if (_info!.poisLatLng.isNotEmpty) {
>>>>>>> 676e656 (refactor)
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ProximityPage(
          currentLocation: currentLocation,
          poiPoints: _info.poisLatLng,
          poiNames: _info.poisNames,
        );
      }));
<<<<<<< HEAD
    }else{
=======
    } else {
>>>>>>> 676e656 (refactor)
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ProximityPage(
          currentLocation: currentLocation,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://abergeldie.com.au/wp-content/uploads/2015/12/ajax-loader-large.gif'),
            ),
          ),
          child: const SpinKitDoubleBounce(
            color: Colors.black12,
            size: 100.0,
          ),
=======
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.black12,
          size: 100.0,
>>>>>>> 676e656 (refactor)
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 676e656 (refactor)
