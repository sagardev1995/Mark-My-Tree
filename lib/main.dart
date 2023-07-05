import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';

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
