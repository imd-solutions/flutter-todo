import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../user/data/database/user_model.dart';
import '../../domain/entities/auth_entity.dart';
import './../../../../shared/errors/exceptions.dart';
import './../../../../shared/errors/failure.dart';
import './../../../../features/auth/data/datasource/authentication_remote_datasource.dart';
import './../../../../shared/utils/typedef.dart';
import './../../../../features/auth/domain/repositories/authentication_repository.dart';
import '../models/auth_model.dart';

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
      return response;
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
