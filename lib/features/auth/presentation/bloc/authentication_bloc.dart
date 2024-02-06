import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/create_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required CreateUser createUser})
      : _createUser = createUser,
        super(const AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
  }

  final CreateUser _createUser;

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(
        AuthenticationError(failure.errorMessage),
      ),
      (_) => const (UserCreated(),),
    );
  }
}
