import 'package:flutter/material.dart';
import 'package:my_first_app/models/applicationData.dart';
import 'package:my_first_app/widgets/custom_appbar.dart';
import 'package:my_first_app/app_style.dart';

class ApplicationDetailsScreen extends StatelessWidget {
  final ApplicationData applicationData;

  const ApplicationDetailsScreen({super.key, required this.applicationData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PERSONAL INFORMATION',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoItem('First Name', applicationData.applicantFirstName),
            _buildInfoItem('Middle Name', applicationData.applicantMiddleName),
            _buildInfoItem('Last Name', applicationData.applicantLastName),
            _buildInfoItem(
              "Father's/Husband's Name",
              applicationData.applicantFatherName,
            ),
            const SizedBox(height: 20),
            const Text(
              'PERMANENT ADDRESS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoItem('Address 1', applicationData.permanent1Address),
            _buildInfoItem('Address 2', applicationData.permanent2Address),
            _buildInfoItem(
                'District', applicationData.permanentAddressDistrict),
            _buildInfoItem('Block', applicationData.permanentAddressBlock),
            _buildInfoItem('GPU', applicationData.permanentAddressGPU),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: kPrimaryColorLight,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
