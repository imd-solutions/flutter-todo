import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firstapp/features/auth/data/models/auth_model.dart';
import 'package:firstapp/features/auth/domain/usecases/create_user.dart';
import 'package:firstapp/features/auth/domain/usecases/user_login.dart';
import 'package:firstapp/features/auth/presentation/cubit/authentication_cubit.dart';

import 'package:firstapp/shared/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateUser extends Mock implements CreateUserUseCase {}

class MockUserLoginUseCase extends Mock implements UserLoginUseCase {}

void main() {
  late MockCreateUser createUser;
  late MockUserLoginUseCase userLogin;
  late AuthenticationCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tUserLoginParams = UserLoginParams.empty();
  const tAuthFailure =
      AuthFailure(message: 'Invalid Credentials', statusCode: 404);

  setUp(() {
    createUser = MockCreateUser();
    userLogin = MockUserLoginUseCase();
    cubit = AuthenticationCubit(createUser: createUser, userLogin: userLogin);
    registerFallbackValue(tCreateUserParams);
    registerFallbackValue(tUserLoginParams);
  });

  tearDown(() => cubit.close());

  test('initial state should be [AuthenticationInitial]', () async {
    expect(cubit.state, const AuthenticationInitial());
  });

  group(
    'create user',
    () {
      blocTest<AuthenticationCubit, AuthenticationState>(
          'should emit [CreatingUser, UserCreated] when successful',
          build: () {
            when(() => createUser(any()))
                .thenAnswer((_) async => const Right(null));
            return cubit;
          },
          act: (cubit) => cubit.createUser(
                name: tCreateUserParams.name,
                email: tCreateUserParams.email,
                password: tCreateUserParams.password,
              ),
          expect: () => const <AuthenticationState>[
                CreatingUser(),
                UserCreated(),
              ],
          verify: (_) {
            verify(() => createUser(tCreateUserParams)).called(1);
            verifyNoMoreInteractions(createUser);
          });

      blocTest<AuthenticationCubit, AuthenticationState>(
          'should return error when unsuccessful',
          build: () {
            when(() => createUser(any()))
                .thenAnswer((_) async => const Left(tAuthFailure));
            return cubit;
          },
          act: (cubit) => cubit.createUser(
                name: tCreateUserParams.name,
                email: tCreateUserParams.email,
                password: tCreateUserParams.password,
              ),
          expect: () => [
                const CreatingUser(),
                AuthenticationError(
                    message: tAuthFailure.message,
                    statusCode: tAuthFailure.statusCode),
              ],
          verify: (_) {
            verify(() => createUser(tCreateUserParams)).called(1);
            verifyNoMoreInteractions(createUser);
          });
    },
  );

  group('user login', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
        'should log user in successfully',
        build: () {
          when(() => userLogin(any()))
              .thenAnswer((_) async => const Right(AuthModel.empty()));
          return cubit;
        },
        act: (cubit) => cubit.userLogin(
              email: tCreateUserParams.email,
              password: tCreateUserParams.password,
            ),
        expect: () => const <AuthenticationState>[
              LoginUserIn(),
              UserLoggedIn(),
            ],
        verify: (_) {
          verify(() => userLogin(tUserLoginParams)).called(1);
          verifyNoMoreInteractions(userLogin);
        });

    blocTest('should return invalid user if use credentials are incorect.',
        build: () {
          when(() => userLogin(any())).thenAnswer(
            (_) async => Left(
              AuthFailure(
                  message: tAuthFailure.message,
                  statusCode: tAuthFailure.statusCode),
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.userLogin(
              email: tCreateUserParams.email,
              password: tCreateUserParams.password,
            ),
        expect: () => <AuthenticationState>[
              const LoginUserIn(),
              AuthenticationError(
                  message: tAuthFailure.message,
                  statusCode: tAuthFailure.statusCode),
            ]);
  });
}
