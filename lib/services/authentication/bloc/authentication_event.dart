part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class AppStartedEvent extends AuthenticationEvent {}

final class SignInUserEvent extends AuthenticationEvent {
  final BuildContext context;
  final String accessToken;
  final String refreshToken;
  final Map<String, dynamic> user;
  const SignInUserEvent({
    required this.context,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });
}

final class SignOutUserEvent extends AuthenticationEvent {}
