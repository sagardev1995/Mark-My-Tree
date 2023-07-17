// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'dashboard_screen.dart';
import 'package:my_first_app/app_style.dart';

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

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
                  color: kPrimaryColorLight,
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
                        BorderSide(color: kPrimaryColorLight, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(color: kPrimaryColorLight, width: 2.0),
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
                  color: kPrimaryColorLight,
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
                        BorderSide(color: kPrimaryColorLight, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(color: kPrimaryColorLight, width: 2.0),
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
                  color: kPrimaryColorLight,
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
                    backgroundColor: kPrimaryColorLight,
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
                      color: kTextColor,
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
