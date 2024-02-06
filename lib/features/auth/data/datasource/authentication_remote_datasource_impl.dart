import 'dart:convert';

import 'package:firstapp/shared/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import '../../../../shared/utils/constant.dart';
import '../database/user_model.dart';
import 'authentication_remote_datasource.dart';

const kCreateUserEndpoint = '$kBaseUrl/users';
const kGetUserEndpoint = '$kBaseUrl/users';

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
          }));

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
  Future<List<UserModel>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
