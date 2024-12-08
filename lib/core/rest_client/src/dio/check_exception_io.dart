import 'dart:io';
import 'package:dio/dio.dart';
import 'package:julien/core/rest_client/rest_client.dart';

Object? checkDioException(DioException e) => switch (e) {
      final SocketException socketException => ConnectionException(
          message: socketException.message,
          cause: socketException,
        ),
      _ => null,
    };
