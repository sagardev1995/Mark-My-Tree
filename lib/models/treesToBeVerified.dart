import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TreesToBeVerifiedData{
  final int treeId;
  final String girth;
  final String plotNo;
  final int applicationId;
  final int treeSpeciesId;
  final String treeClass;
  final String treeSpeciesLocalName;
  final String treeSpeciesScientificName;
  TreesToBeVerifiedData({required this.treeId,required this.girth,required this.plotNo,required this.applicationId,required this.treeSpeciesId,required this.treeClass,required this.treeSpeciesLocalName,required this.treeSpeciesScientificName});
}










Future<List<dynamic>> fetchData() async {
  final response = await http.get(Uri.parse('https://markmytree.nic.in/api/treesToBeVerified'));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    final jsonData = json.decode(response.body);
    List<TreesToBeVerifiedData> treesData = jsonData.map<TreesToBeVerifiedData>((data) {
      return TreesToBeVerifiedData(
        treeId: data['treeId'],
        girth: data['girth'],
        plotNo: data['plotNo'],
        applicationId: data['applicationId']['applicationId'],
        treeSpeciesId: data['treeSpeciesId']['treeSpeciesId'],
        treeClass: data['treeSpeciesId']['treeClass'],
        treeSpeciesLocalName: data['treeSpeciesId']['treeSpeciesLocalName'],
        treeSpeciesScientificName: data['treeSpeciesId']['treeSpeciesScientificName'],
      );
    }).toList();
    return treesData;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load data from API');
  }
}

