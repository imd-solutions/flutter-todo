import 'package:dartz/dartz.dart';
import 'package:firstapp/features/todo/domain/entities/todo.dart';
import 'package:firstapp/shared/errors/failure.dart';

import '../../../../shared/utils/typedef.dart';

abstract class TodoRepository {
  // Add Todo
  ResultFuture<Todo> add(Todo todo);
  // Edit Todo
  ResultFuture<Todo> edit(Todo todo);
  // // Delete Todo
  ResultFuture<Todo> delete(Todo todo);
  // // Get all Todo items
  Future<Either<Failure, Stream<List<Todo>>>> getAll();
}
