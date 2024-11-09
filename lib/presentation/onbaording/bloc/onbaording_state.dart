part of 'onbaording_bloc.dart';

enum OnbaordingMode {
  signin,
  signup,
}

@immutable
sealed class OnbaordingState extends Equatable {
  final OnbaordingMode onbaordingMode;

  const OnbaordingState({
    this.onbaordingMode = OnbaordingMode.signup,
  });

  factory OnbaordingState.copyState({
    OnbaordingMode? onbaordingMode,
    required OnbaordingState state,
  }) {
    throw UnimplementedError("OnbaordingState.copyState is not implemented");
  }
  @override
  List<Object?> get props => [onbaordingMode];
}

final class OnbaordingInitialState extends OnbaordingState {
  const OnbaordingInitialState({
    super.onbaordingMode,
  });

  @override
  factory OnbaordingInitialState.copyState({
    OnbaordingMode? onbaordingMode,
    required OnbaordingState state,
  }) {
    return OnbaordingInitialState(
      onbaordingMode: onbaordingMode ?? state.onbaordingMode,
    );
  }
}

final class OnbaordingLoadingState extends OnbaordingState {
  const OnbaordingLoadingState({
    super.onbaordingMode,
  });
  @override
  factory OnbaordingLoadingState.copyState({
    OnbaordingMode? onbaordingMode,
    required OnbaordingState state,
  }) {
    return OnbaordingLoadingState(
      onbaordingMode: onbaordingMode ?? state.onbaordingMode,
    );
  }
}

final class OnbaordingUpdatingState extends OnbaordingState {
  const OnbaordingUpdatingState({
    super.onbaordingMode,
  });
  @override
  factory OnbaordingUpdatingState.copyState({
    OnbaordingMode? onbaordingMode,
    required OnbaordingState state,
  }) {
    return OnbaordingUpdatingState(
      onbaordingMode: onbaordingMode ?? state.onbaordingMode,
    );
  }
}

final class OnbaordingLoadedState extends OnbaordingState {
  const OnbaordingLoadedState({
    super.onbaordingMode,
  });
  @override
  factory OnbaordingLoadedState.copyState({
    OnbaordingMode? onbaordingMode,
    required OnbaordingState state,
  }) {
    return OnbaordingLoadedState(
      onbaordingMode: onbaordingMode ?? state.onbaordingMode,
    );
  }
}

final class OnbaordingErrorState extends OnbaordingState {
  const OnbaordingErrorState({
    super.onbaordingMode,
  });
  @override
  factory OnbaordingErrorState.copyState({
    OnbaordingMode? onbaordingMode,
    required OnbaordingState state,
  }) {
    return OnbaordingErrorState(
      onbaordingMode: onbaordingMode ?? state.onbaordingMode,
    );
  }
}
