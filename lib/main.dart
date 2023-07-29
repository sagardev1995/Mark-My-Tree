import 'package:flutter/material.dart';
import 'package:my_first_app/models/treeDataScreen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'models/treesToBeVerified.dart';
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 6)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            return MyApp();
          }
        },
      ),
    ),
  );
}
