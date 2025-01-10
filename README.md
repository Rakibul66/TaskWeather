# Weather App with Rive Animation

This is a weather app that provides real-time weather information based on the city entered by the user. The app integrates Rive animations for a more interactive UI and changes the background and icons based on the temperature and weather condition.

## Features

- **Rive Animation**: The background and icons change dynamically based on the temperature and weather condition (e.g., sunny, cloudy).
- **API Integration**: Uses the OpenWeather API to fetch weather data.
- **State Management**: Managed using **Provider** for efficient state handling.
- **UI Design**: Basic UI setup with animations for a better user experience.
- **Functional**: Provides essential weather information including temperature, weather condition, humidity, etc.

## Checklist

### UI Design
- A basic UI is created with Rive animation.
- The background changes based on the temperature.
- The weather condition changes the icon (e.g., sunny, cloudy) based on the current weather.

### API Integration
- **OpenWeather API** is integrated to fetch weather data.
  - API URL: `https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$_apiKey`

### State Management
- **Provider** is used for state management to ensure smooth handling of the data.

### Coding Standards
- Every line and variable is meaningful and easy to modify.
- Separated widgets, UI, and components for better code understanding and maintainability.

## Functionality

- **City Search**: When the user enters a city name and presses the "Search" button, the app fetches the weather data from the OpenWeather API.
- **Weather Data Display**:
  - **City Name**
  - **Temperature**
  - **Weather Condition** (e.g., sunny, rainy, cloudy)
  - **Humidity Level**

# Weather App

Here is a demonstration of the app:

[![Watch the video](https://img.youtube.com/vi/e4_DJIvsVLY/0.jpg)](https://youtube.com/shorts/e4_DJIvsVLY)


## Installation

1. Clone the repository:

   git clone https://github.com/your-username/weather-app.git

Navigate to the project directory:
cd weather-app

Install dependencies:
flutter pub get

Run the app:
flutter run


API Key Setup
To use the OpenWeather API, you need to get an API key. Follow these steps:

Go to OpenWeather.
Sign up and generate an API key.
Replace $_apiKey in your project with your generated API key.

