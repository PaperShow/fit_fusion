part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class Loading extends AuthState {}

final class UnAuthenticated extends AuthState {}

final class Registered extends AuthState {}

final class Authenticated extends AuthState {}

final class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}
