import 'package:flutter/material.dart';
import 'package:padyak/pages/weather_loading_page.dart';
import 'package:padyak/pages/proximity_loading_page.dart';
import 'pages/result_page.dart';
import 'pages/map_page.dart';
import 'package:padyak/pages/loading_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEDEDED),
      ),
      initialRoute: '/loading_page',
      routes: {
        '/loading_page': (context) => LoadingScreen(),
        '/proximity_loading_page': (context) => ProximityLoadingScreen(),
        '/map_page': (context) => MapPage(),
        '/weather_loading_page': (context) => const WeatherLoadingPage(),
      },
    ),
  );
}
