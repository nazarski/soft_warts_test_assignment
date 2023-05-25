
import 'package:soft_warts_test_task/data/local/isar_db.dart';
import 'package:soft_warts_test_task/data/remote/manage_todos_data.dart';
import 'package:soft_warts_test_task/models/todo_model.dart';

class ManageTodosRepository {
  final IsarDb _isarDb;
  final _remoteData = ManageTodosData();

  ManageTodosRepository(this._isarDb);

  ///Server CRUD operations
  Future<List<TodoModel>> getAllServerTodos() async {
    return await _remoteData.getAllTodos();
  }

  Future<void> updateServerTodoStatus(
      {required String taskId, required bool completed}) async {
    await _remoteData.updateTodoStatus(
        taskId: taskId, status: completed ? 2 : 1);
  }

  Future<void> createServerTodo({required TodoModel todo}) async {
    await _remoteData.createTodo(todo: todo);
  }

  Future<void> deleteServerTodo({required String todoId}) async {
    await _remoteData.deleteTodo(todoId: todoId);
  }

  Future<void> updateServerTodo({required TodoModel todo}) async {
    await _remoteData.updateTodo(todo: todo);
  }

  ///Local db CRUD operations
  Future<List<TodoModel>> getAllLocalTodos() async {
    return await _isarDb.getAllTodosFromLocal();
  }

  Future<List<TodoModel>> getAllNonDeletedLocalTodos() async {
    return await _isarDb.getAllNonDeletedTodosFromLocal();
  }

  Future<void> putLocalTodo({required TodoModel todo}) async {
    await _isarDb.putSingleTodo(todo: todo);
  }

  Future<void> deleteLocalTodo({required String todoId})async{
    await _isarDb.deleteSingleTodo(todoId: todoId);
  }

  Future<List<TodoModel>> filterNonDeletedTodosByType({required int type}) async {
    return await _isarDb.filterTodoByType(type: type);
  }

}
