import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firstapp/features/auth/domain/usecases/create_user.dart';
import 'package:firstapp/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();

  setUp(() {
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(createUser: createUser);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());

  test('initial state should be [AuthenticationInitial]', () async {
    expect(cubit.state, const AuthenticationInitial());
  });

  group('create user', () {
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
        });
  });
}
