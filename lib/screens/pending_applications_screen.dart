// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:my_first_app/app_style.dart';
import 'package:my_first_app/screens/view_application_screen.dart';
import 'package:my_first_app/widgets/custom_appbar.dart';
import 'package:my_first_app/models/applicationDatadart';

class PendingApps extends StatefulWidget {
  @override
  _PendingAppsState createState() => _PendingAppsState();
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
      appBar: CustomAppBar(),
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
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight:
                              500), // Adjust the maxHeight value as needed
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
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
                                  DataCell(Text(data.applicationId.toString())),
                                  DataCell(Text(data.applicantFirstName)),
                                  DataCell(Text(data.formattedDate)),
                                  DataCell(Text(data.assignedTo)),
                                  DataCell(Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ApplicationDetailsScreen(
                                                        applicationData: data,
                                                      )));
                                        },
                                        child: Text('View'),
                                      ),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle verify button pressed
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: kPrimaryColorLight,
                                        ),
                                        child: Text(
                                          'Verify',
                                          style: TextStyle(color: kTextColor),
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
