import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:weatherapp/viewmodel/weather_viewmodel.dart';
import 'package:weatherapp/widget/city_search_widget.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);

    // Fetch weather data for Dhaka if not already fetched
    if (weatherViewModel.weatherData == null) {
      weatherViewModel.fetchWeather('Dhaka'); // Default city "Dhaka"
    }

    // Function to show the search modal
    void _showSearchModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => CitySearchModal(
          onCitySearched: (cityName) {
            // Call the API to fetch weather for the searched city
            weatherViewModel.fetchWeather(cityName); // Fetch weather based on the searched city
          },
        ),
      );
    }

    // Function to get the weather animation (for the body) based on temperature
    Widget getWeatherAnimation(double temperature) {
      if (temperature <= 0) {
        return RiveAnimation.asset('assets/rain.riv'); // Snow animation for cold weather
      } else if (temperature > 0 && temperature <= 15) {
        return RiveAnimation.asset('assets/cloudsun.riv'); // Cloudy animation for cool weather
      } else if (temperature > 15 && temperature <= 30) {
        return RiveAnimation.asset('assets/cloudsun.riv'); // Sunny animation for moderate weather
      } else {
        return RiveAnimation.asset('assets/cloudsun.riv'); // Hot weather animation
      }
    }

    // Function to get the background animation based on temperature
    Widget getWeatherBackground(double temperature) {
      if (temperature <= 0) {
        return RiveAnimation.asset('assets/snow_bg.riv', fit: BoxFit.cover); // Snow background
      } else if (temperature > 0 && temperature <= 15) {
        return RiveAnimation.asset('assets/hashigo.riv', fit: BoxFit.cover); // Cloudy background
      } else if (temperature > 15 && temperature <= 30) {
        return RiveAnimation.asset('assets/sunny_bg.riv', fit: BoxFit.cover); // Sunny background
      } else {
        return RiveAnimation.asset('assets/hashigo.riv', fit: BoxFit.cover); // Hot weather background
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        backgroundColor: Colors.blue,
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _showSearchModal(context), // Show search modal on button click
          ),
        ],
      ),
      body: Stack(
        children: [
          // Dynamic background animation based on temperature
          Positioned.fill(
            child: weatherViewModel.weatherData != null
                ? getWeatherBackground(weatherViewModel.weatherData!.temperature)
                : Center(child: CircularProgressIndicator()),
          ),
          // Foreground content (weather details)
          Center(
            child: weatherViewModel.isLoading
                ? CircularProgressIndicator() // Show loading indicator while fetching weather data
                : weatherViewModel.weatherData != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: getWeatherAnimation(weatherViewModel.weatherData!.temperature),
                          ),
                          SizedBox(height: 20),
                          // Full width transparent glassmorphism card
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1), // Transparent background
                              borderRadius: BorderRadius.circular(20), // Rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0), // Blur effect
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'City: ${weatherViewModel.weatherData!.cityName}',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Temperature: ${weatherViewModel.weatherData!.temperature}°C',
                                        style: TextStyle(fontSize: 16, color: Colors.white),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Condition: ${weatherViewModel.weatherData!.weatherCondition}',
                                        style: TextStyle(fontSize: 16, color: Colors.white),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Humidity: ${weatherViewModel.weatherData!.humidity}%',
                                        style: TextStyle(fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Search for a city to see the weather!',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
          ),
        ],
      ),
    );
  }
}
