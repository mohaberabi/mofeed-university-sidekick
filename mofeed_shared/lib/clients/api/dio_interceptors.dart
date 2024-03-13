import 'package:dio/dio.dart';
import 'package:mofeed_shared/clients/api/status_code.dart';
import 'package:mofeed_shared/constants/fcm_const.dart';

class AppInterceptor extends Interceptor {
  final bool observe;

  const AppInterceptor({this.observe = false});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (observe) {
      print("REQUEST [${options.method}]=> PATH ${options.path}");
    }
    options.headers[contentType] = applicationJson;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
        "ERRORRR [${err.response?.statusCode}]=> PATH ${err.requestOptions
            .path}");
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "RESPONSE [${response.statusCode}]=> PATH ${response.requestOptions
            .path}");
    super.onResponse(response, handler);
  }
}

class FbMessagingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("REQUEST [${options.method}]=> PATH ${options.path}");
    options.headers['Content-Type'] = 'application/json';
    options.headers['Authorization'] = FcmConst.legacyApiServerKey;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
        "ERRORRR [${err.response?.statusCode}]=> PATH ${err.requestOptions
            .path}");
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "RESPONSE [${response.statusCode}]=> PATH ${response.requestOptions
            .path}");
    super.onResponse(response, handler);
  }
}
