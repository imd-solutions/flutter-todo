import './../../../../shared/utils/typedef.dart';
import './../entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFutureVoid createUser({
    required String name,
    required String email,
    required String password,
  });

  ResultFuture<List<User>> getUsers();
}
