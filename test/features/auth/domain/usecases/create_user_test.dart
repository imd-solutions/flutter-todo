import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:firstapp/features/auth/domain/repositories/authentication_repository.dart';
import 'package:firstapp/features/auth/domain/usecases/create_user.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late CreateUserUseCase createUserUseCase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    createUserUseCase = CreateUserUseCase(mockAuthenticationRepository);
  });

  const String name = 'Test User';
  const String email = 'user@test.com';
  const String password = 'password';

  test('should return correct data when a call to data source is successful',
      () async {
    when(() => mockAuthenticationRepository.createUser(
        name: name,
        email: email,
        password: password)).thenAnswer((_) async => const Right(null));

    final result = await createUserUseCase.call(
        const CreateUserParams(name: name, email: email, password: password));

    expect(result, const Right(null));
  });
}
