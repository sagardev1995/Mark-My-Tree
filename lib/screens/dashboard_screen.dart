// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'pending_applications_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF41aa5f),
        toolbarHeight: 100,
        title: Row(
          children: [
            Image.asset(
              'assets/images/appbar-img-modified.png',
              width: 50,
              height: 70,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '           अंकन आदेश आवेदन पोर्टल',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  SizedBox(height: 2),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '   MARKING ORDER APPLICATION',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
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
          children: [
            Container(
              color: const Color(0xFFaae7bb),
              padding: const EdgeInsets.all(3),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      'Dashboard ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Spacer(), // Adds a spacer to push the logout button to the end
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF254c1f),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmation'),
                              content:
                                  Text('Are you sure you want to log out?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()),
                                    );
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Log out',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: 100,
            ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PendingApps()),
                );
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
              onPressed: () {},
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
