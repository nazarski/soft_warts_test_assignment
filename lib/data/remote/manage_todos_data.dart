import 'package:dio/dio.dart';
import 'package:soft_warts_test_task/models/todo_model.dart';

class ManageTodosData {
  final _dio = Dio(
    BaseOptions(baseUrl: 'https://to-do.softwars.com.ua'),
  );

  Future<List<TodoModel>> getAllTodos() async {
    final response = await _dio.get('/tasks');
    final data = List<Map<String, dynamic>>.from(response.data['data']);
    return data.map((todo) => TodoModel.fromMap(todo)).toList();
  }

  Future<void> updateTodoStatus({
    required String taskId,
    required int status,
  }) async {
    await _dio.put('/tasks/$taskId', data: {
      'status': status,
    });
  }
}
