import 'package:dio/dio.dart';
import 'package:julien/services/authentication/bloc/authentication_bloc.dart';

class AuthInterceptor extends Interceptor {
  final AuthenticationBloc? bloc;
  const AuthInterceptor({
    this.bloc,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (bloc != null) {
        // todo:
      }
    }
    super.onError(err, handler);
  }
}
