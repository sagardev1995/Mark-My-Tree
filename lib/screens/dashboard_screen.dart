// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_first_app/app_style.dart';
import 'login_screen.dart';
import 'view_pending_applications.dart';
import 'package:my_first_app/widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              color: kLightBgColor,
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
                        backgroundColor: kDashboardTextColor,
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
                    color: kDashboardTextColor),
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
                backgroundColor: kButtonBgColor,
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
                backgroundColor: kButtonBgColor,
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
