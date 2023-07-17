import 'package:intl/intl.dart';
class ApplicationData {
  final int applicationId;
  final String applicantName;
  final String applicationNo;
  final DateTime applicationDate;
  final String applicantFirstName;
  final String applicantMiddleName;
  final String applicantLastName;
  final String applicantFatherName;
  final String permanent1Address;
  final String permanent2Address;
  final String permanentAddressDistrict;
  final String permanentAddressBlock;
  final String permanentAddressGPU;
  final String residentialAddress1;
  final String residentialAddress2;
  final String residentialAddressDistrict;
  final String residentialAddressBlock;
  final String residentialAddressGPU;
  final bool perResAddSame;
  final String parcha;
  final bool parchaInNameOfApplicant;
  final String noc;
  final String dateOfLastMo;
  final String lastMO;
  final String rangeId;
  final String purposeOther;
  final String nameOfUser;
  final String relationWithApplicant;
  final String placeWhereProduceIsToBeUsed;
  final String closestForestNursery;
  final String managementPlan;
  final String assignedTo;
  final String markingOrderNo;
  final String verificationScheduleDate;
  final String purposeId;
  final String applicationStatusId;
  final String authorizationId;
  final int applicantId;

  ApplicationData(
      {required this.applicationId,
      required this.applicantName,
      required this.applicationNo,
      required this.applicationDate,
      required this.applicantFirstName,
      required this.applicantMiddleName,
      required this.applicantLastName,
      required this.applicantFatherName,
      required this.permanent1Address,
      required this.permanent2Address,
      required this.permanentAddressDistrict,
      required this.permanentAddressBlock,
      required this.permanentAddressGPU,
      required this.residentialAddress1,
      required this.residentialAddress2,
      required this.residentialAddressDistrict,
      required this.residentialAddressBlock,
      required this.residentialAddressGPU,
      required this.perResAddSame,
      required this.parcha,
      required this.parchaInNameOfApplicant,
      required this.noc,
      required this.dateOfLastMo,
      required this.lastMO,
      required this.rangeId,
      required this.purposeOther,
      required this.nameOfUser,
      required this.relationWithApplicant,
      required this.placeWhereProduceIsToBeUsed,
      required this.closestForestNursery,
      required this.managementPlan,
      required this.assignedTo,
      required this.markingOrderNo,
      required this.verificationScheduleDate,
      required this.purposeId,
      required this.applicationStatusId,
      required this.authorizationId,
      required this.applicantId});

  String get formattedDate {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(applicationDate);
  }

  factory ApplicationData.fromJson(Map<String, dynamic> json) {
    return ApplicationData(
      applicationId: json['applicationId'] ?? '',
      applicantName: json['applicantName'] ?? '',
      applicationNo: json['applicationNo'] ?? '',
      applicationDate: DateTime.parse(json['applicationDate'] ?? ''),
      applicantFirstName: json['applicantFirstName'] ?? '',
      applicantMiddleName: json['applicantMiddleName'] ?? '',
      applicantLastName: json['applicantLastName'] ?? '',
      applicantFatherName: json['applicantFatherName'] ?? '',
      permanent1Address: json['permanent1Address'] ?? '',
      permanent2Address: json['permanent2Address'] ?? '',
      permanentAddressDistrict: json['permanentAddressDistrict'] ?? '',
      permanentAddressBlock: json['permanentAddressBlock'] ?? '',
      permanentAddressGPU: json['permanentAddressGPU'] ?? '',
      residentialAddress1: json['residentialAddress1'] ?? '',
      residentialAddress2: json['residentialAddress2'] ?? '',
      residentialAddressDistrict: json['residentialAddressDistrict'] ?? '',
      residentialAddressBlock: json['residentialAddressBlock'] ?? '',
      residentialAddressGPU: json['residentialAddressGPU'] ?? '',
      perResAddSame: json['perResAddSame'] ?? false,
      parcha: json['parcha'] ?? '',
      parchaInNameOfApplicant: json['parchaInNameOfApplicant'] ?? false,
      noc: json['noc'] ?? '',
      dateOfLastMo: json['dateOfLastMo'] ?? '',
      lastMO: json['lastMO'] ?? '',
      rangeId: json['rangeId'] ?? '',
      purposeOther: json['purposeOther'] ?? '',
      nameOfUser: json['nameOfUser'] ?? '',
      relationWithApplicant: json['relationWithApplicant'] ?? '',
      placeWhereProduceIsToBeUsed: json['placeWhereProduceIsToBeUsed'] ?? '',
      closestForestNursery: json['closestForestNursery'] ?? '',
      managementPlan: json['managementPlan'] ?? '',
      assignedTo: json['assignedTo'] ?? '',
      markingOrderNo: json['markingOrderNo'] ?? '',
      verificationScheduleDate: json['verificationScheduleDate'] ?? '',
      purposeId: json['purposeId'] ?? '',
      applicationStatusId: json['applicationStatusId'] ?? '',
      authorizationId: json['authorizationId'] ?? '',
      applicantId: json['applicantId'] ?? 0,
    );
  }
}