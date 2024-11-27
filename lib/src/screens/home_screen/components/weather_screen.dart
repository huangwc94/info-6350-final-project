import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool isWeatherOn = true;
  double temperature = 25.0; // Default temperature in Celsius
  String weatherCondition = "Sunny";
  String city = "New York";

  // Example function to simulate changing weather conditions
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wb_sunny_outlined, // Icon representing weather
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
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isWeatherOn = !isWeatherOn;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isWeatherOn ? Colors.grey : Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: Text(
                isWeatherOn ? "Turn OFF" : "Turn ON",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleWeatherCondition,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text(
                "Change Weather",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
