import 'package:dartz/dartz.dart';
import 'package:firstapp/shared/errors/exceptions.dart';
import 'package:firstapp/shared/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firstapp/features/auth/data/datasource/authentication_remote_datasource.dart';
import 'package:firstapp/features/auth/data/repositories/authentication_repository_impl.dart';

class MockAuthenticationRemoteDatasource extends Mock implements AuthenticationRemoteDatasource {} 

void main() {

  late AuthenticationRemoteDatasource remoteDatasource;
  late AuthenticationRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDatasource = MockAuthenticationRemoteDatasource();
    repositoryImpl = AuthenticationRepositoryImpl(remoteDatasource);
  });
  
    const tException = ApiException(message:'Unknown Error', statusCode: 500);

  group('createUser', () { 
    const name = 'Test User';
    const email = 'user@test.com';
    const password = 'password';
    test('should call the [remotedatasource.createUser] and return a proper data when the call is successful', () async {
      
      // arrange
      when(
        () => remoteDatasource.createUser(
          name: any(named: 'name'), 
          email: any(named: 'email'), 
          password: any(named: 'password'),
        ),
      )
      .thenAnswer((_) async => Future.value);
      
      // act
      final result = await repositoryImpl.createUser(
                                            name: name, 
                                            email: email, 
                                            password: password
                                          );

      // assert
      expect(result, equals(const Right(null)));
      verify(
        () => remoteDatasource.createUser(
          name: name, 
          email: email, 
          password: password
        )
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
      )
      .thenThrow(tException);

      // act
      final result = await repositoryImpl.createUser(
                                            name: name, 
                                            email: email, 
                                            password: password
                                          );

      // assert
      expect(result, equals(Left(ApiFailure(message: tException.message, statusCode: tException.statusCode))));
      verify(
        () => remoteDatasource.createUser(
          name: name, 
          email: email, 
          password: password
        )
      ).called(1);
      verifyNoMoreInteractions(remoteDatasource);

    });

  });
}