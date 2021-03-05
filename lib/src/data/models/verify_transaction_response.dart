import 'package:flutter_credo/src/data/models/api_response_model.dart';

class VerifyTransactionResponseModel extends ApiResponseModel {
  int id;
  String customerEmail;
  String customerName;
  String customerPhoneNo;
  String customerUuid;
  DateTime date;
  String description;
  int dueAmount;
  int merchantImsId;
  String merchantReferenceNo;
  String processingFees;
  String customerCharge;
  String referenceNo;
  double totalAmount;
  DateTime updatedAt;
  DateTime completedAt;
  DateTime createdAt;
  String approvalStatus;
  String paymentChannel;
  String paymentStatus;
  String paymentOption;

  VerifyTransactionResponseModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    customerEmail = map['customerEmail'];
    customerName = map['customerName'];
    customerPhoneNo = map['customerPhoneNo'];
    customerUuid = map['customerUuid'];
    date = DateTime.parse(map['date']);
    description = map['description'];
    dueAmount = map['dueAmount'];
    merchantImsId = map['merchantImsId'];
    merchantReferenceNo = map['merchantReferenceNo'];
    processingFees = map['processingFees'];
    customerCharge = map['customerCharge'];
    referenceNo = map['referenceNo'];
    totalAmount = map['totalAmount'];
    updatedAt = DateTime.parse(map['updatedAt']);
    completedAt = DateTime.parse(map['completedAt']);
    createdAt = DateTime.parse(map['createdAt']);
    approvalStatus = map['approvalStatus'];
    paymentChannel = map['paymentChannel'];
    paymentStatus = map['paymentStatus'];
    paymentOption = map['paymentOption'];
  }

  VerifyTransactionResponseModel.fromErrorMap(Map<String, dynamic> map) {
    this.error = map['error'];
    this.status = map['status'];
    this.message = map['message'];
    this.path = map['path'];
  }

  @override
  String toString() {
    return 'VerifyTransactionResponseModel(id: $id, customerEmail: $customerEmail, customerName: $customerName, customerPhoneNo: $customerPhoneNo, customerUuid: $customerUuid, date: $date, description: $description, dueAmount: $dueAmount, merchantImsId: $merchantImsId, merchantReferenceNo: $merchantReferenceNo, processingFees: $processingFees, customerCharge: $customerCharge, referenceNo: $referenceNo, totalAmount: $totalAmount, updatedAt: $updatedAt, completedAt: $completedAt, createdAt: $createdAt, approvalStatus: $approvalStatus, paymentChannel: $paymentChannel, paymentStatus: $paymentStatus, paymentOption: $paymentOption,  error: $error, status: $status, message:$message, path:$path)';
  }
}
