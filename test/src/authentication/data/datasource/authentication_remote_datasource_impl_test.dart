
import 'dart:convert';

import 'package:firstapp/features/auth/data/datasource/authentication_remote_datasource.dart';
import 'package:firstapp/features/auth/data/datasource/authentication_remote_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {

  late http.Client client;
  late AuthenticationRemoteDatasource remoteDatasource;

  setUp(() {
    registerFallbackValue(Uri());
    client = MockClient();
    remoteDatasource = AuthenticationRemoteDatasourceImpl(client);
  });

  group('createUser', () {

    const name = 'Test User';
    const email = 'user@test.com';
    const password = 'password';

    test('should complete successfully when the [statusCode] is 200 or 201', () async {

        // arrange
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201)
          );

        // act
        final methodCall = remoteDatasource.createUser;

        // assert
        expect(methodCall(
          name: name, 
          email: email, 
          password: password
        ), completes);
        
        verify(() => client.post(
            Uri.parse(kCreateUserEndpoint), 
            body: jsonEncode({ 
              'name': name, 
              'email': email, 
              'password': password
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );


    test('should throw [ApiException] when status code is not 200 or 201', () async {
      
    });

  });


  group('getUsers', () {

   });



}