// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to green
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 180),
            Image.asset(
              'assets/images/splash-img.png',
              width: 300,
            ),
            const SizedBox(height: 50),
            const Text(
              "MARK MY TREE",
              style: TextStyle(
                fontSize: 35,
                color: Color(0xFF0AA034),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 80),
            const Text(
              "Forest Department",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF0AA034),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Government of Sikkim",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF0AA034),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
