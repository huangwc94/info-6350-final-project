import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LightScreen extends StatefulWidget {
  const LightScreen({super.key});

  @override
  _LightScreenState createState() => _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
  bool isLightOn = false;
  List<Map<String, dynamic>> usageHistory = [];

  // Function to toggle the light and add usage history
  void toggleLight(bool value) {
    setState(() {
      isLightOn = value; // Update the light status based on the switch value
    });
  }

  // Function to prepare the data for the bar chart (usage in the last 12 days)
  List<BarChartGroupData> _prepareChartData() {
    // Get the current date and filter entries from the last 12 days
    DateTime currentDate = DateTime.now();
    List<Map<String, dynamic>> filteredData = usageHistory.where((entry) {
      DateTime entryDate = entry['timestamp'];
      return currentDate.difference(entryDate).inDays <= 12;
    }).toList();

    // Initialize the counts for ON/OFF for each day
    Map<int, int> onCountPerDay = {};
    Map<int, int> offCountPerDay = {};

    // Count the usage for ON and OFF per day
    for (var entry in filteredData) {
      int day = entry['timestamp'].day;
      if (entry['status'] == 'ON') {
        onCountPerDay[day] = (onCountPerDay[day] ?? 0) + 1;
      } else {
        offCountPerDay[day] = (offCountPerDay[day] ?? 0) + 1;
      }
    }

    // Prepare the data for the bar chart
    List<BarChartGroupData> barChartData = [];
    for (int i = 1; i <= 12; i++) {
      barChartData.add(
        BarChartGroupData(
          x: i - 1,
          barRods: [
            BarChartRodData(
              toY: (onCountPerDay[i] ?? 0).toDouble(),
              color: Colors.yellow, // Light ON color
            ),
            BarChartRodData(
              toY: (offCountPerDay[i] ?? 0).toDouble(),
              color: Colors.grey, // Light OFF color
            ),
          ],
          showingTooltipIndicators: [0, 1],
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
                      toggleLight(
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
