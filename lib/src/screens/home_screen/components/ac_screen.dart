import 'package:flutter/material.dart';

class AcScreen extends StatefulWidget {
  const AcScreen({super.key});

  @override
  _AcScreenState createState() => _AcScreenState();
}

class _AcScreenState extends State<AcScreen> {
  bool isAcOn = true;
  double temperature = 22.0; // Default temperature in Celsius

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AC Control"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ac_unit_outlined,
              size: 100,
              color: isAcOn ? Colors.lightBlue : Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              isAcOn ? "AC is ON" : "AC is OFF",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isAcOn ? Colors.lightBlue : Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            if (isAcOn)
              Column(
                children: [
                  Text(
                    "Temperature: ${temperature.toStringAsFixed(1)}°C",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Slider(
                    value: temperature,
                    min: 16,
                    max: 30,
                    divisions: 14,
                    label: temperature.toStringAsFixed(1),
                    onChanged: (newTemperature) {
                      setState(() {
                        temperature = newTemperature;
                      });
                    },
                  ),
                ],
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isAcOn = !isAcOn;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isAcOn ? Colors.grey : Colors.lightBlue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: Text(
                isAcOn ? "Turn OFF" : "Turn ON",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
