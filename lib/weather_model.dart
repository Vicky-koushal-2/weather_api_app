import 'package:hive/hive.dart';

part 'weather_model.g.dart';



@HiveType(typeId: 0)
class Weather extends HiveObject {
  @HiveField(0)
  final String date;
  @HiveField(1)
  final double temperature;
  @HiveField(2)
  final String description;

  Weather({required this.date, required this.temperature, required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      date: json['dt_txt'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}

class WeatherData {
  final Weather currentWeather;
  final List<Weather> forecast;

  WeatherData({required this.currentWeather, required this.forecast});
}
