import 'package:flutter_credo/src/data/models/api_response_model.dart';

class InitPaymentResponseModel extends ApiResponseModel {
  String paymentLink;
  String paymentSlug;

  Map<String, dynamic> toMap() {
    return {
      'paymentLink': paymentLink,
      'paymentSlug': paymentSlug,
    };
  }

  InitPaymentResponseModel.fromMap(Map<String, dynamic> map) {
    this.paymentLink = map['paymentLink'];
    this.paymentSlug = map['paymentSlug'];
  }

  InitPaymentResponseModel.fromErrorMap(Map<String, dynamic> map) {
    this.error = map['error'];
    this.status = map['status'];
    this.message = map['message'];
    this.path = map['path'];
  }

  @override
  String toString() =>
      'InitPaymentResponseModel(paymentLink: $paymentLink, error: $error, status: $status, message:$message, path:$path, paymentSlug:$paymentSlug)';
}
