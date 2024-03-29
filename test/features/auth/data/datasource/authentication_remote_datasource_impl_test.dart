import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firstapp/features/auth/data/models/auth_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:firstapp/features/auth/data/datasource/authentication_remote_datasource_impl.dart';
import 'package:firstapp/shared/errors/exceptions.dart';

import '../../../../helpers/json_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;
  late AuthenticationRemoteDatasourceImpl remoteDatasource;

  setUp(() {
    registerFallbackValue(Uri());
    client = MockClient();
    remoteDatasource = AuthenticationRemoteDatasourceImpl(client);
  });

  const tException = ApiException(
    message: '{ msg: "Something has gone wrong!"}',
    statusCode: 400,
  );

  group('createUser', () {
    const name = 'Test User';
    const email = 'user@test.com';
    const password = 'password';

    test(
      'should complete successfully when statusCode is 200 or 201',
      () async {
        // arrange
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            'User created successfully',
            201,
          ),
        );

        // act
        final methodCall = remoteDatasource.createUser;

        // assert
        expect(
          methodCall(
            name: name,
            email: email,
            password: password,
          ),
          completes,
        );

        verify(
          () => client.post(
            Uri.parse(kCreateUserEndpoint),
            body: jsonEncode(
              {
                'name': name,
                'email': email,
                'password': password,
              },
            ),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test('should throw [ApiException] when status code is not 200 or 201',
        () async {
      // arrange
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{ msg: "Something has gone wrong!"}',
          400,
        ),
      );

      final methodCall = remoteDatasource.createUser(
        name: name,
        email: email,
        password: password,
      );

      expect(
        methodCall,
        throwsA(tException),
      );

      verify(
        () => client.post(
          Uri.parse(kCreateUserEndpoint),
          body: jsonEncode(
            {
              'name': name,
              'email': email,
              'password': password,
            },
          ),
          headers: {'Content-Type': 'application/json'},
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('userLogin', () {
    const email = 'user@test.com';
    const password = 'password';

    test(
      'should return token and user information when user has successful logged in.',
      () async {
        // arrange
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('helpers/dummy_data/auth_response.json'),
            200,
          ),
        );

        // act
        final methodCall = remoteDatasource.userLogin;

        // assert
        expect(
          methodCall(
            email: email,
            password: password,
          ),
          completes,
        );

        final result =
            await remoteDatasource.userLogin(email: email, password: password);

        expect(
          result,
          Right(AuthModel.fromJson(
            jsonDecode(readJson('helpers/dummy_data/auth_response.json')),
          )),
        );

        verify(
          () => client.post(
            Uri.parse(kUserLoginEndpoint),
            body: jsonEncode(
              {
                'email': email,
                'password': password,
              },
            ),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(2);
        verifyNoMoreInteractions(client);
      },
    );

    test('should return [ApiException] if user has invalid credentials',
        () async {});
  });
}
