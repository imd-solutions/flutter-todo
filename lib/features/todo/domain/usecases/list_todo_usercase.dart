import 'package:dartz/dartz.dart';
import 'package:firstapp/features/todo/domain/entities/todo.dart';
import 'package:firstapp/features/todo/domain/repositories/todo_repository.dart';
import 'package:firstapp/shared/errors/failure.dart';
import 'package:firstapp/shared/utils/usecase.dart';

class ListTodoUseCase implements UseCase<List<Todo>, NoParams> {
  final TodoRepository repository;

  ListTodoUseCase(this.repository);

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await repository.getAll();
  }
}
