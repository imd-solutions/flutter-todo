import 'package:firstapp/features/todo/data/database/todo_remote_database.dart';
import 'package:firstapp/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:firstapp/features/todo/domain/repositories/todo_repository.dart';
import 'package:firstapp/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:firstapp/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:firstapp/features/todo/domain/usecases/edit_todo_usercase.dart';
import 'package:firstapp/features/todo/domain/usecases/list_todo_usercase.dart';
import 'package:firstapp/features/todo/presentation/controller/todo_controller.dart';
import 'package:get/instance_manager.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoRemoteDatabase>(() => TodoRemoteDatabaseImpl());
    Get.lazyPut<TodoRepository>(
        () => TodoRepositoryImpl(remoteDatabase: Get.find()));
    Get.lazyPut(() => AddTodoUseCase(Get.find()));
    Get.lazyPut(() => ListTodoUseCase(Get.find()));
    Get.lazyPut(() => DeleteTodoUseCase(Get.find()));
    Get.lazyPut(() => EditTodoUseCase(Get.find()));
    Get.lazyPut(
      () => TodoController(
        addTodoUseCase: Get.find(),
        listTodoUseCase: Get.find(),
      ),
    );
  }
}
