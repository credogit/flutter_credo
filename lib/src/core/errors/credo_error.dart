import 'package:meta/meta.dart';

class CredoException implements Exception {
  final String message;
  CredoException({
    @required this.message,
  });
}
