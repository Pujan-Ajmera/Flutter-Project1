import 'package:flutter/material.dart';

import 'dashboard.dart';

class Initial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Use LayoutBuilder to create different images based on screen size
    return Scaffold(
      appBar: AppBar(
        title: Text("JeevanSathi", style: TextStyle(color: Colors.white)),
        actions: [
          Icon(Icons.wifi_2_bar, color: Colors.white),
          Icon(Icons.signal_cellular_alt, color: Colors.white),
          Icon(Icons.battery_1_bar, color: Colors.white),
          Text("13:00", style: TextStyle(color: Colors.white)),
        ],
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          // Display a different image based on screen width
          Positioned.fill(
            child: Image.asset(
              screenWidth > 800
                  ? "assets/images/initial_desktop_image.jpg"
                  : "assets/images/matrimony_start_image.jpg",
              fit: BoxFit.cover,
            ),
          ),
          // Center the button
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
              },
              label: Text("Get Started"),
              icon: Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }
}
