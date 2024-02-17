import './../entities/auth_entity.dart';
import './../../../../shared/utils/typedef.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFutureVoid createUser({
    required String name,
    required String email,
    required String password,
  });

  ResultFuture<AuthEntity> userLogin({
    required String email,
    required String password,
  });

  // Future<void> userLogout();

  // Future<void> forgottenPassword();
}
