import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/create_user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required CreateUserUseCase createUser})
      : _createUser = createUser,
        super(const AuthenticationInitial());

  final CreateUserUseCase _createUser;

  Future<void> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      name: name,
      email: email,
      password: password,
    ));

    result.fold(
      (failure) => emit(
        AuthenticationError(failure.errorMessage),
      ),
      (_) => emit(
        const UserCreated(),
      ),
    );
  }
}
