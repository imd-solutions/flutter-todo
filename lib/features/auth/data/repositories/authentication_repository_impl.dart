import 'package:dartz/dartz.dart';
import 'package:firstapp/shared/errors/exceptions.dart';
import 'package:firstapp/shared/errors/failure.dart';
import './../../../../features/auth/data/datasource/authentication_remote_datasource.dart';
import './../../../../features/auth/domain/entities/user.dart';
import './../../../../shared/utils/typedef.dart';
import './../../../../features/auth/domain/repositories/authentication_repositories.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository { 

  const AuthenticationRepositoryImpl(this._remoteDataSource);

  final AuthenticationRemoteDatasource _remoteDataSource;
  
  @override
  ResultFutureVoid createUser({
    required String name, 
    required String email, 
    required String password
  }) async {
    try {
      await _remoteDataSource.createUser(name: name, email: email, password: password);
      return const Right(null);
    } on ApiException catch(e) {
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    throw UnimplementedError();
  }
}
