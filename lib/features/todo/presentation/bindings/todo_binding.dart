import 'package:get/instance_manager.dart';
import './../../../../features/todo/data/database/todo_remote_database.dart';
import './../../../../features/todo/data/repositories/todo_repository_impl.dart';
import './../../../../features/todo/domain/repositories/todo_repository.dart';
import './../../../../features/todo/domain/usecases/add_todo_usecase.dart';
import './../../../../features/todo/domain/usecases/delete_todo_usecase.dart';
import './../../../../features/todo/domain/usecases/edit_todo_usercase.dart';
import './../../../../features/todo/domain/usecases/list_todo_usercase.dart';
import './../../../../features/todo/presentation/controller/todo_controller.dart';

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
