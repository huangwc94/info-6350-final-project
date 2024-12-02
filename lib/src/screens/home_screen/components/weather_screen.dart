import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool isWeatherOn = true;
  double temperature = 9.0; // Default temperature in Celsius
  String weatherCondition = "Cloudy";
  String city = "Seattle";

  void toggleWeatherCondition() {
    setState(() {
      if (weatherCondition == "Sunny") {
        weatherCondition = "Rainy";
        temperature = 18.0;
      } else if (weatherCondition == "Rainy") {
        weatherCondition = "Cloudy";
        temperature = 22.0;
      } else {
        weatherCondition = "Sunny";
        temperature = 25.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Control"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wb_sunny_outlined,
              size: 100,
              color: isWeatherOn ? Colors.orange : Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              "Weather in $city",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isWeatherOn ? Colors.blueAccent : Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Condition: $weatherCondition",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isWeatherOn ? Colors.blueAccent : Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Temperature: ${temperature.toStringAsFixed(1)}°C",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 60),
          ],
        )),
      ),
    );
  }
}
