import 'dart:ui';
import '../constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:padyak/services/weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherModel weather = WeatherModel();
  String typedName = '';
  String cityName = '';
  String weekDay = '';
  String currentDate = '';
  String month = '';
  int day = 0;
  int temperature = 0;
  List threeHourTemp = List.filled(9, null, growable: false);
  List condition = List.filled(9, null, growable: false);

  @override
  void initState() {
    super.initState();
    updateUI(widget.key);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        for (int i = 0; i < 9; i++)
        {
          threeHourTemp[i] = 0;
        }
        for (int i = 0; i < 9; i++)
        {
         condition[i] = 'cloudy.png';
        }
        return;
      }

      DateTime now = DateTime.now();
      int monthDate = now.month;
      int weekDate = now.weekday;
      day = now.day;
      var weekList = {
        1:'Mon',
        2:'Tue',
        3:'Wed',
        4:'Thu',
        5:'Fri',
        6:'Sat',
        7:'Sun'
      };
      var monthList = {
        1:'Jan',
        2:'Feb',
        3:'Mar',
        4:'Apr',
        5:'May',
        6:'Jun',
        7:'Jul',
        8:'Aug',
        9:'Sep',
        10:'Oct',
        11:'Nov',
        12:'Dec'
      };
      weekDay = weekList[weekDate].toString();
      month = monthList[monthDate].toString();

      temperature = weatherData['list'][0]['main']['temp'].toInt();
      cityName = weatherData['city']['name'];

      for (int i = 0; i < 9; i++)
      {
        threeHourTemp[i] = weatherData['list'][i]['main']['temp'].toInt();
      }

      for (int i = 0; i < 9; i++)
      {
        condition[i] = weather.getWeatherImage(weatherData['list'][i]['weather'][0]['main']);
      }
    });
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
              defaultSizedBoxTwentyFiveHeight,
              Expanded(
                flex: 4,
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Weather Forecast',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 36,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Today',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    '$weekDay $day $month',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        '$temperature',
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const Text(
                                        '°C',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    'images/weather/${condition[0]}',
                                    height: 100,
                                    fit: BoxFit.fitWidth,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(typedName),
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
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF625FFD),
                    ),
                    shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                  onPressed: () async {
                    typedName = 'London';
                    var weatherData = await weather.getCityWeather(typedName);
                    updateUI(weatherData);
                  },
                  child: Text(
                    'Get Weather Forecast',
                    style: blueStyleIconButton,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Today',
                            style: TextStyle(
                              color: Color(0xFF625FFD),
                              fontSize: 16,
                            ),
                          ),
                          style: noSplashEffect,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Tomorrow',
                            style: TextStyle(
                              color: Color(0xFF625FFD),
                              fontSize: 16,
                            ),
                          ),
                          style: noSplashEffect,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Next 7 Days',
                            style: TextStyle(
                              color: Color(0xFF625FFD),
                              fontSize: 16,
                            ),
                          ),
                          style: noSplashEffect,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${threeHourTemp[0]}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const Text(
                                          '°C',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          '12 AM',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          'images/weather/${condition[0]}',
                                          height: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xFFEDEDED),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${threeHourTemp[1]}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const Text(
                                          '°C',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          '3 AM',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          'images/weather/${condition[1]}',
                                          height: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xFFEDEDED),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${threeHourTemp[2]}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const Text(
                                          '°C',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          '9 AM',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          'images/weather/${condition[2]}',
                                          height: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xFFEDEDED),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${threeHourTemp[3]}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const Text(
                                          '°C',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          '9 AM',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          'images/weather/${condition[3]}',
                                          height: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xFFEDEDED),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${threeHourTemp[4]}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const Text(
                                          '°C',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          '10 AM',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          'images/weather/${condition[4]}',
                                          height: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xFFEDEDED),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${threeHourTemp[5]}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const Text(
                                          '°C',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          '12 PM',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          'images/weather/${condition[5]}',
                                          height: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xFFEDEDED),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${threeHourTemp[6]}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const Text(
                                          '°C',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          '3 PM',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          'images/weather/${condition[6]}',
                                          height: 50,
                                        ),
                                      ],
                                    ),
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
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${threeHourTemp[7]}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const Text(
                                          '°C',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          '6 PM',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          'images/weather/${condition[7]}',
                                          height: 50,
                                        ),
                                      ],
                                    ),
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
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${threeHourTemp[8]}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const Text(
                                          '°C',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          '9 PM',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          'images/weather/${condition[8]}',
                                          height: 50,
                                        ),
                                      ],
                                    ),
                                  ),
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
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/input_page');
                        },
                        child: Image.asset(
                          'images/menu/home.png',
                          color: const Color(0xFFC4C4C4),
                        ),
                      ),
                    ),
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
                          'images/menu/cloud-cut-version.png',
                          // width: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: TextButton(
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile_page');
                        },
                        child: Image.asset(
                          'images/menu/user.png',
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
