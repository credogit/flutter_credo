import 'package:flutter_credo/src/data/models/init_payment_response_model.dart';
import 'package:flutter_credo/src/data/models/third_party_payment_response_model.dart';
import 'package:flutter_credo/src/data/models/verify_card_response_model.dart';
import 'package:flutter_credo/src/data/models/verify_transaction_response.dart';
import 'package:meta/meta.dart';

abstract class CredoRemoteDataSource {
  Future<InitPaymentResponseModel> initialPayment({
    @required double amount,
    @required String currency,
    String redirectUrl,
    @required String transactionRef,
    String paymentOptions,
    String customerEmail,
    String customerName,
    String customerPhoneNo,
  });

  Future<VerifyTransactionResponseModel> verifyTransaction({
    @required String transactionRef,
  });

  Future<ThirdPartyPaymentResponseModel> thirdPartyPay({
    @required String orderCurrency,
    @required String cardNumber,
    @required String expiryMonth,
    @required String expiryYear,
    @required String securityCode,
    @required String transRef,
    @required String customerEmail,
    @required String customerName,
    @required String customerPhoneNo,
    @required String paymentSlug,
    @required double orderAmount,
  });

  Future<VerifyCardResponseModel> verifyCardDetails({
    @required String cardNumber,
    @required String orderCurrency,
    @required String paymentSlug,
  });

  Future<ThirdPartyPaymentResponseModel> payThreeDs({
    @required double amount,
    @required String currency,
    @required String transRef,
    @required String customerEmail,
    @required String customerName,
    @required String customerPhoneNo,
    @required String redirectUrl,
    @required String paymentOptions,
  });
}
