import './../../../../features/auth/domain/entities/auth.dart';
import './../../../../shared/utils/typedef.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFutureVoid createUser({
    required String name,
    required String email,
    required String password,
  });

  ResultFuture<Auth> userLogin({
    required String email,
    required String password,
  });

  // Future<void> userLogout();

  // Future<void> forgottenPassword();
}
