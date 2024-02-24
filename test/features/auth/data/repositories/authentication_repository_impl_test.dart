import 'package:firstapp/features/auth/data/datasource/authentication_remote_datasource_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:firstapp/features/auth/data/models/auth_model.dart';
import 'package:firstapp/shared/errors/exceptions.dart';
import 'package:firstapp/shared/errors/failure.dart';
import 'package:firstapp/features/auth/data/repositories/authentication_repository_impl.dart';

class MockAuthenticationRemoteDatasourceImpl extends Mock
    implements AuthenticationRemoteDatasourceImpl {}

void main() {
  late AuthenticationRemoteDatasourceImpl remoteDatasourceImpl;
  late AuthenticationRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDatasourceImpl = MockAuthenticationRemoteDatasourceImpl();
    repositoryImpl = AuthenticationRepositoryImpl(remoteDatasourceImpl);
  });

  const tException = ApiException(message: 'Unknown Error', statusCode: 500);
  const tServerException =
      ServerException(message: 'No internet connection', statusCode: 500);

  group('createUser', () {
    const name = 'Test User';
    const email = 'user@test.com';
    const password = 'password';

    test(
        'should call the [RemoteDatasource.createUser] and return a proper data when the call is successful',
        () async {
      // arrange
      when(
        () => remoteDatasourceImpl.createUser(
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
        () => remoteDatasourceImpl.createUser(
            name: name, email: email, password: password),
      ).called(1);
    });

    test('should return a [ServerFailure] when call is unsuccssful', () async {
      // arrange
      when(
        () => remoteDatasourceImpl.createUser(
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
        () => remoteDatasourceImpl.createUser(
          name: name,
          email: email,
          password: password,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDatasourceImpl);
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
          () => remoteDatasourceImpl.userLogin(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => const Right(AuthModel.empty()));

        // action
        final result = await repositoryImpl.userLogin(
          email: email,
          password: password,
        );

        // assert
        expect(result, equals(const Right(AuthModel.empty())));
        verify(
          () => remoteDatasourceImpl.userLogin(
            email: email,
            password: password,
          ),
        ).called(1);
      },
    );

    test('should return a [ServerFailure] when call is unsuccessful', () async {
      // arrange
      when(
        () => remoteDatasourceImpl.userLogin(
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
        equals(
          Left(
            ApiFailure(
              message: tException.message,
              statusCode: tException.statusCode,
            ),
          ),
        ),
      );
      verify(
        () => remoteDatasourceImpl.userLogin(
          email: email,
          password: password,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDatasourceImpl);
    });

    test('should return connect failure if no internet', () async {
      // arrange
      when(
        () => remoteDatasourceImpl.userLogin(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(tServerException);

      // act
      final result = await repositoryImpl.userLogin(
        email: email,
        password: password,
      );

      // assert
      expect(
        result,
        equals(
          Left(
            ServerFailure(
              message: tServerException.message,
              statusCode: tServerException.statusCode,
            ),
          ),
        ),
      );
      verify(
        () => remoteDatasourceImpl.userLogin(
          email: email,
          password: password,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDatasourceImpl);
    });
  });
}
