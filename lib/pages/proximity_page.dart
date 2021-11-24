import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ProximityPage extends StatefulWidget {
  const ProximityPage({Key? key}) : super(key: key);

  @override
  _ProximityPageState createState() => _ProximityPageState();
}

class _ProximityPageState extends State<ProximityPage> {
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
          'Proximity Map',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: const AutoSizeText('Map Goes Here'),
      backgroundColor: Colors.white,
    );
  }
}
