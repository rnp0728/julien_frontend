part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  final User? user;
  const AuthenticationState({
    this.user,
  });

  @override
  List<Object?> get props => [user];
}

final class UninitializedState extends AuthenticationState {
  const UninitializedState({super.user});
}

final class InitializingState extends AuthenticationState {
  const InitializingState({super.user});
}

final class InitializedState extends AuthenticationState {
  const InitializedState({super.user});
}

final class AuthenticatingState extends AuthenticationState {
  const AuthenticatingState({super.user});
}

final class AuthenticatedState extends AuthenticationState {
  const AuthenticatedState({super.user});
}

final class UnauthenticatedState extends AuthenticationState {
  const UnauthenticatedState({super.user});
}

final class AuthenticationErrorState extends AuthenticationState {
  final String message;

  const AuthenticationErrorState({required this.message, super.user});

  @override
  List<Object?> get props => [message, ...super.props];
}
