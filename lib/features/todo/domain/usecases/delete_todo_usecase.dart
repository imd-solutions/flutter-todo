import './../../../../features/todo/domain/entities/todo.dart';
import './../../../../features/todo/domain/repositories/todo_repository.dart';
import './../../../../shared/utils/usecase.dart';
import '../../../../shared/utils/typedef.dart';

class DeleteTodoUseCase implements UseCase<Todo, Params<Todo>> {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  @override
  ResultFuture<Todo> call(Params params) async {
    return await repository.delete(params.data);
  }
}
