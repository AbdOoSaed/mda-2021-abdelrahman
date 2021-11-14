import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  // dio instance
  final Dio _dio;

  // injecting dio instance
  DioClient(this._dio);

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (exception, stackTrace) {
      throw _handleNetworkExceptions(exception, stackTrace);
    }
  }

  String _handleNetworkExceptions(dynamic exception, StackTrace stackTrace) {
    if (kDebugMode) print('$exception/n$stackTrace');

    if (exception is DioError) {
      if (exception.error is SocketException) {
        throw 'No internet Connection!';
      }

      if (exception.type == DioErrorType.connectTimeout) {
        throw 'Connection takes too long time please check your internet';
      }
      if (exception.type == DioErrorType.receiveTimeout) {
        throw 'Request made but the server take to long time to response';
      }
      if (exception.type == DioErrorType.sendTimeout) {
        throw 'Sending data takes too long time please check your internet';
      }
    }

    throw 'Something went wrong';
  }
}
