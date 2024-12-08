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

final class OnbaordingSuccessState extends OnbaordingState {
  final Map<String, dynamic> responseData;
  const OnbaordingSuccessState({
    super.onbaordingMode,
    required this.responseData,
  });
  @override
  factory OnbaordingSuccessState.copyState({
    OnbaordingMode? onbaordingMode,
    required OnbaordingState state,
    required Map<String, dynamic> responseData,
  }) {
    return OnbaordingSuccessState(
      onbaordingMode: onbaordingMode ?? state.onbaordingMode,
      responseData: responseData,
    );
  }
}

final class OnbaordingErrorState extends OnbaordingState {
  final String message;
  const OnbaordingErrorState({
    super.onbaordingMode,
    required this.message,
  });
  @override
  factory OnbaordingErrorState.copyState({
    OnbaordingMode? onbaordingMode,
    required OnbaordingState state,
    required String message,
  }) {
    return OnbaordingErrorState(
      onbaordingMode: onbaordingMode ?? state.onbaordingMode,
      message: message,
    );
  }
}
