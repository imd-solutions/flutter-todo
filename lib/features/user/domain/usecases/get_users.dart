import '../entities/user_entity.dart';
import '../../../../shared/utils/typedef.dart';
import '../../../../shared/utils/usecase.dart';
import '../repositories/user_repository.dart';

class GetUsers extends UseCase<List<UserEntity>, NoParams> {
  final UserRepository _repository;

  GetUsers(this._repository);

  @override
  ResultFuture<List<UserEntity>> call(NoParams params) async =>
      _repository.getUsers();
}
