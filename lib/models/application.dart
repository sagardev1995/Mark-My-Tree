import 'dart:ffi';

class Application {
  final int applicationId;
  final String? applicantName;
  final int? applicationNo;
  final String applicationDate;
  final String applicantFirstName;
  final String? applicantMiddleName;
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
  final Bool perResAddSame;
  final String parcha;
  final Bool parchaInNameOfApplicant;
  final String? noc;
  final String? dateOfLastMo;
  final String? lastMO;
  final String rangeId;
  final String? purposeOther;
  final String? nameOfUser;
  final String relationWithApplicant;
  final String placeWhereProduceIsToBeUsed;
  final String closestForestNursery;
  final String? managementPlan;
  final String assignedTo;
  final String? markingOrderNo;
  final String verificationScheduleDate;
  final String purposeId;
  final String applicationStatusId;
  final String? authorizationId;
  final int applicantId;

  Application(
      this.applicationId,
      this.applicantName,
      this.applicationNo,
      this.applicationDate,
      this.applicantFirstName,
      this.applicantMiddleName,
      this.applicantLastName,
      this.applicantFatherName,
      this.permanent1Address,
      this.permanent2Address,
      this.permanentAddressDistrict,
      this.permanentAddressBlock,
      this.permanentAddressGPU,
      this.residentialAddress1,
      this.residentialAddress2,
      this.residentialAddressDistrict,
      this.residentialAddressBlock,
      this.residentialAddressGPU,
      this.perResAddSame,
      this.parcha,
      this.parchaInNameOfApplicant,
      this.noc,
      this.dateOfLastMo,
      this.lastMO,
      this.rangeId,
      this.purposeOther,
      this.nameOfUser,
      this.relationWithApplicant,
      this.placeWhereProduceIsToBeUsed,
      this.closestForestNursery,
      this.managementPlan,
      this.assignedTo,
      this.markingOrderNo,
      this.verificationScheduleDate,
      this.purposeId,
      this.applicationStatusId,
      this.authorizationId,
      this.applicantId);
}
