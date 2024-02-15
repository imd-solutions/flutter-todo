import '../../data/database/auth_model.dart';
import './../../../../shared/utils/typedef.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFutureVoid createUser({
    required String name,
    required String email,
    required String password,
  });

  ResultFuture<AuthModel> userLogin({
    required String email,
    required String password,
  });

  // Future<void> userLogout();

  // Future<void> forgottenPassword();
}
