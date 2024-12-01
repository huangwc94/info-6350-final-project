import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../services/service.dart';

class LightScreen extends StatefulWidget {
  const LightScreen({super.key});

  @override
  _LightScreenState createState() => _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
  bool isLightOn = false;
  List<double> lightMetrics = [];
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  // Fetch the initial state and metrics from the API
  Future<void> _fetchInitialData() async {
    try {
      final state = await _apiService.fetchDeviceState();
      setState(() {
        isLightOn = state['light']['status'] == 'on';
      });

      final metrics = await _apiService.fetchMetrics();
      setState(() {
        lightMetrics = List<double>.from(metrics['light']['metrics']);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data: $e')),
      );
    }
  }

  // Function to toggle the light using the API
  Future<void> _toggleLight(bool value) async {
    try {
      final updatedState = await _apiService.toggleLight();
      setState(() {
        isLightOn = updatedState['devices']['light']['status'] == 'on';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to toggle light: $e')),
      );
    }
  }

  // Prepare data for the bar chart
  List<BarChartGroupData> _prepareChartData() {
    List<BarChartGroupData> barChartData = [];
    for (int i = 0; i < lightMetrics.length; i++) {
      barChartData.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: lightMetrics[i].toDouble(),
              color: Colors.yellow, // Light ON color
            ),
          ],
        ),
      );
    }
    return barChartData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Light",
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: const Color.fromARGB(255, 230, 228, 228),
      ),
      body: Container(
        color: const Color.fromARGB(255, 230, 228, 228),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Light Icon and Button
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Mode"),
                  CupertinoSwitch(
                    value: isLightOn, // The current state of the switch
                    onChanged: (bool value) {
                      _toggleLight(
                          value); // Call the toggle function when switch is toggled
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Usage History (Last 12 Days):",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 10, // Set this based on the expected range
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barGroups: _prepareChartData(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
