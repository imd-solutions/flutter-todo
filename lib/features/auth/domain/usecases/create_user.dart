import 'package:equatable/equatable.dart';

import './../../../../features/auth/data/repositories/authentication_repository_impl.dart';
import './../../../../shared/utils/typedef.dart';
import './../../../../shared/utils/usecase.dart';

class CreateUserUseCase extends UseCase<void, CreateUserParams> {
  final AuthenticationRepositoryImpl _repository;

  CreateUserUseCase(this._repository);

  @override
  ResultFuture<void> call(CreateUserParams params) async =>
      _repository.createUser(
        name: params.name,
        email: params.email,
        password: params.password,
      );
}

class CreateUserParams extends Equatable {
  final String name;
  final String email;
  final String password;

  const CreateUserParams({
    required this.name,
    required this.email,
    required this.password,
  });

  const CreateUserParams.empty()
      : this(
          name: '_empty.name',
          email: '_empty.email',
          password: '_empty.password',
        );

  @override
  List<Object?> get props => [name, email, password];
}
