import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:padyak/models/location_model.dart';

import 'input_page.dart';


class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }
  void getLocationData() async {
    var currentLocation = await LocationModel().getUserLocation();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return InputPage(
        currentLocation: currentLocation,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
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
        ),
      ),
    );
  }
}