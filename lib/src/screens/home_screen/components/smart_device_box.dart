import 'package:flutter/material.dart';

class SmartDeviceBox extends StatelessWidget {
  final String smartDeviceName;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  const SmartDeviceBox({
    super.key,
    required this.smartDeviceName,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: 
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: backgroundColor,
              // color: Color.fromARGB(255, 250, 228, 85),
              borderRadius: BorderRadius.circular(24),
              
            ),
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50.0,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: 
                    Text(smartDeviceName),
                    ),
                ),
                
                
            ],),
          )
          )
    );
  }

}