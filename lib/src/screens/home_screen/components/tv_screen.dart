import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
        title: Text("TV", style: TextStyle(fontSize: 23)),
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
                      toggleTv(
                          value); // Call the toggle function when switch is toggled
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
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          if (value >= 0 && value < 12) {
                            return Text(
                              'Day ${value.toInt() + 1}',
                              style: const TextStyle(fontSize: 12),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  barGroups: List.generate(
                    12,
                    (index) => BarChartGroupData(
                      x: index,
                      barsSpace: 4,
                      barRods: [
                        BarChartRodData(
                          toY: usageHistory[index].toDouble(),
                          color: Colors.blueAccent,
                          width: 16,
                          borderRadius: BorderRadius.circular(6),
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
