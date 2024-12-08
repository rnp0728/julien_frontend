import 'dart:io';

import 'package:dio/dio.dart';
import 'package:julien/core/rest_client/rest_client.dart';
import 'package:julien/core/rest_client/src/api_response.dart';
import 'package:julien/core/rest_client/src/auth/auth_interceptor.dart';
import 'package:julien/core/utils/persistent_manager.dart';
import 'package:julien/core/rest_client/src/dio/check_exception_io.dart';

final class RestClientDio extends RestClientBase {
  late final Dio _dioClient;

  RestClientDio() {
    _dioClient = Dio(
      BaseOptions(
        baseUrl: const String.fromEnvironment(
          "BASE_URL",
          defaultValue: "http://localhost:8080/api",
        ),
      ),
    );
    _dioClient.interceptors.add(const AuthInterceptor());
  }

  @override
  Future<APIResponse> send({
    required String path,
    required String method,
    Map<String, String?>? pathParams,
    Map<String, String?>? queryParams,
    Map<String, String>? headers,
    Map<String, Object?>? body,
  }) async {
    try {
      final uri = setupPathParams(path, pathParams);
      final options = Options(
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'Bearer ${PersistentManager.getString('accessToken') ?? ''}',
        },
        method: method,
        followRedirects: false,
        responseType: ResponseType.json,
      );

      final response = await _dioClient.request(
        uri,
        options: options,
        data: body,
        queryParameters: queryParams,
      );

      final result = await decodeResponse(
        response.data,
        statusCode: response.statusCode,
      );

      return SuccessResponse(
        successMessage: "SUCCESS",
        statusCode: response.statusCode.toString(),
        data: result,
      );
    } on RestClientException {
      rethrow;
    } on DioException catch (e, stack) {
      final checkedException = checkDioException(e);

      if (checkedException != null) {
        Error.throwWithStackTrace(checkedException, stack);
      }

      Error.throwWithStackTrace(
        ClientException(message: e.message ?? '', cause: e),
        stack,
      );
    }
  }

  String setupPathParams(
      String endpoint, Map<String, dynamic>? pathParameters) {
    if (pathParameters != null) {
      pathParameters.forEach((key, value) {
        endpoint = endpoint.replaceAll('{$key}', value.toString());
      });
    }
    return endpoint;
  }
}
