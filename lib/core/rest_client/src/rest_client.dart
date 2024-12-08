import 'package:julien/core/rest_client/src/api_response.dart';

/// {@template rest_client}
/// A REST client for making HTTP requests.
/// {@endtemplate}
abstract class RestClient {
  /// Sends a GET request to the given [path].
  Future<APIResponse> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });

  /// Sends a POST request to the given [path].
  Future<APIResponse> post(
    String path, {
    required Map<String, Object?> body,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });

  /// Sends a PUT request to the given [path].
  Future<APIResponse> put(
    String path, {
    required Map<String, Object?> body,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });

  /// Sends a DELETE request to the given [path].
  Future<APIResponse> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });

  /// Sends a PATCH request to the given [path].
  Future<APIResponse> patch(
    String path, {
    required Map<String, Object?> body,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });
}
