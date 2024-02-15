import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:firstapp/features/auth/data/database/auth_model.dart';
import 'package:firstapp/features/auth/domain/entities/auth.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  const AuthModel tAuthModel = AuthModel.empty();

  // Model equal the entity.
  test('the model is equal to the same as [AuthEntity]', () async {
    expect(tAuthModel, isA<Auth>());
  });

  // Returns json.
  test('should return a json format', () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(
      readJson('helpers/dummy_data/auth_response.json'),
    );

    //act
    final result = AuthModel.fromJson(jsonMap);

    //assert
    expect(result, equals(tAuthModel));
  });

  //
}
