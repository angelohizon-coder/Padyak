import 'dart:ui';
import '../constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:padyak/services/weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({
    Key? key,
    // required this.weatherData,
    // required this.forecastData
  }) : super(key: key);
  // static const routeName = '/weather_page';
  // final dynamic weatherData;
  // final dynamic forecastData;

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherModel weather = WeatherModel();
  String weekDay = '';
  String currentDate = '';
  String month = '';
  int day = 0;
  String cityName = '';
  int temperature = 0;
  String condition = '';
  List threeHourTemp = List.filled(9, null, growable: false);
  List threeHourCond = List.filled(9, null, growable: false);

  @override
  void initState() {
    super.initState();
    updateUI(widget.key, widget.key);
  }

  void updateUI(dynamic forecastData, dynamic weatherData) {
    setState(() {
      if (forecastData == null || weatherData == null) {
        cityName = '';
        temperature = 0;
        condition = 'cloudy.png';
        for (int i = 0; i < 9; i++)
        {
          threeHourTemp[i] = 0;
        }
        for (int i = 0; i < 9; i++)
        {
          threeHourCond[i] = 'cloudy.png';
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
      cityName = weatherData['name'];
      temperature = weatherData['main']['temp'].toInt();
      condition = weather.getWeatherImage(weatherData['weather'][0]['main']);

      for (int i = 0; i < 8; i++)
      {
        threeHourTemp[i] = forecastData['list'][i]['main']['temp'].toInt();
      }
      for (int i = 0; i < 8; i++)
      {
        threeHourCond[i] = weather.getWeatherImage(forecastData['list'][i]['weather'][0]['main']);
      }
    });
  }

  Row threeHourWeather(int temp, String cond, String time) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                '$temp',
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
              Text(
                time,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                'images/weather/$cond',
                height: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    /*dynamic weatherData = widget.weatherData;
    dynamic forecastData = widget.forecastData;

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
    cityName = weatherData['name'];
    temperature = weatherData['main']['temp'].toInt();
    condition = weather.getWeatherImage(weatherData['weather'][0]['main']);

    for (int i = 0; i < 9; i++)
    {
      threeHourTemp[i] = forecastData['list'][i]['main']['temp'].toInt();
    }
    for (int i = 0; i < 9; i++)
    {
      threeHourCond[i] = weather.getWeatherImage(forecastData['list'][i]['weather'][0]['main']);
    }*/

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
                                    'images/weather/$condition',
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
                                  Text(cityName),
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
                    var forecastData = await weather.getLocationForecast();
                    var weatherData = await weather.getLocationWeather();
                    updateUI(forecastData, weatherData);
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
                              child: threeHourWeather(threeHourTemp[0], threeHourCond[0], '12 AM'),
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
                              child: threeHourWeather(threeHourTemp[1], threeHourCond[1], '3 AM'),
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
                              child: threeHourWeather(threeHourTemp[2], threeHourCond[2], '6 AM'),
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
                              child: threeHourWeather(threeHourTemp[3], threeHourCond[3], '9 AM'),
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
                              child: threeHourWeather(threeHourTemp[4], threeHourCond[4], '12 PM'),
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
                              child: threeHourWeather(threeHourTemp[5], threeHourCond[5], '3 PM'),
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
                              child: threeHourWeather(threeHourTemp[6], threeHourCond[6], '6 PM'),
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
                              child: threeHourWeather(threeHourTemp[7], threeHourCond[7], '9 PM'),
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
                                          'images/weather/${threeHourCond[8]}',
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
                          Navigator.pushNamed(context, '/loading_page');
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
                        style: noSplashEffect,
                        onPressed: () {
                          Navigator.pushNamed(context, '/proximity_page');
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
    );
  }
}


