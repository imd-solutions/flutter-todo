import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:firstapp/features/auth/domain/repositories/authentication_repository.dart';
import 'package:firstapp/features/auth/domain/entities/auth_entity.dart';
import 'package:firstapp/features/auth/domain/usecases/user_login.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late UserLoginUseCase userLoginUseCase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    userLoginUseCase = UserLoginUseCase(mockAuthenticationRepository);
  });

  const String email = 'user@test.com';
  const String password = 'password';

  test('should return the correct object when called', () async {
    // arrange
    when(() => mockAuthenticationRepository.userLogin(
        email: email, password: password)).thenAnswer(
      (_) async => const Right(
        AuthEntity.empty(),
      ),
    );

    // act
    final result = await userLoginUseCase.call(
      const UserLoginParams(
        email: email,
        password: password,
      ),
    );

    // assert
    expect(
      result,
      const Right(
        AuthEntity.empty(),
      ),
    );
  });
}
