import './../../../../features/auth/data/models/auth_model.dart';
import '../../../../shared/utils/typedef.dart';

abstract class AuthenticationRemoteDatasource {
  ResultFutureVoid createUser({
    required String name,
    required String email,
    required String password,
  });

  ResultFuture<AuthModel> userLogin({
    required email,
    required password,
  });
}
