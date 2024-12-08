import 'package:julien/core/rest_client/rest_client.dart';
import 'package:julien/core/rest_client/src/api_endpoints.dart';
import 'package:julien/core/rest_client/src/api_response.dart';

/// {@template authentication_repository}
/// [AuthenticationRepository] contains all api calls to respective functionalities.
/// {@endtemplate}
abstract interface class AuthenticationRepository {
  Future<APIResponse> signup(Map<String, dynamic> data);

  Future<APIResponse> signin(Map<String, dynamic> data);

  Future<APIResponse> getLoggedInUserDetails();
}

/// {@macro authentication_repository}
final class AuthenticationRepositoryImpl implements AuthenticationRepository {
  /// {@macro authentication_repository}
  const AuthenticationRepositoryImpl({
    required this.client,
  });

  final RestClientDio client;

  @override
  Future<APIResponse> signup(Map<String, dynamic> data) async {
    return await client.send(
      path: ApiEndpoint.signup,
      method: "POST",
      body: data,
    );
  }

  @override
  Future<APIResponse> signin(Map<String, dynamic> data) async {
    return await client.send(
      path: ApiEndpoint.signin,
      method: "POST",
      body: data,
    );
  }

  @override
  Future<APIResponse> getLoggedInUserDetails() {
    return client.send(
      path: ApiEndpoint.authenticatedUserInfo,
      method: "GET",
    );
  }
}
