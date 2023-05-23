import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:soft_warts_test_task/data/remote/manage_todos_data.dart';
import 'package:soft_warts_test_task/models/todo_model.dart';

class ManageTodosRepository {
  final _imagePicker = ImagePicker();
  final _remoteData = ManageTodosData();

  Future<List<TodoModel>> getAllTodos() async {
    return await _remoteData.getAllTodos();
  }

  Future<void> updateTodoStatus(
      {required String taskId, required bool completed}) async {
    await _remoteData.updateTodoStatus(
        taskId: taskId, status: completed ? 2 : 1);
  }

  Future<String> pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return '';
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  Future<void> createTodo({required TodoModel todo}) async {
    await _remoteData.createTodo(todo: todo);
  }
}
