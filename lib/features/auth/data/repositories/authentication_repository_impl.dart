import 'package:dartz/dartz.dart';

import './../../../../features/auth/data/datasource/authentication_remote_datasource_impl.dart';
import './../../../../features/auth/domain/entities/auth_entity.dart';
import './../../../../features/auth/domain/repositories/authentication_repository.dart';
import './../../../../shared/errors/exceptions.dart';
import './../../../../shared/errors/failure.dart';
import './../../../../shared/utils/typedef.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDatasourceImpl _remoteDataSource;
  const AuthenticationRepositoryImpl(this._remoteDataSource);

  @override
  ResultFutureVoid createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _remoteDataSource.createUser(
        name: name,
        email: email,
        password: password,
      );
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<AuthEntity> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.userLogin(
        email: email,
        password: password,
      );
      return response;
    } on ApiException catch (e) {
      return Left(
        ApiFailure.fromException(e),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure.fromException(e),
      );
    }
  }
}
