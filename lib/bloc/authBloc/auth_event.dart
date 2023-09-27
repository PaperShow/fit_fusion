part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class RegisterEvent extends AuthEvent {
  final UserModel user;
  const RegisterEvent({required this.user});

  @override
  List<Object> get props => [user];
}

final class LoginEvent extends AuthEvent {
  final String email;
  const LoginEvent({required this.email});

  @override
  List<Object> get props => [email];
}

final class LoginStatus extends AuthEvent {
  @override
  List<Object> get props => [];
}
