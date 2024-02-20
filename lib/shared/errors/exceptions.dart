import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const ApiException({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class AuthException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const AuthException({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const ServerException({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class DatabaseException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const DatabaseException({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}
