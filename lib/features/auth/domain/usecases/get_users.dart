import '../entities/user.dart';
import '../repositories/authentication_repositories.dart';
import './../../../../shared/utils/typedef.dart';
import './../../../../shared/utils/usecase.dart';

class GetUsers extends UseCase<List<User>, NoParams> {
  final AuthenticationRepository _repository;

  GetUsers(this._repository);

  @override
  ResultFuture<List<User>> call(NoParams params) async =>
      _repository.getUsers();
}
