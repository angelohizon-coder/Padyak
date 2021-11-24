import 'package:padyak/services/networking.dart';

const apiKey = '2e6a6cbc6b40a4b3e2172edf097e952d';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/forecast';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherImage(String condition) {
    switch (condition)
    {
      case 'Clear': return 'clear.png';
      case 'Clouds': return 'cloudy.png';
      case 'Rain': return 'rain.png';
      default: return 'thunder.png';
    }
  }
}
