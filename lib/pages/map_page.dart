import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'panel_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final panelController = PanelController();

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
