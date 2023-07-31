import 'package:http/http.dart' as http;
import 'dart:convert';

class VerificationTree {
  final int treeId;
  bool posingThreat;
  String photo;
  final String girth;
  bool actionForApproval;
  double xGpsCoordinate;
  double yGpsCoordinate;
  final String treeSpeciesLocalName;
  final String plotNo;
  // final int verificationPlotId;

  VerificationTree({
    required this.treeId,
    required this.posingThreat,
    required this.photo,
    required this.girth,
    required this.actionForApproval,
    required this.xGpsCoordinate,
    required this.yGpsCoordinate,
    required this.treeSpeciesLocalName,
    // required this.verificationPlotId,
    required this.plotNo,
  });
  Map<String, dynamic> toJson() {
    return {
      'treeId': treeId,
      'posingThreat': posingThreat,
      'photo': photo,
      'girth': girth,
      'actionForApproval': actionForApproval,
      'xGpsCoordinate': xGpsCoordinate,
      'yGpsCoordinate': yGpsCoordinate,
      'treeSpeciesLocalName': treeSpeciesLocalName,
      'plotNo': plotNo,
    };
  }



  factory VerificationTree.fromJson(Map<String, dynamic> json) {
    return VerificationTree(
      treeId: json['treeId'] as int,
      posingThreat: false,
      photo: json['photo'] == null ? '' : json['photo'],
      girth: json['girth'],
      actionForApproval: false,
      xGpsCoordinate:
          json['xGpsCoordinate'] == null ? 0 : json['xGpsCoordinate'],
      yGpsCoordinate:
          json['yGpsCoordinate'] == null ? 0 : json['yGpsCoordinate'],
      treeSpeciesLocalName: json['treeSpeciesId']['treeSpeciesLocalName'],
      plotNo: json['plotNo'],
      // verificationPlotId: json['verificationPlotId'],
    );
  }
}
// Function to convert the first item from the API list to a single VerificationTree object
// VerificationTree convertToSingleVerificationTree(List<Map<String, dynamic>> apiList) {
//   if (apiList.isEmpty) {
//     throw Exception('The list is empty');
//   }
//   return VerificationTree.fromJson(apiList.first);
// }

// Future<VerificationTree> fetchSingleVerificationTree() async {
//   final url = 'https://markmytree.nic.in/api/verificationTree'; // Replace with the actual API endpoint for fetching a single tree
//   final response = await http.get(Uri.parse(url));
//
//   if (response.statusCode == 200) {
//     final jsonData = json.decode(response.body);
//     return VerificationTree.fromJson(jsonData);
//   } else {
//     throw Exception('Failed to load single VerificationTree. Status code: ${response.statusCode}');
//   }
// }

Future<List<VerificationTree>> fetchVerificationTreeList() async {
  final url =
      'https://markmytree.nic.in/api/treesToBeVerified'; // Replace with the actual API endpoint for fetching a list of trees
  final response = await http.get(Uri.parse(url));
  print('Yaha');
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> jsonList =
        jsonData; // Assuming the API returns the list of trees in a key named 'data'
    List<VerificationTree> verificationTreeList = jsonList
        .map((json) => VerificationTree.fromJson(json))
        .take(5)
        .toList();

    return verificationTreeList;
  } else {
    throw Exception(
        'Failed to load VerificationTree list. Status code: ${response.statusCode}');
  }
}
