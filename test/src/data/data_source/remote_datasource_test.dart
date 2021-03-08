import 'package:dio/dio.dart';
import 'package:flutter_credo/core/network/http_service_requester.dart';
import 'package:flutter_credo/src/data/data_source/remote_datasource.dart';
import 'package:flutter_credo/src/data/models/init_payment_response_model.dart';
import 'package:flutter_credo/src/data/models/third_party_payment_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockHttpServiceRequester extends Mock implements HttpServiceRequester {}

main() {
  MockHttpServiceRequester mockHttpServiceRequester;
  CredoRemoteDataSourceImpl credoRemoteDataSourceImpl;
  setUp(() {
    mockHttpServiceRequester = MockHttpServiceRequester();
    credoRemoteDataSourceImpl =
        CredoRemoteDataSourceImpl(mockHttpServiceRequester);
  });

  group('$CredoRemoteDataSourceImpl', () {
    group('InitPayment', () {
      test(
          'should return valid API response ($InitPaymentResponseModel) when the response status is = 200',
          () async {
        Map map = {
          "amount": 200.00,
          "currency": 'NGN',
          "redirectUrl": 'https://charlesarchibong.com',
          "transRef": '1243',
          "paymentOptions": 'CARD',
          "customerEmail": 'info@charlesarchibong.com',
          "customerName": 'Charles Archibong',
          "customerPhoneNo": '09039311229',
        };
        when(
          mockHttpServiceRequester.post(
            endpoint: 'payments/initiate',
            body: map,
            secretKey: 'xxxxxxxx',
          ),
        ).thenAnswer(
          (_) async => Response(
            data: {'paymentLink': 'https://charlesarchibong.com'},
            statusCode: 200,
          ),
        );

        InitPaymentResponseModel init =
            await credoRemoteDataSourceImpl.initialPayment(
          amount: 200.00,
          currency: 'NGN',
          customerEmail: 'info@charlesarchibong.com',
          customerName: 'Charles Archibong',
          customerPhoneNo: '09039311229',
          paymentOptions: 'CARD',
          redirectUrl: 'https://charlesarchibong.com',
          transactionRef: '1243',
          publicKey: 'xxxxxxxx',
        );

        expect(
          init.toMap(),
          equals(
            {'paymentLink': 'https://charlesarchibong.com'},
          ),
        );
      });
    });

    group('PayThreeDS', () {
      test(
          'should return valid API response ($ThirdPartyPaymentResponseModel) when the response status is = 200',
          () async {
        Map map = {
          "amount": 1500.3,
          "currency": "NGN",
          "redirectUrl": "http://charles",
          "transRef": "iy67f64hvc63",
          "paymentOptions": "CARD,BANK",
          "customerEmail": "cicirochwukunle@example.com",
          "customerName": "Ciroma Chukwuma Adekunle",
          "customerPhoneNo": "2348012345678"
        };
        when(
          mockHttpServiceRequester.post(
            endpoint: 'payments/card/third-party/3ds-pay',
            body: map,
            secretKey: 'xxxxxxxxxxxxx',
          ),
        ).thenAnswer(
          (_) async => Response(
            data: {"transRef": "iy67f64hvc63"},
            statusCode: 200,
          ),
        );

        ThirdPartyPaymentResponseModel init =
            await credoRemoteDataSourceImpl.payThreeDs(
          amount: 1500.3,
          currency: 'NGN',
          customerEmail: 'cicirochwukunle@example.com',
          customerName: 'Ciroma Chukwuma Adekunle',
          customerPhoneNo: '2348012345678',
          paymentOptions: 'CARD,BANK',
          transRef: "iy67f64hvc63",
          redirectUrl: "http://charles",
          secretKey: 'xxxxxxxxxxxxx',
        );

        expect(
          init.toMap(),
          equals({"transRef": "iy67f64hvc63"}),
        );
      });
    });

    group('PayWithCard', () {
      test(
          'should return valid API response ($ThirdPartyPaymentResponseModel) when the response status is = 200',
          () async {
        Map map = {
          "orderAmount": 5000,
          "orderCurrency": "NGN",
          "cardNumber": "5399670123490229",
          "expiryMonth": "05",
          "expiryYear": "22",
          "securityCode": "439",
          "transRef": "iy67f64hvc63",
          "customerEmail": "chunkylover53@aol.com",
          "customerName": "King of Kings",
          "customerPhoneNo": "+2348066282658",
          "paymentSlug": "0H0UOEsawNjkIxgspANd"
        };
        when(
          mockHttpServiceRequester.post(
            endpoint: 'payments/card/third-party/pay',
            body: map,
            secretKey: 'xxxxxxxxxxxxx',
          ),
        ).thenAnswer(
          (_) async => Response(
            data: {"transRef": "iy67f64hvc63"},
            statusCode: 200,
          ),
        );

        ThirdPartyPaymentResponseModel init =
            await credoRemoteDataSourceImpl.thirdPartyPay(
          secretKey: "xxxxxxxxxxxxx",
          cardNumber: "5399670123490229",
          customerEmail: "chunkylover53@aol.com",
          customerName: "King of Kings",
          customerPhoneNo: "+2348066282658",
          expiryMonth: "05",
          expiryYear: "22",
          securityCode: "439",
          orderAmount: 5000,
          orderCurrency: "NGN",
          paymentSlug: "0H0UOEsawNjkIxgspANd",
          transRef: 'iy67f64hvc63',
        );

        expect(
          init.toMap(),
          equals({"transRef": "iy67f64hvc63"}),
        );
      });
    });
  });
}
