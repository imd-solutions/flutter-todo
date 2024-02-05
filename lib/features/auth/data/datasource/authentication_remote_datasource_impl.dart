import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../shared/utils/constant.dart';
import '../database/user_model.dart';
import 'authentication_remote_datasource.dart';

const kCreateUserEndpoint = '$kBaseUrl/users';
const kGetUserEndpoint = '$kBaseUrl/users';

class AuthenticationRemoteDatasourceImpl implements AuthenticationRemoteDatasource {

  final http.Client _client;

  const AuthenticationRemoteDatasourceImpl(this._client);
  
  @override
  Future<void> createUser({
    required String name, 
    required String email, 
    required String password
  }) async {
    
      await _client.post(Uri.parse(kCreateUserEndpoint), body: jsonEncode({
        'name': name, 
        'email': email, 
        'password': password
      })
    );
  }

  @override
  Future<List<UserModel>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}