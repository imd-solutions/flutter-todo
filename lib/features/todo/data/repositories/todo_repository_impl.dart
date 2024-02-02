import 'package:dartz/dartz.dart';
import 'package:firstapp/features/todo/data/database/todo_remote_database.dart';
import 'package:firstapp/features/todo/domain/entities/todo.dart';
import 'package:firstapp/features/todo/domain/repositories/todo_repository.dart';
import 'package:firstapp/shared/errors/failure.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatabase remoteDatabase;

  TodoRepositoryImpl({required this.remoteDatabase});

  @override
  Future<Either<Failure, Todo>> add(Todo todo) async {
    try {
      final results = await remoteDatabase.addTodo(todo);
      return Right(results);
    } catch (e) {
      return const Left(Failure(
          message: "WHOOPS! Something has gone wrong. Unable to add.",
          statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Todo>> delete(Todo todo) async {
    try {
      final results = await remoteDatabase.deleteTodo(todo);
      return Right(results);
    } catch (e) {
      return const Left(Failure(
          message: "WHOOPS! Something has gone wrong. Unable to delete.",
          statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Todo>> edit(Todo todo) async {
    try {
      final results = await remoteDatabase.editTodo(todo);
      return Right(results);
    } catch (e) {
      return const Left(Failure(
          message: "WHOOPS! Something has gone wrong. Unable to edit.",
          statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Stream<List<Todo>>>> getAll() async {
    try {
      final results = remoteDatabase.listTodos();
      return Right(results);
    } catch (e) {
      return const Left(Failure(
          message: "WHOOPS! Something has gone wrong. Unable to get todos.",
          statusCode: 500));
    }
  }
}
