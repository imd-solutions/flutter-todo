import 'package:dartz/dartz.dart';
import 'package:firstapp/features/todo/domain/entities/todo.dart';
import 'package:firstapp/shared/errors/failure.dart';

abstract class TodoRepository {
  // Add Todo
  Future<Either<Failure, Todo>> add(Todo todo);
  // Edit Todo
  Future<Either<Failure, Todo>> edit(Todo todo);
  // Delete Todo
  Future<Either<Failure, Todo>> delete(Todo todo);
  // Get all Todo items
  Future<Either<Failure, List<Todo>>> getAll();
}
