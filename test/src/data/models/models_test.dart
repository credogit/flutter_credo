import 'package:flutter_credo/src/data/models/api_response_model.dart';
import 'package:flutter_credo/src/data/models/init_payment_response_model.dart';
import 'package:flutter_credo/src/data/models/third_party_payment_response_model.dart';
import 'package:flutter_credo/src/data/models/verify_card_response_model.dart';
import 'package:flutter_credo/src/data/models/verify_transaction_response.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('$ApiResponseModel', () {
    test('Is $InitPaymentResponseModel subclass of $ApiResponseModel', () {
      InitPaymentResponseModel initPaymentResponseModel =
          InitPaymentResponseModel.fromMap(
        {'paymentLink': 'https://charlesarchibong.com'},
      );
      expect(initPaymentResponseModel, isA<ApiResponseModel>());
    });

    test('Is $ThirdPartyPaymentResponseModel subclass of $ApiResponseModel',
        () {
      ThirdPartyPaymentResponseModel thirdPartyPayment =
          ThirdPartyPaymentResponseModel.fromMap(
        {'transRef': 'xtx'},
      );
      expect(thirdPartyPayment, isA<ApiResponseModel>());
    });

    test('Is $VerifyCardResponseModel subclass of $ApiResponseModel', () {
      VerifyCardResponseModel verifyCardResponseModel =
          VerifyCardResponseModel.fromMap(
        {
          'orderId': '12',
          'transactionId': 'xfr',
          'gatewayCode': '1234',
          'gatewayRecommendation': 'Hi',
          'correlationId': 'ded3',
          'timeOfRecord': '12:04:2020',
          'redirectionHtml': 'https://'
        },
      );
      expect(verifyCardResponseModel, isA<ApiResponseModel>());
    });

    test('Is $VerifyTransactionResponseModel subclass of $ApiResponseModel',
        () {
      VerifyTransactionResponseModel verifyTransactionResponseModel =
          VerifyTransactionResponseModel.fromMap(
        {
          "id": 4,
          "completedAt": "2021-01-28T12:35:43",
          "createdAt": "2021-01-28T12:35:43",
          "customerEmail": "cirochwukunle@example.com",
          "customerName": "Ciroma Chukwuma Adekunle",
          "customerPhoneNo": "2348012345678",
          "customerUuid": null,
          "date": "2021-01-28",
          "description": "Transaction",
          "dueAmount": 100,
          "merchantImsId": 154789685478965,
          "merchantReferenceNo": "254655-4946-3634",
          "processingFees": "1.5,",
          "customerCharge": "0.0,",
          "referenceNo": "order-URQiaJZRvd",
          "totalAmount": 101.5,
          "updatedAt": "2021-01-28T12:35:43",
          "approvalStatus": {"id": 2, "name": "Accepted"},
          "paymentChannel": {"id": 1, "name": "Card"},
          "paymentStatus": {"id": 5, "description": null, "name": "Successful"},
          "paymentOption": {"id": 1, "name": "Regular"}
        },
      );
      print(verifyTransactionResponseModel.approvalStatus);
      expect(verifyTransactionResponseModel, isA<ApiResponseModel>());
    });
  });
}
