import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credo/core/errors/credo_exceptions.dart';
import 'package:flutter_credo/core/utils/util.dart';
import 'package:flutter_credo/flutter_credo.dart';
import 'package:flutter_credo/src/data/models/third_party_payment_response_model.dart';
import 'package:flutter_credo/src/domain/repositories/credo_sdk_repository.dart';

class CredoPlugin extends Equatable {
  final String publicKey;
  final String secretKey;

  /// Initialize the Credo object. It should be called as early as possible
  /// (preferably in initState() of the Widget.
  ///
  /// [publicKey] - your Credo public key. This is mandatory
  /// [secretKey] - your Credo seceret key. This is mandatory
  ///
  /// use [checkout] and you want this plugin to initialize the transaction for you.
  /// Please check [checkout] for more information
  ///

  CredoPlugin({@required this.publicKey, @required this.secretKey});

  @override
  List<Object> get props => [publicKey, secretKey];

  String get getPublicKey {
    // Validate that the sdk has been initialized
    _performChecks();
    return this.publicKey;
  }

  String get getSecretKey {
    // Validate that the sdk has been initialized
    _performChecks();
    return this.secretKey;
  }

  void _performChecks() {
    //check for null value, and length and starts with pk_
    if (this.publicKey == null || this.publicKey.isEmpty) {
      throw new CredoException(message: Utils.getKeyErrorMsg('public'));
    }

    if (this.secretKey == null || this.secretKey.isEmpty) {
      throw new CredoException(message: Utils.getKeyErrorMsg('private'));
    }
  }

  /// Initial payment and get a paymentSlug that will be used for payment
  ///
  ///
  /// [currency] - the orderCurrency example NGN.
  ///
  /// [transRef] - transRef is a unique transaction reference used to track payment, this was gotten from initial payment.
  ///
  /// [customerEmail] - tthe customer's email.
  ///
  /// [amount] - the order amount.
  ///
  /// [customerName] - the customer's name.
  ///
  /// [customerPhoneNo] - the customer's phone number
  ///
  /// [paymentSlug] - paymentSlug was generated by [Credo] during initialize payment.
  ///
  /// returns [InitPaymentResponse]
  ///
  /// throw  [CredoException] if any error is encountered

  Future<InitPaymentResponse> initialPayment({
    @required double amount,
    @required String currency,
    String redirectUrl,
    String transactionRef,
    String paymentOptions,
    @required String customerEmail,
    @required String customerName,
    @required String customerPhoneNo,
  }) async {
    assert(amount != null, 'amount must not be null');
    assert(currency != null, 'currency must not be null');
    assert(customerEmail != null, 'customerEmail must not be null');
    assert(customerName != null, 'customerName must not be null');
    assert(customerPhoneNo != null, 'customerPhoneNo must not be null');
    _performChecks();

    CredoSdkRepository credoSdkRepository = CredoSdkRepository();
    final verified = await credoSdkRepository.initialPayment(
      amount: amount,
      currency: currency,
      customerEmail: customerEmail,
      customerName: customerName,
      customerPhoneNo: customerPhoneNo,
      publicKey: this.publicKey,
      transactionRef: transactionRef,
      paymentOptions: paymentOptions,
      redirectUrl: redirectUrl,
    );

    return verified.fold((CredoException credoException) {
      throw credoException;
    }, (InitPaymentResponse initPaymentResponseModel) {
      return initPaymentResponseModel;
    });
  }

  /// Verify the status of a payment using the transaction reference
  ///
  ///
  /// [transRef] - transRef is a unique transaction reference used to track payment, this was gotten from initial payment.
  ///
  /// returns [VerifyTransactionResponse]
  ///
  /// throw  [CredoException] if any error is encountered

  Future<VerifyTransactionResponse> verifyTransaction({
    @required String transactionRef,
  }) async {
    assert(transactionRef != null, 'transRef must not be null');
    _performChecks();

    CredoSdkRepository credoSdkRepository = CredoSdkRepository();
    final verified = await credoSdkRepository.verifyTransaction(
      transactionRef: transactionRef,
      secretKey: this.secretKey,
    );

    return verified.fold((CredoException credoException) {
      throw credoException;
    }, (VerifyTransactionResponse verifyTransactionResponseModel) {
      return verifyTransactionResponseModel;
    });
  }

  /// Make payment by charging the user's card with your custom UI
  ///
  ///
  /// [orderCurrency] - the orderCurrency example NGN.
  ///
  /// [cardNumber] - the customer's card number.
  ///
  /// [expiryMonth] - the customer's card expiry month example 01.
  ///
  /// [expiryYear] - the customer's card expiry year example 22.
  ///
  /// [securityCode] - the customer's card securityCode (CVV).
  ///
  /// [transRef] - transRef is a unique transaction reference used to track payment, this was gotten from initial payment.
  ///
  /// [customerEmail] - tthe customer's email.
  ///
  /// [customerName] - the customer's name.
  ///
  /// [customerPhoneNo] - the customer's phone number
  ///
  /// [paymentSlug] - paymentSlug was generated by [Credo] during initialize payment.
  ///
  /// returns [ThirdPartyPaymentResponse]
  ///
  /// throw  [CredoException] if any error is encountered

  Future<ThirdPartyPaymentResponse> pay({
    @required String orderCurrency,
    @required String cardNumber,
    @required String expiryMonth,
    @required String expiryYear,
    @required String securityCode,
    @required String transRef,
    String customerEmail,
    String customerName,
    String customerPhoneNo,
    @required String paymentSlug,
    @required double orderAmount,
  }) async {
    assert(cardNumber != null, 'card number must not be null');
    assert(expiryMonth != null, 'card expiry month must not be null');
    assert(expiryYear != null, 'card expiry year must not be null');
    assert(securityCode != null, 'security code must not be null');
    assert(paymentSlug != null, 'payment slug must not be null');
    assert(orderAmount != null, 'transaction amount must not be null');
    _performChecks();

    CredoSdkRepository credoSdkRepository = CredoSdkRepository();
    final paid = await credoSdkRepository.checkOut(
      orderCurrency: orderCurrency,
      cardNumber: cardNumber,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      securityCode: securityCode,
      transRef: transRef,
      paymentSlug: paymentSlug,
      secretKey: getSecretKey,
    );

    return paid.fold((CredoException credoException) {
      throw credoException;
    }, (ThirdPartyPaymentResponse thirdPartyPaymentResponse) {
      return thirdPartyPaymentResponse;
    });
  }

  /// Verify card details to ensure it's valid for payment
  ///
  ///
  /// [cardNumber] - atm card number,
  ///
  /// [paymentSlug] - paymentSlug gotten after payment is initialized
  ///
  /// [orderCurrency] - The currency the transaction is operating on, eg [NGN]
  ///
  /// returns [VerifyCardResponse]
  ///
  /// throw  [CredoException] if any error is encountered

  Future<VerifyCardResponse> verifyCard({
    @required String cardNumber,
    @required String paymentSlug,
    @required String orderCurrency,
  }) async {
    assert(cardNumber != null, 'cardNumber must not be null');
    assert(paymentSlug != null, 'paymentSlug must not be null');
    assert(orderCurrency != null, 'orderCurrency must not be null');
    _performChecks();

    CredoSdkRepository credoSdkRepository = CredoSdkRepository();
    final verified = await credoSdkRepository.verifyCard(
      cardNumber: cardNumber,
      orderCurrency: orderCurrency,
      paymentSlug: paymentSlug,
      secretKey: this.secretKey,
    );

    return verified.fold((CredoException credoException) {
      throw credoException;
    }, (VerifyCardResponse verifyCardResponse) {
      return verifyCardResponse;
    });
  }
}
