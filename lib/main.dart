// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

void main() {
  runApp(
    MaterialApp(
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Image.asset(
              'assets/images/login-img.png',
              width: 250,
            ),
            const SizedBox(height: 70),
            const Padding(
              padding: EdgeInsets.only(
                right: 245,
              ),
              child: Text(
                'Username',
                style: TextStyle(
                  fontSize: 19,
                  color: Color(0xFF0AA034),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(color: Color(0xFF0AA034), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(color: Color(0xFF0AA034), width: 2.0),
                  ),
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(right: 245),
              child: Text(
                'Password',
                style: TextStyle(
                  fontSize: 19,
                  color: Color(0xFF0AA034),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(color: Color(0xFF0AA034), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(color: Color(0xFF0AA034), width: 2.0),
                  ),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFF0AA034),
                ),
                child: TextButton(
                  onPressed: () {
                    String username = usernameController.text;
                    String password = passwordController.text;
                    log("Username: " +
                        username +
                        "\t" +
                        "Password: " +
                        password);
                    loginUser(context, username, password);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Color(0xFF0AA034),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    // Add shadow
                    elevation: 2,
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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

Future<void> loginUser(
    BuildContext context, String username, String password) async {
  var url = Uri.parse(
      'https://markmytree.nic.in/api/departmentalUserLogin'); // Replace with your backend URL
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      checkCredentials(context, username, password, response.body);
    }
  } catch (e) {
    // Handle API request error
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Failed to connect to the server.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

void checkCredentials(BuildContext context, String enteredUsername,
    String enteredPassword, String responseJson) {
  // Parse the JSON response into a list of user objects
  List<dynamic> users = jsonDecode(responseJson);

  // Iterate through each user object
  for (var user in users) {
    // Extract the username and password from the user object
    String username = user['userName'];
    String password = user['password'];

    // Compare the entered username and password with the extracted values
    if (username == enteredUsername && password == enteredPassword) {
      // Credentials match
      log('Credentials are correct!');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      return;
    }
  }

  // Invalid credentials
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Login Error'),
      content: Text('Incorrect username or password.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xFF41aa5f),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/appbar-img-modified.png',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '      अंकन आदेश आवेदन पोर्टल',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'MARKING ORDER APPLICATION',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(width: 2),
            Image.asset(
              'assets/images/login-img.png',
              width: 60,
              height: 60,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'DASHBOARD',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF254c1f)),
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 2.0,
              height: 5,
              indent: 100,
              endIndent: 100,
            ),
            SizedBox(height: 30, width: 0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF41aa5f),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              ),
              onPressed: () {
                // TODO: Handle pending applications button press
              },
              child: Text(
                'PENDING APPLICATIONS',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF41aa5f),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              ),
              onPressed: () {
                // TODO: Handle verified applications button press
              },
              child: Text(
                'VERIFIED APPLICATIONS',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
