import 'package:firstapp/features/user/data/database/user_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:firstapp/features/auth/data/database/auth_model.dart';
import 'package:firstapp/features/user/domain/entities/user.dart';
import 'package:firstapp/shared/errors/exceptions.dart';
import 'package:firstapp/shared/errors/failure.dart';
import 'package:firstapp/features/auth/data/datasource/authentication_remote_datasource.dart';
import 'package:firstapp/features/auth/data/repositories/authentication_repository_impl.dart';

class MockAuthenticationRemoteDatasource extends Mock
    implements AuthenticationRemoteDatasource {}

void main() {
  late AuthenticationRemoteDatasource remoteDatasource;
  late AuthenticationRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDatasource = MockAuthenticationRemoteDatasource();
    repositoryImpl = AuthenticationRepositoryImpl(remoteDatasource);
  });

  const tException = ApiException(message: 'Unknown Error', statusCode: 500);
  const tAuthJWT = AuthModel(
    token: '1234567890',
    user: UserModel(
        id: '1',
        name: 'Dipo George',
        email: 'dipo@test.com',
        password: 'password'),
  );

  group('createUser', () {
    const name = 'Test User';
    const email = 'user@test.com';
    const password = 'password';

    test(
        'should call the [RemoteDatasource.createUser] and return a proper data when the call is successful',
        () async {
      // arrange
      when(
        () => remoteDatasource.createUser(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Right(null));

      // act
      final result = await repositoryImpl.createUser(
        name: name,
        email: email,
        password: password,
      );

      // assert
      expect(result, equals(const Right(null)));
      verify(
        () => remoteDatasource.createUser(
            name: name, email: email, password: password),
      ).called(1);
    });

    test('should return a [ServerFailure] when call is unsuccssful', () async {
      // arrange
      when(
        () => remoteDatasource.createUser(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(tException);

      // act
      final result = await repositoryImpl.createUser(
        name: name,
        email: email,
        password: password,
      );

      // assert
      expect(
          result,
          equals(Left(
            ApiFailure(
              message: tException.message,
              statusCode: tException.statusCode,
            ),
          )));
      verify(
        () => remoteDatasource.createUser(
          name: name,
          email: email,
          password: password,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });
  });

  group('userLogin', () {
    const email = 'user@test.com';
    const password = 'password';

    test(
      'Should call the [RemoteDatasource.userLogin] and return the user data and JWT when successful',
      () async {
        // arrange
        when(
          () => remoteDatasource.userLogin(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => const Right(tAuthJWT));

        // action
        final result = await repositoryImpl.userLogin(
          email: email,
          password: password,
        );

        // assert
        expect(result, equals(const Right(tAuthJWT)));
        verify(
          () => remoteDatasource.userLogin(
            email: email,
            password: password,
          ),
        ).called(1);
      },
    );

    test('should return a [ServerFailure] when call is unsuccessful', () async {
      // arrange
      when(
        () => remoteDatasource.userLogin(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(tException);

      // act
      final result = await repositoryImpl.userLogin(
        email: email,
        password: password,
      );

      // assert
      expect(
          result,
          equals(Left(ApiFailure(
            message: tException.message,
            statusCode: tException.statusCode,
          ))));
      verify(
        () => remoteDatasource.userLogin(
          email: email,
          password: password,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });
  });
}
