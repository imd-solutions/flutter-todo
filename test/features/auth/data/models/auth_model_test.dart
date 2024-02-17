import 'dart:convert';

import 'package:firstapp/features/user/data/database/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firstapp/features/auth/data/models/auth_model.dart';
import 'package:firstapp/features/auth/domain/entities/auth_entity.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  const AuthModel tAuthModel = AuthModel.empty();

  group('AuthModel tests', () {
    test('the model is equal to the same as [AuthEntity]', () async {
      expect(tAuthModel, isA<AuthEntity>());
    });

    test('should return a valid model from json', () async {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(
        readJson('helpers/dummy_data/auth_response.json'),
      );

      //act
      final result = AuthModel.fromJson(jsonMap);

      //assert
      expect(result, equals(tAuthModel));
    });

    test('should return a json map with the correct data', () async {
      // act
      final result = tAuthModel.toJson();

      // assert
      final expectedJsonMap = {
        'token': '_empty.string_token',
        'user': const UserModel.empty(),
      };

      expect(result, equals(expectedJsonMap));
    });
  });
}
