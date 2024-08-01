import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherService {
  static const String _apiKey = '8c3a727b2c7e4602ad5203733241004';
  // Replace with your actual API key
  static const String _baseUrl = 'http://api.weatherapi.com/v1/current.json?key=8c3a727b2c7e4602ad5203733241004&q=India&aqi=no';

  static Future<WeatherData> fetchWeather(String city) async {
    final currentWeatherUrl = '$_baseUrl/weather?q=$city&appid=$_apiKey&units=metric';
    final forecastUrl = '$_baseUrl/forecast?q=$city&appid=$_apiKey&units=metric';

    try {
      final currentWeatherResponse = await http.get(Uri.parse(currentWeatherUrl));
      final forecastResponse = await http.get(Uri.parse(forecastUrl));

      if (currentWeatherResponse.statusCode != 200) {
        print('Error: ${currentWeatherResponse.statusCode} ${currentWeatherResponse.reasonPhrase}');
        throw Exception('Failed to load current weather');
      }
      if (forecastResponse.statusCode != 200) {
        print('Error: ${forecastResponse.statusCode} ${forecastResponse.reasonPhrase}');
        throw Exception('Failed to load forecast');
      }

      final currentWeatherData = json.decode(currentWeatherResponse.body);
      final forecastData = json.decode(forecastResponse.body);

      final currentWeather = Weather.fromJson(currentWeatherData);
      final forecast = (forecastData['list'] as List)
          .map((data) => Weather.fromJson(data))
          .toList();

      return WeatherData(currentWeather: currentWeather, forecast: forecast);
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load weather data');
    }
  }
}
