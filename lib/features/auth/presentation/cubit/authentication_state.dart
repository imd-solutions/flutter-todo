part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

class UserCreated extends AuthenticationState {
  const UserCreated();
}

class LoginUserIn extends AuthenticationState {
  const LoginUserIn();
}

class UserLoggedIn extends AuthenticationState {
  const UserLoggedIn();
}

class AuthenticationError extends AuthenticationState {
  final String message;
  final int statusCode;

  const AuthenticationError({required this.message, required this.statusCode});

  @override
  List<String> get props => [message];
}
