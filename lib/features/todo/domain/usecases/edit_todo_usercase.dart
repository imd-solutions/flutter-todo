import './../../../../features/todo/domain/entities/todo.dart';
import './../../../../features/todo/domain/repositories/todo_repository.dart';
import './../../../../shared/utils/usecase.dart';
import '../../../../shared/utils/typedef.dart';

class EditTodoUseCase implements UseCase<Todo, Params<Todo>> {
  final TodoRepository repository;

  EditTodoUseCase(this.repository);

  @override
  ResultFuture<Todo> call(Params params) async {
    return await repository.edit(params.data);
  }
}
