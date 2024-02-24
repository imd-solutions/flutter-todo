import 'package:dartz/dartz.dart';
import 'package:firstapp/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:firstapp/features/auth/domain/usecases/create_user.dart';

class MockAuthenticationRepositoryImpl extends Mock
    implements AuthenticationRepositoryImpl {}

void main() {
  late CreateUserUseCase createUserUseCase;
  late MockAuthenticationRepositoryImpl mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepositoryImpl();
    createUserUseCase = CreateUserUseCase(mockAuthenticationRepository);
  });

  const String name = 'Test User';
  const String email = 'user@test.com';
  const String password = 'password';

  test('should return correct data when a call to data source is successful',
      () async {
    // arrange
    when(
      () => mockAuthenticationRepository.createUser(
          name: name, email: email, password: password),
    ).thenAnswer(
      (_) async => const Right(null),
    );

    // act
    final result = await createUserUseCase.call(
      const CreateUserParams(
        name: name,
        email: email,
        password: password,
      ),
    );

    // assert
    expect(result, const Right(null));
  });
}
