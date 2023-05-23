import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/enums/fetch_status.dart';
import 'package:soft_warts_test_task/models/todo_model.dart';
import 'package:soft_warts_test_task/repositories/manage_todos_repository.dart';

part 'todo_list_event.dart';

part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final ManageTodosRepository repository;

  TodoListBloc(this.repository) : super(const TodoListState()) {
    on<GetAllTodos>(_getAllTodos);
    on<FilterTodos>(_filterTodos);
    on<UpdateTodoCheckbox>(_updateCheckBox);
  }

  void _updateCheckBox(
    UpdateTodoCheckbox event,
    Emitter emit,
  ) {
    final updatedTodo = event.todo.copyWith(completed: event.isActive);
    final updatedList = state.listOfTodos.map((todo) {
      return todo.taskId == updatedTodo.taskId ? updatedTodo : todo;
    }).toList();
    emit(state.copyWith(listOfTodos: updatedList));
    repository.updateTodoStatus(
      taskId: updatedTodo.taskId,
      completed: updatedTodo.completed,
    );
  }

  Future<void> _filterTodos(FilterTodos event, Emitter emit) async {
    emit(state.copyWith(status: FetchStatus.loading));
    try {
      final allTodos = await repository.getAllTodos();
      if (event.todoType > 0) {
        final filteredList = allTodos
            .where(
              (todo) => todo.type == event.todoType,
            )
            .toList();
        emit(
          state.copyWith(listOfTodos: filteredList, status: FetchStatus.data),
        );
      } else {
        emit(
          state.copyWith(listOfTodos: allTodos, status: FetchStatus.data),
        );
      }
    } on Exception catch (error) {
      log('error: $error');
      emit(
        state.copyWith(
          status: FetchStatus.error,
        ),
      );
    }
  }

  Future<void> _getAllTodos(_, Emitter emit) async {
    emit(state.copyWith(status: FetchStatus.loading));
    try {
      final listOfTodos = await repository.getAllTodos();
      emit(
        state.copyWith(
          listOfTodos: listOfTodos,
          status: FetchStatus.data,
        ),
      );
    } on Exception catch (error) {
      log('error: $error');
      emit(
        state.copyWith(
          status: FetchStatus.error,
        ),
      );
    }
  }
}
