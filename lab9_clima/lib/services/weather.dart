import '../models/weather_model.dart';
import 'location.dart';
import 'networking.dart';

const String kApiKey = '69e5d8f37743b21a9638fb3710706a73';
const String kOpenWeatherMapURL =
    'https://api.openweathermap.org/data/2.5/weather';

class WeatherService {
  Future<WeatherData?> getLocationWeather() async {
    Location location = Location();
    bool hasLocation = await location.getCurrentLocation();

    if (hasLocation && location.latitude != null && location.longitude != null) {
      NetworkHelper networkHelper = NetworkHelper(
          '$kOpenWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');

      var weatherData = await networkHelper.getData();
      if (weatherData != null && (weatherData['cod'] == 200 || weatherData['cod'] == '200')) {
        return WeatherData.fromJson(weatherData);
      }
    }

    return getCityWeather('Hanoi');
  }

  Future<WeatherData?> getCityWeather(String cityName) async {
    String trimmedCity = cityName.trim();
    if (trimmedCity.isEmpty) {
      trimmedCity = 'Hanoi';
    }

    NetworkHelper networkHelper = NetworkHelper(
        '$kOpenWeatherMapURL?q=$trimmedCity&appid=$kApiKey&units=metric');

    var weatherData = await networkHelper.getData();
    if (weatherData != null && (weatherData['cod'] == 200 || weatherData['cod'] == '200')) {
      return WeatherData.fromJson(weatherData);
    }

    return null;
  }
}
