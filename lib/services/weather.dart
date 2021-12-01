import 'package:padyak/services/location.dart';
import 'package:padyak/services/networking.dart';

const apiKey = '2e6a6cbc6b40a4b3e2172edf097e952d';
const openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';
const openWeatherForecastURL =
    'https://api.openweathermap.org/data/2.5/forecast';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationForecast() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherForecastURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var forecastData = await networkHelper.getData();
    return forecastData;
  }

  String getWeatherImage(String condition) {
    switch (condition) {
      case 'Clear':
        return 'clear.png';
      case 'Clouds':
        return 'cloudy.png';
      case 'Rain':
        return 'rain.png';
      default:
        return 'thunder.png';
    }
  }
}
