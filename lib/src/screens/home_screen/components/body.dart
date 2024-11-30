import '../components/smart_device_box.dart';
import '../components/light_screen.dart';
import '../components/tv_screen.dart';
import '../components/weather_screen.dart';
import '../components/ac_screen.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? _username, _password;

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

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 10.0,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome Home,'),
                    Text(
                      'Ying',
                      style: TextStyle(fontSize: 24),
                    ),
                  ]),
            ),
            // const SizedBox(height: 44),
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
                              MaterialPageRoute(
                                  builder: (context) => TvScreen()),
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
                        });
                  }),
            ),

            const SizedBox(height: 44),
          ],
        ),
      ),
    );
  }
}


// import 'package:domus/config/size_config.dart';
// import 'package:domus/src/screens/home_screen/components/music_widget.dart';
// import 'package:domus/src/screens/home_screen/components/savings_container.dart';
// import 'package:domus/src/screens/home_screen/components/weather_container.dart';
// import 'package:domus/src/screens/set_event_screen/set_event_screen.dart';
// import 'package:domus/src/screens/smart_ac/smart_ac.dart';
// import 'package:domus/src/screens/smart_fan/smart_fan.dart';
// import 'package:domus/src/screens/smart_light/smart_light.dart';
// import 'package:domus/src/screens/smart_speaker/smart_speaker.dart';
// import 'package:domus/view/home_screen_view_model.dart';
// import 'package:domus/src/screens/smart_tv/smart_tv.dart';
// import 'package:flutter/material.dart';

// import 'add_device_widget.dart';
// import 'dark_container.dart';

// class Body extends StatelessWidget {
//   final HomeScreenViewModel model;
//   const Body({Key? key, required this.model}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: getProportionateScreenWidth(7),
//           vertical: getProportionateScreenHeight(7),
//         ),
//         decoration: const BoxDecoration(
//           color: Color(0xFFF2F2F2),
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(getProportionateScreenHeight(5)),
//               child: WeatherContainer(model: model),
//             ),
//             Padding(
//               padding: EdgeInsets.all(getProportionateScreenHeight(5)),
//               child: SavingsContainer(model: model),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.all(getProportionateScreenHeight(5)),
//                     child: DarkContainer(
//                       itsOn: model.isLightOn,
//                       switchButton: model.lightSwitch,
//                       onTap: () {
//                         Navigator.of(context).pushNamed(SmartLight.routeName);
//                       },
//                       iconAsset: 'assets/icons/svg/light.svg',
//                       device: 'Lightening',
//                       deviceCount: '4 lamps',
//                       switchFav: model.lightFav,
//                       isFav: model.isLightFav,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.all(getProportionateScreenHeight(5)),
//                     child: DarkContainer(
//                       itsOn: model.isACON,
//                       switchButton: model.acSwitch,
//                       onTap: () {
//                         Navigator.of(context).pushNamed(SmartAC.routeName);
//                       },
//                       iconAsset: 'assets/icons/svg/ac.svg',
//                       device: 'AC',
//                       deviceCount: '4 devices',
//                       switchFav: model.acFav,
//                       isFav: model.isACFav,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.all(getProportionateScreenHeight(5)),
//               child: const MusicWidget(),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.all(getProportionateScreenHeight(5)),
//                     child: DarkContainer(
//                       itsOn: model.isSpeakerON,
//                       switchButton: model.speakerSwitch,
//                       onTap: () {
//                         Navigator.of(context).pushNamed(SmartSpeaker.routeName);
//                       },
//                       iconAsset: 'assets/icons/svg/speaker.svg',
//                       device: 'Speaker',
//                       deviceCount: '1 device',
//                       switchFav: model.speakerFav,
//                       isFav: model.isSpeakerFav,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.all(getProportionateScreenHeight(5)),
//                     child: DarkContainer(
//                       itsOn: model.isFanON,
//                       switchButton: model.fanSwitch,
//                       onTap: () {
//                         Navigator.of(context).pushNamed(SmartFan.routeName);
//                       },
//                       iconAsset: 'assets/icons/svg/fan.svg',
//                       device: 'Fan',
//                       deviceCount: '2 devices',
//                       switchFav: model.fanFav,
//                       isFav: model.isFanFav,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.all(getProportionateScreenHeight(8)),
//               child: const AddNewDevice(),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed(SetEventScreen.routeName);
//               },
//               child: const Text(
//                 'To SetEventScreen',
//                 style: TextStyle(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed(SmartTV.routeName);
//               },
//               child: const Text(
//                 'Smart TV Screen',
//                 style: TextStyle(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
