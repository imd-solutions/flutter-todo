import '../../../../shared/utils/typedef.dart';
import '../entities/user.dart';

abstract class UserRepository {
  const UserRepository();

  ResultFuture<List<User>> getUsers();
}
