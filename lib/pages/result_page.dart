import 'package:auto_size_text/auto_size_text.dart';

import '../constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultPage extends StatefulWidget {
  final double distance;
  final double estimatedTime;

  ResultPage({required this.distance,required this.estimatedTime});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Today',
                        style: TextStyle(
                          color: Color(0xFF625FFD),
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Mon 26 Apr',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              defaultSizedBoxTwentyFiveHeight,
              Expanded(
                flex: 5,
                child: SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    child: CircularPercentIndicator(
                      radius: MediaQuery.of(context).size.width * 0.75,
                      lineWidth: 25.0,
                      percent: 0.1,
                      center: Text(
                        '[Insert Number Here] \nCalories Burned',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.0475,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      animation: true,
                      progressColor: const Color(0xFF625FFD),
                      circularStrokeCap: CircularStrokeCap.round,
                      backgroundColor: const Color(0xFFC4C4C4),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.4,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Center(
                              child: Text(
                                'Cycling Time',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  '${widget.estimatedTime} minutes',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                LinearPercentIndicator(
                                  lineHeight: 14.0,
                                  percent: 0.5,
                                  backgroundColor: const Color(0xFFC4C4C4),
                                  progressColor: const Color(0xFF625FFD),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xFFEDEDED),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.4,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Center(
                              child: Text(
                                'Total Distance',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  '${widget.distance} kilometers',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                LinearPercentIndicator(
                                  lineHeight: 14.0,
                                  percent: 0.5,
                                  backgroundColor: const Color(0xFFC4C4C4),
                                  progressColor: const Color(0xFF625FFD),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xFFEDEDED),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: double.infinity,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF625FFD),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/loading_page');
                    },
                    child: AutoSizeText(
                      'Exit',
                      style: blueStyleIconButton,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
