import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:julien/core/rest_client/src/api_response.dart';
import 'package:julien/core/utils/persistent_manager.dart';
import 'package:julien/services/authentication/data/authentication_repository.dart';
import 'package:meta/meta.dart';

part 'onbaording_event.dart';
part 'onbaording_state.dart';

class OnbaordingBloc extends Bloc<OnbaordingEvent, OnbaordingState> {
  final AuthenticationRepository authenticationRepository;
  OnbaordingBloc({
    required this.authenticationRepository,
  }) : super(const OnbaordingInitialState()) {
    on<OnbaordingInitEvent>(_onOnboardingInitEvent);
    on<ChangeOnbaordingModeEvent>(_onOnbaordingModeChangedEvent);
    on<SignupEvent>(_onSignupEvent);
    on<SigninEvent>(_onSigninEvent);
  }
  FutureOr<void> _onOnboardingInitEvent(
    OnbaordingInitEvent event,
    emit,
  ) async {
    final registeredUser = PersistentManager.getBool("registeredUser");
    emit(
      OnbaordingLoadedState.copyState(
        state: state,
        onbaordingMode: registeredUser == true
            ? OnbaordingMode.signin
            : OnbaordingMode.signup,
      ),
    );
  }

  FutureOr<void> _onOnbaordingModeChangedEvent(
      ChangeOnbaordingModeEvent event, emit) async {
    emit(OnbaordingLoadingState.copyState(
      state: state,
    ));
    await Future.delayed(const Duration(milliseconds: 1));
    emit(OnbaordingLoadedState.copyState(
      state: state,
      onbaordingMode: state.onbaordingMode == OnbaordingMode.signin
          ? OnbaordingMode.signup
          : OnbaordingMode.signin,
    ));
  }

  FutureOr<void> _onSignupEvent(SignupEvent event, emit) async {
    emit(OnbaordingLoadingState.copyState(
      state: state,
    ));
    try {
      final response = await authenticationRepository.signup({
        'organisation': event.organisation,
        'name': event.name,
        'email': event.email,
        'password': event.password,
      });
      if (response is SuccessResponse) {
        PersistentManager.setBool("registeredUser", true);
        emit(OnbaordingLoadedState.copyState(
          state: state,
          onbaordingMode: OnbaordingMode.signin,
        ));
      } else {
        emit(OnbaordingErrorState.copyState(
          state: state,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(OnbaordingErrorState.copyState(
        state: state,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onSigninEvent(SigninEvent event, emit) async {
    emit(OnbaordingLoadingState.copyState(
      state: state,
    ));
    try {
      final response = await authenticationRepository.signin({
        'email': event.email,
        'password': event.password,
      });
      if (response is SuccessResponse) {
        emit(OnbaordingSuccessState.copyState(
          state: state,
          responseData: response.data,
        ));
      } else {
        emit(OnbaordingErrorState.copyState(
          state: state,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(OnbaordingErrorState.copyState(
        state: state,
        message: e.toString(),
      ));
    }
  }
}
