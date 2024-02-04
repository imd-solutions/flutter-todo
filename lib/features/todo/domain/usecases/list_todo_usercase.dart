import 'package:dartz/dartz.dart';
import './../../../../features/todo/domain/entities/todo.dart';
import './../../../../features/todo/domain/repositories/todo_repository.dart';
import './../../../../shared/errors/failure.dart';
import './../../../../shared/utils/usecase.dart';

class ListTodoUseCase implements UseCase<Stream<List<Todo>>, NoParams> {
  final TodoRepository repository;

  ListTodoUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<List<Todo>>>> call(NoParams params) {
    return repository.getAll();
  }
}
