import 'package:dartz/dartz.dart';
import 'package:firstapp/features/auth/data/database/auth_model.dart';
import 'package:firstapp/features/auth/domain/usecases/user_login.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'create_user_test.dart';

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
    when(() => mockAuthenticationRepository.userLogin(
        email: email, password: password)).thenAnswer(
      (_) async => const Right(
        AuthModel.empty(),
      ),
    );

    final result = await userLoginUseCase.call(
      const UserLoginParams(
        email: email,
        password: password,
      ),
    );

    expect(
      result,
      const Right(
        AuthModel.empty(),
      ),
    );
  });
}
