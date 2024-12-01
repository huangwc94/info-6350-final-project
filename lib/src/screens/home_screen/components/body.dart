import '../components/smart_device_box.dart';
import '../components/light_screen.dart';
import '../components/tv_screen.dart';
import '../components/weather_screen.dart';
import '../components/ac_screen.dart';
import 'package:flutter/material.dart';
import '../../../../services/service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ApiService _apiService = ApiService();
  String? _username;
  bool _isLoading = true;

  final List<List<dynamic>> mySmartDevices = [
    [
      "Light",
      Icons.lightbulb_outline,
      const Color.fromARGB(255, 250, 228, 85),
      true
    ],
    ["TV", Icons.tv_outlined, const Color.fromARGB(255, 244, 180, 219), true],
    [
      "Weather",
      Icons.thermostat,
      const Color.fromARGB(255, 212, 169, 250),
      true
    ],
    ["AC", Icons.ac_unit, const Color.fromARGB(255, 203, 245, 164), true],
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    try {
      final userInfo = await _apiService.fetchUserInfo();
      setState(() {
        _username = userInfo['username'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user info: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 25.0,
              ),
              child: Row(
                children: [
                  const Spacer(),
                  const Text(
                    'Smartly',
                    style: TextStyle(fontSize: 24),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.account_circle_outlined),
                    iconSize: 40.0,
                    color: const Color.fromARGB(255, 108, 76, 149),
                    onPressed: () {
                      Navigator.pushNamed(context, '/my_profile_screen');
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome Home,'),
                  Text(
                    _isLoading ? 'Loading...' : (_username ?? 'User'),
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 25.0,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Smart Devices',
                      style: TextStyle(fontSize: 24),
                    ),
                  ]),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: mySmartDevices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return SmartDeviceBox(
                    smartDeviceName: mySmartDevices[index][0] as String,
                    icon: mySmartDevices[index][1] as IconData,
                    backgroundColor: mySmartDevices[index][2] as Color,
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LightScreen()),
                        );
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TvScreen()),
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WeatherScreen()),
                        );
                      } else if (index == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AcScreen()),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 44),
          ],
        ),
      ),
    );
  }
}
