import 'package:flutter/material.dart';
import 'input_page.dart';
import 'result_page.dart';
import 'route_page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEDEDED),
      ),
      initialRoute: '/input_page',
      routes: {
        '/input_page': (context) => const InputPage(),
        '/result_page': (context) => const ResultPage(),
        '/route_page': (context) => const RoutePage()
      },
    ),
  );
}
