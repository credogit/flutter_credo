import 'dart:math';

import 'package:flutter_credo/src/credo_plugin.dart';
import 'package:flutter_credo/core/errors/credo_exceptions.dart';
import 'package:intl/intl.dart';

class Utils {
  static String getRandomString() {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        20,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
  }

  static validateSdkInitialized() {
    if (!CredoPlugin.isSdkInitialized) {
      throw new CredoException(
        message: 'Credo SDK has not been initialized. The SDK has'
            ' to be initialized before use',
      );
    }
  }

  static String getKeyErrorMsg(String keyType) {
    return 'Invalid $keyType key. You must use a valid $keyType key. Ensure that you '
        'have set a $keyType key. Check https://credo.nugitech.com/ for more';
  }

  static NumberFormat _currencyFormatter;

  static setCurrencyFormatter(String currency, String locale) =>
      _currencyFormatter =
          NumberFormat.currency(locale: locale, name: '$currency\u{0020}');

  static String formatAmount(num amountInBase) {
    if (_currencyFormatter == null) throw "Currency formatter not initalized.";
    return _currencyFormatter.format((amountInBase / 100));
  }
}
