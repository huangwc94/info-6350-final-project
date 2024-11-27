import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import CupertinoSwitch
import 'package:fl_chart/fl_chart.dart';

class TvScreen extends StatefulWidget {
  @override
  _TvScreenState createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  bool isTvOn = true; // The current state of the switch

  // Sample data for the last 12 days (Usage in hours)
  final List<int> usageHistory = [3, 2, 4, 1, 5, 6, 3, 4, 2, 3, 1, 5];

  // Function to toggle the switch
  void toggleTv(bool value) {
    setState(() {
      isTvOn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TV",
          style:TextStyle(fontSize: 23)
        ),
        backgroundColor: Color.fromARGB(255, 230, 228, 228),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color.fromARGB(255, 230, 228, 228),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mode"),
                  CupertinoSwitch(
                    value: isTvOn, // The current state of the switch
                    onChanged: (bool value) {
                      toggleTv(value); // Call the toggle function when switch is toggled
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            Text(
              "TV Usage in the Last 12 Days",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 1.5, // Controls the chart's aspect ratio
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: true),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (double value) {
                        // Display the last 12 days as labels
                        return 'Day ${value.toInt() + 1}';
                      },
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  barGroups: List.generate(
                    12,
                    (index) => BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          y: usageHistory[index].toDouble(),
                          colors: [Colors.blueAccent],
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
