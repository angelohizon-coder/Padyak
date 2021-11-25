import 'package:flutter/material.dart';
import 'pages/input_page.dart';
import 'pages/result_page.dart';
import 'pages/weather_page.dart';
import 'pages/map_page.dart';
import 'pages/proximity_page.dart';
import 'package:padyak/pages/loading_page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEDEDED),
      ),
      initialRoute: '/loading_page',
      routes: {
        '/loading_page':(context) => LoadingScreen(),
        '/proximity_page': (context) => const ProximityPage(),
        '/map_page': (context) => const MapPage(),
        '/result_page': (context) => const ResultPage(),
        '/weather_page': (context) => const WeatherPage()
      },
    ),
  );
}
