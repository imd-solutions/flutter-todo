import './../../../../features/todo/domain/entities/todo.dart';
import './../../../../features/todo/domain/repositories/todo_repository.dart';
import './../../../../shared/utils/typedef.dart';
import './../../../../shared/utils/usecase.dart';

class AddTodoUseCase implements UseCase<Todo, Params<Todo>> {
  final TodoRepository repository;

  AddTodoUseCase(this.repository);

  @override
  ResultFuture<Todo> call(Params params) async {
    return await repository.add(params.data);
  }
}
