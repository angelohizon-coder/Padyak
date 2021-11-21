import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      controller: widget.controller,
      children: [
        const SizedBox(
          height: 12,
        ),
        buildDragHandle(),
        buildTextInformation(),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }

  Widget buildTextInformation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'images/map/paper-plane.png',
                    color: const Color(0xFF625FFD),
                    height: 30,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '30 KM',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Distance',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'images/map/clock.png',
                    color: const Color(0xFF625FFD),
                    height: 30,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '50 Minutes',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Estimated Time',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/map/flame.png',
                color: const Color(0xFF625FFD),
                height: 30,
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '200 Calories',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Calories Burned',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDragHandle() {
    return GestureDetector(
      child: Center(
        child: Container(
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[300],
          ),
          width: 40,
        ),
      ),
      onTap: () {
        widget.panelController.isPanelOpen
            ? widget.panelController.close()
            : widget.panelController.open();
      },
    );
  }
}
