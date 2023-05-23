import 'package:soft_warts_test_task/data/remote/manage_todos_data.dart';
import 'package:soft_warts_test_task/models/todo_model.dart';

class ManageTodosRepository {
  final _remoteData = ManageTodosData();

  Future<List<TodoModel>> getAllTodos() async {
    return await _remoteData.getAllTodos();
  }

  Future<void> updateTodoStatus(
      {required String taskId, required bool completed}) async {
    await _remoteData.updateTodoStatus(
        taskId: taskId, status: completed ? 2 : 1);
  }
}
