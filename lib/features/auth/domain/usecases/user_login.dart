import 'package:equatable/equatable.dart';
import 'package:firstapp/features/auth/data/database/auth_model.dart';
import 'package:firstapp/features/auth/domain/repositories/authentication_repository.dart';
import 'package:firstapp/shared/utils/typedef.dart';
import 'package:firstapp/shared/utils/usecase.dart';

class UserLoginUseCase extends UseCase<void, UserLoginParams> {
  final AuthenticationRepository _repository;

  UserLoginUseCase(this._repository);

  @override
  ResultFuture<AuthModel> call(params) {
    // TODO: implement call
    throw UnimplementedError();
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
