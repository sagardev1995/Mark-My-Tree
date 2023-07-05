// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';

class PendingApps extends StatefulWidget {
  @override
  _PendingAppsState createState() => _PendingAppsState();
}

class ApplicationData {
  final int id;
  final String name;
  final DateTime date;
  final String pendingWith;
  ApplicationData({
    required this.id,
    required this.name,
    required this.date,
    required this.pendingWith,
  });
  String get formattedDate {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(date);
  }

  factory ApplicationData.fromJson(Map<String, dynamic> json) {
    return ApplicationData(
      id: json['applicationId'] ?? '',
      name: json['applicantFirstName'] ?? '',
      date: DateTime.parse(json['applicationDate'] ?? ''),
      pendingWith: json['assignedTo'] ?? '',
    );
  }
}

class _PendingAppsState extends State<PendingApps> {
  Future<List<ApplicationData>> fetchData() async {
    const apiUrl =
        'https://markmytree.nic.in/api/applicationsUserWise?UserName=roGangtok&ApplicationStatusId=AS';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['Application'] is List) {
          log("Hello");
          List<dynamic> applicationList = jsonData['Application'];
          List<ApplicationData> data = applicationList.map((item) {
            return ApplicationData.fromJson(item);
          }).toList();
          return data;
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
    return [];
  }

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
      body: FutureBuilder<List<ApplicationData>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final applicationData = snapshot.data!;
            return Column(
              children: [
                Container(
                  color: const Color(0xFFaae7bb),
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'PENDING APPLICATION',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('NAME')),
                        DataColumn(label: Text('DATE')),
                        DataColumn(label: Text('PENDING WITH')),
                        DataColumn(label: Text('ACTION')),
                      ],
                      rows: applicationData.map(
                        (data) {
                          return DataRow(
                            cells: [
                              DataCell(Text(data.id.toString())),
                              DataCell(Text(data.name)),
                              DataCell(Text(data.formattedDate)),
                              DataCell(Text(data.pendingWith)),
                              DataCell(Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle view button pressed
                                    },
                                    child: Text('View'),
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle verify button pressed
                                    },
                                    child: Text(
                                      'Verify',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF0AA034),
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
