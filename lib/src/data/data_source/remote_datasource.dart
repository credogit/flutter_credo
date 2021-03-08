import 'package:dio/dio.dart';
import 'package:flutter_credo/core/network/http_service_requester.dart';
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

class CredoRemoteDataSourceImpl implements CredoRemoteDataSource {
  final HttpServiceRequester httpServiceRequester;

  CredoRemoteDataSourceImpl(this.httpServiceRequester);

  @override
  Future<InitPaymentResponseModel> initialPayment({
    double amount,
    String currency,
    String redirectUrl,
    String transactionRef,
    String paymentOptions,
    String customerEmail,
    String customerName,
    String customerPhoneNo,
  }) async {
    Map map = {
      "amount": amount,
      "currency": currency,
      "redirectUrl": redirectUrl,
      "transRef": transactionRef,
      "paymentOptions": paymentOptions,
      "customerEmail": customerEmail,
      "customerName": customerName,
      "customerPhoneNo": customerPhoneNo
    };
    final Response response = await httpServiceRequester.post(
      endpoint: 'payments/initiate',
      body: map,
      secretKey: '',
    );
    print(response.data.runtimeType);
    print(response.data is Map<String, dynamic>);
    return InitPaymentResponseModel.fromMap(
      response.data is Map<String, dynamic>
          ? response.data
          : Map<String, dynamic>.from(response.data),
    );
  }

  @override
  Future<ThirdPartyPaymentResponseModel> payThreeDs(
      {double amount,
      String currency,
      String transRef,
      String customerEmail,
      String customerName,
      String customerPhoneNo,
      String redirectUrl,
      String paymentOptions}) {
    // TODO: implement payThreeDs
    throw UnimplementedError();
  }

  @override
  Future<ThirdPartyPaymentResponseModel> thirdPartyPay(
      {String orderCurrency,
      String cardNumber,
      String expiryMonth,
      String expiryYear,
      String securityCode,
      String transRef,
      String customerEmail,
      String customerName,
      String customerPhoneNo,
      String paymentSlug,
      double orderAmount}) {
    // TODO: implement thirdPartyPay
    throw UnimplementedError();
  }

  @override
  Future<VerifyCardResponseModel> verifyCardDetails(
      {String cardNumber, String orderCurrency, String paymentSlug}) {
    // TODO: implement verifyCardDetails
    throw UnimplementedError();
  }

  @override
  Future<VerifyTransactionResponseModel> verifyTransaction(
      {String transactionRef}) {
    // TODO: implement verifyTransaction
    throw UnimplementedError();
  }
}
