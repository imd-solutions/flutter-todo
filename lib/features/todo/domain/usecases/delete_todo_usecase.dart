import 'package:dartz/dartz.dart';
import 'package:firstapp/features/todo/domain/entities/todo.dart';
import 'package:firstapp/features/todo/domain/repositories/todo_repository.dart';
import 'package:firstapp/shared/errors/failure.dart';
import 'package:firstapp/shared/utils/usecase.dart';

class DeleteTodoUseCase implements UseCase<Todo, Params<Todo>> {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  @override
  Future<Either<Failure, Todo>> call(Params params) async {
    return await repository.delete(params.data);
  }
}
