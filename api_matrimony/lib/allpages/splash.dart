import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dashboard.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async{
    await Future.delayed(Duration(milliseconds: 5000),() {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              color: Colors.pinkAccent,
              size: 100,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Matrimony Connect",
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Finding Your Perfect Match",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 40),
            SpinKitWave(
              color: Colors.pinkAccent,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
