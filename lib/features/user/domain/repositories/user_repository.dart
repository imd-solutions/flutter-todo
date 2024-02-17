import '../../../../shared/utils/typedef.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  const UserRepository();

  ResultFuture<List<UserEntity>> getUsers();
}
