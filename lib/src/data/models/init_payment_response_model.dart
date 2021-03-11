import 'package:flutter_credo/src/data/models/api_response_model.dart';

class InitPaymentResponse extends ApiResponseModel {
  String paymentLink;
  String paymentSlug;

  Map<String, dynamic> toMap() {
    return {
      'paymentLink': paymentLink,
      'paymentSlug': paymentSlug,
    };
  }

  InitPaymentResponse.fromMap(Map<String, dynamic> map) {
    this.paymentLink = map['paymentLink'];
    this.paymentSlug = map['paymentSlug'];
  }

  InitPaymentResponse.fromErrorMap(Map<String, dynamic> map) {
    this.error = map['error'];
    this.status = map['status'];
    this.message = map['message'];
    this.path = map['path'];
  }

  @override
  String toString() =>
      'InitPaymentResponse(paymentLink: $paymentLink, error: $error, status: $status, message:$message, path:$path, paymentSlug:$paymentSlug)';
}
