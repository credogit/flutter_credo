import 'dart:io';

mixin CredoConstants {
  final Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  final String sandBoxBaseUrl = 'https://credo-payments.nugitech.com/v1';
  final String liveBaseUrl = 'https://credo-payments.nugitech.com/v1';
}
