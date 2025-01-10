// viewmodels/weather_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/service/weather_service.dart';


class WeatherViewModel with ChangeNotifier {
  final WeatherApiService _weatherApiService = WeatherApiService();

  WeatherModel? _weatherData;
  bool _isLoading = false;
  String _errorMessage = '';

  WeatherModel? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _weatherData = await _weatherApiService.fetchWeather(cityName);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
