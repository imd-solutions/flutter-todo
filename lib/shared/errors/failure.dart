import 'package:equatable/equatable.dart';
import './../../shared/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  String get errorMessage => '$statusCode Error: $message';

  const Failure({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  ApiFailure.fromException(ApiException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message, required super.statusCode});

  DatabaseFailure.fromException(DatabaseException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
