import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:my_first_app/widgets/custom_appbar.dart';

class VerificationPart2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: WelcomePage(),
      ),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? attachManagementPlanOption;
  String? attachVerificationReportOption;
  File? selectedManagementPlanPdf;
  File? selectedVerificationReportPdf;
  String remarks = '';

  void pickManagementPlanPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      setState(() {
        selectedManagementPlanPdf = File(file.path!);
      });

      List<int> fileBytes = await File(file.path!).readAsBytes();
      String base64String = base64Encode(fileBytes);
      print(base64String);

      // Replace 'desired/file/path/example.pdf' with the desired file name and path to save the PDF file
      File decodedFile =
      decodePdfFromBase64(base64String, 'desired/file/path/example.pdf');
      print('Decoded PDF file path: ${decodedFile.path}');
    } else {
      // User canceled the file picker or no file was selected
    }
  }

  void pickVerificationReportPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      setState(() {
        selectedVerificationReportPdf = File(file.path!);
      });

      List<int> fileBytes = await File(file.path!).readAsBytes();
      String base64String = base64Encode(fileBytes);
      print(base64String);

      // Replace 'desired/file/path/verification.pdf' with the desired file name and path to save the PDF file
      File decodedFile = decodePdfFromBase64(
          base64String, 'desired/file/path/verification.pdf');
      print('Decoded PDF file path: ${decodedFile.path}');
    } else {
      // User canceled the file picker or no file was selected
    }
  }

  File decodePdfFromBase64(String base64String, String filePath) {
    List<int> bytes = base64Decode(base64String);
    File pdfFile = File(filePath); // Use the provided file path
    pdfFile.writeAsBytesSync(bytes);
    return pdfFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        // Make the page scrollable
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF41aa5f),
                    ),
                    child: Text('GO BACK'),
                  ),
                  Text(
                    'VERIFICATION INFORMATION - PART 2',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Attach management Plan (If required)',
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Yes',
                        groupValue: attachManagementPlanOption,
                        onChanged: (value) {
                          setState(() {
                            attachManagementPlanOption = value;
                          });
                        },
                      ),
                      Text('Yes'),
                      Radio<String>(
                        value: 'No',
                        groupValue: attachManagementPlanOption,
                        onChanged: (value) {
                          setState(() {
                            attachManagementPlanOption = value;
                          });
                        },
                      ),
                      Text('No'),
                    ],
                  ),
                  if (attachManagementPlanOption == 'Yes')
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: pickManagementPlanPdf,
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF41aa5f),
                          ),
                          child: Text('Choose File'),
                        ),
                        SizedBox(height: 10),
                        if (selectedManagementPlanPdf != null)
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Selected Management Plan PDF: ${selectedManagementPlanPdf!.path}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Attach Verification report from Forest Guard (If any)',
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Yes',
                        groupValue: attachVerificationReportOption,
                        onChanged: (value) {
                          setState(() {
                            attachVerificationReportOption = value;
                          });
                        },
                      ),
                      Text('Yes'),
                      Radio<String>(
                        value: 'No',
                        groupValue: attachVerificationReportOption,
                        onChanged: (value) {
                          setState(() {
                            attachVerificationReportOption = value;
                          });
                        },
                      ),
                      Text('No'),
                    ],
                  ),
                  if (attachVerificationReportOption == 'Yes')
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: pickVerificationReportPdf,
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF41aa5f),
                          ),
                          child: Text('Choose File'),
                        ),
                        SizedBox(height: 10),
                        if (selectedVerificationReportPdf != null)
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Selected Verification Report PDF: ${selectedVerificationReportPdf!.path}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remarks',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        remarks = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your remarks',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement button functionality
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF41aa5f),
                ),
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFViewerPage extends StatelessWidget {
  final String pdfFilePath;

  PDFViewerPage(this.pdfFilePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfFilePath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onRender: (pages) {
          print("PDF is rendered with $pages pages!");
        },
        onError: (error) {
          print("Error occurred during PDF rendering: $error");
        },
        onPageChanged: (int? page, int? total) {
          if (page != null && total != null) {
            print('Page $page of $total');
          }
        },
      ),
    );
  }
}