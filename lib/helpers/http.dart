import 'package:dio/dio.dart';
import 'package:flutter_ui_login/helpers/http_response.dart';
import 'package:logger/logger.dart';

class Http {
  final Dio _dio;
  final Logger _logger;
  final bool _logsEnabled;

  Http({
    required Dio dio,
    required Logger logger,
    required bool logsEnabled,
  })  : _dio = dio,
        _logger = logger,
        _logsEnabled = logsEnabled;

  Future<HttpResponse<T>> request<T>(
    String path, {
    String method = 'GET',
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,

    // CancelToken cancelToken,
    // Options options,
  }) async {
    try {
      final response = await _dio.request(
        path,
        options: Options(
          method: method,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: data,
      );

      // options: Options(headers: {"Content-Type": "application/json"}),

      _logger.i(response.data);

      return HttpResponse.success<T>(response.data);
    } catch (e) {
      _logger.e(e);

      int statusCode = 0;
      String message = "";
      dynamic data;

      if (e is DioError) {
        statusCode = -1;
        message = e.message;
        if (e.response != null) {
          statusCode = e.response!.statusCode!;
          message = e.response!.statusMessage!;
          data = e.response!.data;
        }
      }

      return HttpResponse.fail<T>(
          statusCode: statusCode, message: message, data: data);
    }
  }
}
