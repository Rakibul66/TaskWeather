// services/weather_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/model/weather_model.dart';


class WeatherApiService {
  final String _apiKey = 'b35dfc2b52b5544eb0bc7264ad178211';

  Future<WeatherModel> fetchWeather(String cityName) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$_apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return WeatherModel.fromJson(jsonData);
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['message'] ?? 'Unknown error occurred';
        throw Exception('API Error: $errorMessage');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data. Error: $e');
    }
  }
}
