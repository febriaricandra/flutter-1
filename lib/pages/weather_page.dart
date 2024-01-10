import 'package:flutter/material.dart';
import 'package:learning_app/services/weather_service.dart';
import 'package:learning_app/models/weather_models.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService =
      WeatherService(apiKey: '8d885af329ee11988495d614a7e866e2');
  Weather? _weather;

  // fetch the weather
  _fetchWeather() async {
    final cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimations(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition) {
      case 'Clear':
        return 'assets/hot.json';
      case 'Clouds':
        return 'assets/cloud.json';
      case 'Rain':
        return 'assets/rainy.json';
      case 'Snow':
        return 'assets/cloud.json';
      case 'Thunderstorm':
        return 'assets/thunder.json';
      case 'Drizzle':
        return 'assets/hot.json';
      default:
        return 'assets/sunny.json';
    }
  }

  //init state
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //city name
              Text(_weather?.cityName ?? 'Loading...'),

              //animation
              Lottie.asset(getWeatherAnimations(_weather?.mainCondition)),
              //temperature and weather condition
              Text('${_weather?.tempreature.round().toString()}°C'),

              //weather condition
              Text(_weather?.mainCondition ?? "")
            ],
          ),
        ));
  }
}
