import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpServiceRequester {
  Dio dio;
  HttpServiceRequester({
    @required this.dio,
  }) {
    this.dio = Dio();
  }

  Future<Response> post({
    @required String url,
    String token,
    dynamic body,
    @required String contentType,
    Map queryParam,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.post(
      url,
      data: body,
      queryParameters: queryParam,
      options: Options(
        contentType: contentType,
      ),
    );
    return response;
  }

  Future<dynamic> getRequest({
    @required String url,
    @required String token,
    @required Map queryParam,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      url,
    );
    return response;
  }
}
