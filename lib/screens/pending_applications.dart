import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/models/verification_tree.dart';
import 'package:my_first_app/models/rule_6.dart';
import 'package:my_first_app/widgets/custom_appbar.dart';

class PendingApplication extends StatefulWidget {
  PendingApplication();

  @override
  _PendingApplicationState createState() => _PendingApplicationState();
}

class _PendingApplicationState extends State<PendingApplication> {
  String _temporaryXGpsCoordinate = '';
  String _temporaryYGpsCoordinate = '';
  late List<Rule6> rule6List = [];
  String applicationNo = '809087892';
  String plotNo = '283"23"';
  List<String> selectedRule6Ids = [];
  //I've used this model to fetch verification tree list as table row data
  late List<VerificationTree> verificationTreeList = [];
  List<String> _dropDownValues = ["Yes", "No"];
  int index = 0;

  @override
  void initState() {
    super.initState();
    getVerificationTreeDetails();
    // rule6List = widget.rule6List;
    print('here');

    fellingTreeConditions();
  }

  //region Future Void fuinctions to 1.handle file upload 2. Fetch list of Rule 6 2.

  //Since in this page few data are static like tree name, application no. plot no etc.
  //find out the correct api which will fetch all data like tree name, plot no, application no etc.
  //And this page should submit and go to the next one when and only all image in data row are uploaded
  Future<void> _handleFileUpload(int tree_id) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg'],
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result
          .files.first; // Use the first file if multiple files are allowed

      // Read the PDF file and convert it to base64
      List<int> fileBytes = await File(file.path!).readAsBytes();
      String base64String = base64Encode(fileBytes);
      print(base64String);
      // Now you can update the value of the 'tree photo' field
      // Assuming you have a 'treeList' containing the tree details
      // Find the tree with the specified 'tree_id' and update the 'tree photo' field
      VerificationTree treeToUpdate =
          verificationTreeList.firstWhere((tree) => tree.treeId == tree_id);
      if (treeToUpdate != null) {
        print('tree is not null');
        treeToUpdate.photo = base64String;
        print(treeToUpdate.photo);
        // setState(() {
        //   // Call setState to trigger a UI update with the updated tree details
        // });
      }
    } else {
      // User canceled the file picker or no file was selected
    }
  }

  void getVerificationTreeDetails() async {
    //The below function fetchVerificationTreeList is defined in  verification_tree.dart file
    verificationTreeList = await fetchVerificationTreeList();
    setState(() {
      verificationTreeList = verificationTreeList;
    });
  }

  Future<void> fellingTreeConditions() async {
    try {
      final response = await http.get(
          Uri.parse('https://markmytree.nic.in/api/fellingTreeConditions'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          // applicationNo = jsonData['applicationNo'];
          // plotNo = jsonData['plotNo'];
          rule6List =
              List.from(jsonData).map((item) => Rule6.fromJson(item)).toList();
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              children: [
                Container(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Application no:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black38.withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                applicationNo,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Plot no:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black38.withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                plotNo,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 6, child: Text("Rule6 Ids")),
                    Expanded(flex: 4, child: Center(child: Text("Action"))),
                  ],
                ),
                SizedBox(height: 20),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: rule6List.length,
                  itemBuilder: (BuildContext context, int index) {
                    final rule = rule6List[index];
                    return Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38, width: 0.3),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white30),
                      margin: EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text(
                              rule.description,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(letterSpacing: 1),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 4,
                            child: Center(
                              child: Checkbox(
                                value: rule.isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    rule.isChecked = value ?? false;

                                    // If the checkbox is checked, add the Rule6 ID to the selectedRule6Ids array
                                    if (value == true) {
                                      selectedRule6Ids.add(rule.id);
                                    } else {
                                      // If the checkbox is unchecked, remove the Rule6 ID from the selectedRule6Ids array
                                      selectedRule6Ids.remove(rule.id);
                                    }
                                  });
                                  print(selectedRule6Ids.toString());
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "All fields marked as (*) below are mandatory",
                  style: TextStyle(color: Colors.red),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text('Species Name'),
                            ),
                            DataColumn(label: Text('Plot No')),
                            DataColumn(
                              label: Row(
                                children: [
                                  Text('Girth(In Feet)'),
                                  Text('*',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                            DataColumn(
                              label: Text('Posing Threat'),
                            ),
                            DataColumn(
                              label: Row(
                                children: [
                                  Text('Image'),
                                  Text('*',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                            DataColumn(
                              label: Row(
                                children: [
                                  Text('Approve'),
                                  Text('*',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                            DataColumn(
                              label: Row(
                                children: [
                                  Text('X GPS Coordinate'),
                                  Text('*',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                            DataColumn(
                              label: Row(
                                children: [
                                  Text('Y GPS Coordinate'),
                                  Text('*',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                            DataColumn(
                              label: Row(
                                children: [
                                  Text('Verification Plot ID'),
                                  Text('*',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                            DataColumn(
                              label: Row(
                                children: [
                                  Text('Action'),
                                  Text('*',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                          rows: verificationTreeList.map((tree) {
                            VerificationTree _tree = tree;
                            return DataRow(
                              cells: <DataCell>[
                                DataCell(Text('${tree.treeSpeciesLocalName}')),
                                DataCell(Text('${tree.plotNo}')),
                                DataCell(Text('${tree.girth}')),
                                DataCell(
                                  DropdownButtonFormField<bool>(
                                    // Use _selectedDistrictId as the value
                                    value: _tree.posingThreat,
                                    items: _dropDownValues.map((val) {
                                      return DropdownMenuItem<bool>(
                                        value: val == "Yes" ? true : false,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        _tree.posingThreat != newValue;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select a district';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                DataCell(
                                  OutlinedButton(
                                    onPressed: () {
                                      _handleFileUpload(tree.treeId);
                                    },
                                    child: Text('upload'),
                                  ),
                                ),
                                DataCell(
                                  DropdownButtonFormField<bool>(
                                    // Use _selectedDistrictId as the value
                                    value: _tree.actionForApproval,
                                    items: _dropDownValues.map((val) {
                                      return DropdownMenuItem<bool>(
                                        value: val == "Yes" ? true : false,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        _tree.actionForApproval != newValue;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select a district';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                DataCell(
                                  TextFormField(
                                    initialValue: '${tree.xGpsCoordinate}',
                                    onChanged: (value) {
                                      setState(() {
                                        // Update the temporary xGpsCoordinate variable when the user enters text
                                        _temporaryXGpsCoordinate = value;
                                      });
                                    },
                                  ),
                                ),
                                DataCell(
                                  TextFormField(
                                    initialValue: '${tree.yGpsCoordinate}',
                                    onChanged: (value) {
                                      setState(() {
                                        // Update the temporary yGpsCoordinate variable when the user enters text
                                        _temporaryYGpsCoordinate = value;
                                      });
                                    },
                                  ),
                                ),
                                DataCell(Text('${tree.plotNo}')),
                                DataCell(ElevatedButton(
                                  child: Text("Save"),
                                  onPressed: () {
                                    // verificationTreeList[];
                                  },
                                )),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            // _handleFileUpload();
          },
          child: Text('GO NEXT'),
        ),
        ElevatedButton(
          onPressed: (selectedRule6Ids.isNotEmpty ||
                  verificationTreeList!.every(
                      (tree) => tree.photo != null && tree.photo!.isNotEmpty))
              ? () {
                  // Handle SUBMIT button press
                  // Only proceed if there are selectedRule6Ids
                }
              : null,
          child: Text('SUBMIT'),
        ),
      ],
    );
  }
}
