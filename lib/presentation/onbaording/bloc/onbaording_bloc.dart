import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'onbaording_event.dart';
part 'onbaording_state.dart';

class OnbaordingBloc extends Bloc<OnbaordingEvent, OnbaordingState> {
  OnbaordingBloc() : super(const OnbaordingLoadedState()) {
    on<ChangeOnbaordingModeEvent>(_onOnbaordingModeChangedEvent);
  }

  FutureOr<void> _onOnbaordingModeChangedEvent(
      ChangeOnbaordingModeEvent event, emit) async {
    emit(OnbaordingLoadingState.copyState(
      state: state,
    ));
    await Future.delayed(const Duration(seconds: 1));
    emit(OnbaordingLoadedState.copyState(
      state: state,
      onbaordingMode: state.onbaordingMode == OnbaordingMode.signin
          ? OnbaordingMode.signup
          : OnbaordingMode.signin,
    ));
  }
}
