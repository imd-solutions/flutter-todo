import 'package:equatable/equatable.dart';

import './../../../../features/auth/domain/repositories/authentication_repository.dart';
import './../../../../shared/utils/typedef.dart';
import './../../../../shared/utils/usecase.dart';

import '../entities/auth_entity.dart';

class UserLoginUseCase extends UseCase<void, UserLoginParams> {
  final AuthenticationRepository _repository;

  UserLoginUseCase(this._repository);

  @override
  ResultFuture<AuthEntity> call(params) {
    return _repository.userLogin(
        email: params.email, password: params.password);
  }
}

class UserLoginParams extends Equatable {
  final String email;
  final String password;

  const UserLoginParams({
    required this.email,
    required this.password,
  });

  const UserLoginParams.empty()
      : this(
          email: '_empty.email',
          password: '_empty.password',
        );

  @override
  List<Object?> get props => [email, password];
}
