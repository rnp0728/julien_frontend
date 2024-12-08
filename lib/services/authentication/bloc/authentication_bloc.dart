import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';
import 'package:julien/app/models/user.dart';
import 'package:julien/core/rest_client/src/api_response.dart';
import 'package:julien/core/utils/persistent_manager.dart';
import 'package:julien/services/authentication/data/authentication_repository.dart';
import 'package:julien/services/routing/routes.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  AuthenticationBloc({
    required this.authenticationRepository,
  }) : super(const UninitializedState()) {
    on<AppStartedEvent>(_onAppStartedEvent);
    on<SignInUserEvent>(_onSignInUserEvent);
    on<SignOutUserEvent>(_onSignOutUserEvent);
  }

  FutureOr<void> _onAppStartedEvent(
      AppStartedEvent event, Emitter<AuthenticationState> emit) async {
    emit(const InitializingState());
    try {
      if (hasToken()) {
        final response =
            await authenticationRepository.getLoggedInUserDetails();
        if (response is SuccessResponse) {
          emit(AuthenticatedState(
            user: User.fromMap(response.data),
          ));
        } else {
          emit(const InitializedState());
        }
      } else {
        emit(const UninitializedState());
      }
    } catch (e) {
      emit(AuthenticationErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _onSignInUserEvent(
      SignInUserEvent event, Emitter<AuthenticationState> emit) {
    emit(const AuthenticatingState());
    try {
      PersistentManager.setString("accessToken", event.accessToken);
      PersistentManager.setString("refreshToken", event.refreshToken);
      event.context.go(Routes.dashboard);
      emit(AuthenticatedState(
        user: User.fromMap(event.user),
      ));
    } catch (e) {
      emit(AuthenticationErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _onSignOutUserEvent(
      SignOutUserEvent event, Emitter<AuthenticationState> emit) {}

  bool hasToken() {
    return PersistentManager.getString("accessToken") != null;
  }
}
