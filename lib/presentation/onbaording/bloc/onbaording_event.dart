part of 'onbaording_bloc.dart';

@immutable
sealed class OnbaordingEvent {}

final class OnbaordingInitEvent extends OnbaordingEvent {}

final class ChangeOnbaordingModeEvent extends OnbaordingEvent {}

final class SignupEvent extends OnbaordingEvent {
  final String organisation;
  final String name;
  final String email;
  final String password;
  SignupEvent({
    required this.organisation,
    required this.name,
    required this.email,
    required this.password,
  });
}

final class SigninEvent extends OnbaordingEvent{
  final String email;
  final String password;
  SigninEvent({
    required this.email,
    required this.password,
  });
}
