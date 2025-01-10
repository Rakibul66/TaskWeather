// models/weather_model.dart
class WeatherModel {
  final String cityName;
  final double temperature;
  final String weatherCondition;
  final int humidity;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.weatherCondition,
    required this.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'],
      weatherCondition: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
    );
  }
}
