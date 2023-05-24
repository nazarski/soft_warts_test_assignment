import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:soft_warts_test_task/models/todo_model.dart';

class ManageTodosData {
  final _dio = Dio(
    BaseOptions(baseUrl: 'https://to-do.softwars.com.ua'),
  );

  Future<List<TodoModel>> getAllTodos() async {
    final response = await _dio.get('/tasks');
    return _mapTodosResponse(response);
  }

  Future<void> updateTodoStatus({
    required String taskId,
    required int status,
  }) async {
    await _dio.put('/tasks/$taskId', data: {
      'status': status,
    });
  }

  Future<void> createTodo({required TodoModel todo}) async {
    final data = todo.toMap();
    await _dio.post('/tasks', data: [data]);
  }

  Future<void> deleteTodo({required String todoId}) async {
    await _dio.delete('/tasks/$todoId');
  }

  Future<void> updateTodo({required TodoModel todo}) async {
    final data = todo.toMap();
   final response = await _dio.put('/tasks/${todo.taskId}', data: data);
   debugPrint(response.toString());
  }

  List<TodoModel> _mapTodosResponse(Response response) {
    final data = List<Map<String, dynamic>>.from(response.data['data']);
    return data.map((todo) => TodoModel.fromMap(todo)).toList();
  }
}
