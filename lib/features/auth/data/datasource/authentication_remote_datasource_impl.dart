import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firstapp/features/user/domain/entities/user.dart';
import 'package:firstapp/shared/errors/exceptions.dart';
import 'package:firstapp/shared/utils/typedef.dart';
import 'package:http/http.dart' as http;
import '../../../../shared/utils/base_url.dart';
import '../database/auth_model.dart';
import 'authentication_remote_datasource.dart';

const kCreateUserEndpoint = '$kBaseUrl/auth/register';
const kUserLoginEndpoint = '$kBaseUrl/auth/login';

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  final http.Client _client;

  const AuthenticationRemoteDatasourceImpl(this._client);

  @override
  Future<void> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(Uri.parse(kCreateUserEndpoint),
          body: jsonEncode({
            'name': name,
            'email': email,
            'password': password,
          }),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      return;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  ResultFuture<AuthModel> userLogin({
    required email,
    required password,
  }) async {
    final response = await _client.post(Uri.parse(kUserLoginEndpoint),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'});

    final result = response.body;

    return Right(AuthModel(
        token: result[0],
        user: const User(
            id: '1',
            name: 'Dipo',
            email: 'dipo@test.com',
            password: 'password')));
  }
}

/*
*
*
  @override
  Future<AuthModel> userLogin({
    required email,
    required password,
  }) async {
    final response = await _client.post(Uri.parse(kUserLoginEndpoint),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'});
  }
*
*
* */
