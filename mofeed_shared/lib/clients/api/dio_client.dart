import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mofeed_shared/clients/api/status_code.dart';

import '../../utils/error/exceptions.dart';
import '../../utils/typdefs/typedefs.dart';
import 'api_client.dart';
import 'dio_interceptors.dart';

class DioClient implements ApiClient {
  final Dio dio;
  final String baseUrl;
  final Interceptor interceptor;

  DioClient({
    required this.dio,
    required this.baseUrl,
    this.interceptor = const AppInterceptor(),
  }) {
    dio.options
      ..baseUrl = baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    dio.interceptors.add(interceptor);
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ));
  }

  @override
  Future get(String path, {MapJson? queryParams}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParams);
      return _mapResponseToJson(response);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future post(
    String path, {
    MapJson? queryParams,
    MapJson? body,
    bool enableDataFormated = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        queryParameters: queryParams,
        data: body,
      );
      return _mapResponseToJson(response);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future put(String path, {MapJson? queryParams, MapJson? body}) async {
    try {
      final response = await dio.put(
        path,
        queryParameters: queryParams,
        data: body,
      );
      return _mapResponseToJson(response);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  dynamic _mapResponseToJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  dynamic _handleDioError(DioException error) {
    print('DIO ERROR ${error.toString()}');
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badCertificate:
        throw const BadCerificateException();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unAuth:
          case StatusCode.forbidden:
            throw const UnAuthorisedException();
          case StatusCode.conflict:
            throw const ConflictException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.internalServerError:
            throw const InternalServerEception();
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
        throw const NoInternetConnectionException();
      case DioExceptionType.unknown:
        throw const UnknownServerException();
    }
  }
}

class FetchDataException extends AppException {
  const FetchDataException([meesage]) : super("Error During Communication");
}

class InternalServerEception extends AppException {
  const InternalServerEception([meesage]) : super("Internal Server Error");
}

class BadRequestException extends AppException {
  const BadRequestException([meesage]) : super("Bad Request");
}

class UnAuthorisedException extends AppException {
  const UnAuthorisedException([meesage]) : super("Un Authorised");
}

class NotFoundException extends AppException {
  const NotFoundException([meesage]) : super("Not Found");
}

class ConflictException extends AppException {
  const ConflictException([meesage]) : super("Confilct");
}

class NoInternetConnectionException extends AppException {
  const NoInternetConnectionException([meesage]) : super("No Network");
}

class UnknownServerException extends AppException {
  const UnknownServerException([meesage]) : super("Unknown Error occuered");
}

class ConnectionCancledException extends AppException {
  const ConnectionCancledException([meesage])
      : super("Connection cancled or interptued");
}

class BadCerificateException extends AppException {
  const BadCerificateException([meesage]) : super("Bad Certifacte or request");
}
