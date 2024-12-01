import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../services/service.dart';

class TvScreen extends StatefulWidget {
  @override
  _TvScreenState createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  bool isTvOn = false;
  List<double> tvUsageHistory = [];
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  // Fetch initial state and usage metrics
  Future<void> _fetchInitialData() async {
    try {
      final state = await _apiService.fetchDeviceState();
      setState(() {
        isTvOn = state['tv']['status'] == 'on';
      });

      final metrics = await _apiService.fetchMetrics();
      setState(() {
        tvUsageHistory = List<double>.from(metrics['tv']['metrics']);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data: $e')),
      );
    }
  }

  // Toggle TV state using the API
  Future<void> _toggleTv(bool value) async {
    try {
      final updatedState = await _apiService.toggleTV();
      setState(() {
        isTvOn = updatedState['devices']['tv']['status'] == 'on';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to toggle TV: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TV", style: TextStyle(fontSize: 23)),
        backgroundColor: const Color.fromARGB(255, 230, 228, 228),
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
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Mode"),
                  CupertinoSwitch(
                    value: isTvOn,
                    onChanged: (bool value) {
                      _toggleTv(value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            const Text(
              "TV Usage in the Last 12 Days",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 1.5,
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
                          if (value >= 0 && value < tvUsageHistory.length) {
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
                    tvUsageHistory.length,
                    (index) => BarChartGroupData(
                      x: index,
                      barsSpace: 4,
                      barRods: [
                        BarChartRodData(
                          toY: tvUsageHistory[index].toDouble(),
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
