import 'package:dartz/dartz.dart';
import './../../../../features/todo/data/database/todo_remote_database.dart';
import './../../../../features/todo/domain/entities/todo.dart';
import './../../../../features/todo/domain/repositories/todo_repository.dart';
import './../../../../shared/errors/failure.dart';
import './../../../../shared/utils/typedef.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatabase remoteDatabase;

  TodoRepositoryImpl({required this.remoteDatabase});

  @override
  ResultFuture<Todo> add(Todo todo) async {
    try {
      final results = await remoteDatabase.addTodo(todo);
      return Right(results);
    } catch (e) {
      return const Left(ApiFailure(
          message: "WHOOPS! Something has gone wrong. Unable to add.",
          statusCode: 500
          )
        );
    }
  }

  @override
  ResultFuture<Todo> delete(Todo todo) async {
    try {
      final results = await remoteDatabase.deleteTodo(todo);
      return Right(results);
    } catch (e) {
      return const Left(ApiFailure(
          message: "WHOOPS! Something has gone wrong. Unable to delete.",
          statusCode: 500
          )
        );
    }
  }

  @override
  ResultFuture<Todo> edit(Todo todo) async {
    try {
      final results = await remoteDatabase.editTodo(todo);
      return Right(results);
    } catch (e) {
      return const Left(ApiFailure(
          message: "WHOOPS! Something has gone wrong. Unable to edit.",
          statusCode: 500
          )
        );
    }
  }

  @override
  ResultFuture<Stream<List<Todo>>> getAll() async {
    try {
      final results = remoteDatabase.listTodos();
      return Right(results);
    } catch (e) {
      return const Left(ApiFailure(
          message: "WHOOPS! Something has gone wrong. Unable to get todos.",
          statusCode: 500
          )
        );
    }
  }
}
