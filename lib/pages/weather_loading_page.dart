import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:padyak/pages/weather_page.dart';
import 'package:padyak/services/weather.dart';

class WeatherLoadingPage extends StatefulWidget {
  const WeatherLoadingPage({Key? key}) : super(key: key);

  @override
  _WeatherLoadingPageState createState() => _WeatherLoadingPageState();
}

class _WeatherLoadingPageState extends State<WeatherLoadingPage> {
  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    initWeather();
  }

  void initWeather() async {
    var forecastData = await weather.getLocationForecast();
    var weatherData = await weather.getLocationWeather();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WeatherPage(forecastData, weatherData);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.black12,
          size: 100.0,
        ),
      ),
    );
  }
}
