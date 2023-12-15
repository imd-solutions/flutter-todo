// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firstapp/features/todo/domain/entities/todo.dart';
// import 'package:firstapp/features/todo/domain/usecases/list_todo_usercase.dart';
import 'package:firstapp/shared/utils/random_id.dart';
import 'package:firstapp/shared/utils/usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firstapp/features/todo/domain/usecases/add_todo_usecase.dart';

class TodoController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final AddTodoUseCase addTodoUseCase;
  // final ListTodoUseCase listTodoUseCase;

  TodoController({
    required this.addTodoUseCase,
    // required this.listTodoUseCase,
  });

  Future<void> addTodo() async {
    final results = await addTodoUseCase(Params(
      Todo(
        id: generateRandomId(10),
        text: titleController.text.trim(),
        description: descriptionController.text.trim(),
      ),
    ));
    results.fold((failure) {
      Get.snackbar("Error", failure.message);
    }, (todo) {
      // clear form
      titleController.clear();
      descriptionController.clear();
      Get.snackbar("Success", "Todo added successfully");
    });
  }
}
