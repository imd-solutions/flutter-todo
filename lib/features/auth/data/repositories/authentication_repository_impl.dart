import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../domain/entities/auth.dart';
import '../database/auth_model.dart';
import './../../../../shared/errors/exceptions.dart';
import './../../../../shared/errors/failure.dart';
import './../../../../features/auth/data/datasource/authentication_remote_datasource.dart';
import '../../../user/domain/entities/user.dart';
import './../../../../shared/utils/typedef.dart';
import './../../../../features/auth/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(this._remoteDataSource);

  final AuthenticationRemoteDatasource _remoteDataSource;

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
  ResultFuture<AuthModel> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.userLogin(
        email: email,
        password: password,
      );

      // final result = jsonEncode(response);

      return const Right(AuthModel(
          token: '1234567890',
          user: User(
              id: '1',
              name: 'Dipo',
              email: 'dipo@test.com',
              password: 'dadasda')));
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
