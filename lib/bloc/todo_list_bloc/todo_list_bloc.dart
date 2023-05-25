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
  bool _hasConnection = false;

  TodoListBloc(this.repository) : super(const TodoListState()) {
    on<ChangeHasConnectionFlagList>(_changeConnectivityFlag);
    on<FilterTodos>(_filterTodos);
    on<UpdateTodoCheckbox>(_updateCheckBox);
    on<SyncTodosAndEmit>(_checkForConnectionAndFetch);
  }

  void _changeConnectivityFlag(ChangeHasConnectionFlagList event, _) {
    _hasConnection = event.hasConnection;
  }

  Future<void> _checkForConnectionAndFetch(_, Emitter emit) async {
    emit(state.copyWith(status: FetchStatus.loading));
    if (_hasConnection) {
      log('device has a connection, start sync');
      await _syncTodosAndEmit(_, emit);
    } else {
      log('device has no connection, fetch from local');
      add(FilterTodos());
    }
  }

  Future<void> _syncTodosAndEmit(_, Emitter emit) async {
    try {
      final serverTodos = await repository.getAllServerTodos();
      final localTodos = await repository.getAllLocalTodos();
      final syncedTodos = await _syncTodos(
        localTodos: localTodos,
        serverTodos: serverTodos,
      ).toList();
      emit(
        state.copyWith(listOfTodos: syncedTodos, status: FetchStatus.data),
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

  void _updateCheckBox(
    UpdateTodoCheckbox event,
    Emitter emit,
  ) {
    final updatedTodo = event.todo.copyWith(completed: event.isActive);
    final updatedList = state.listOfTodos.map((todo) {
      return todo.taskId == updatedTodo.taskId ? updatedTodo : todo;
    }).toList();
    emit(state.copyWith(listOfTodos: updatedList));
    repository.putLocalTodo(todo: updatedTodo);
    if (_hasConnection) {
      repository.updateServerTodoStatus(
        taskId: updatedTodo.taskId,
        completed: updatedTodo.completed,
      );
    }
  }

  Future<void> _filterTodos(FilterTodos event, Emitter emit) async {
    final int typeIndex = event.todoType ?? state.listFilterIndex;
    emit(
      state.copyWith(
        listFilterIndex: typeIndex,
        status: FetchStatus.loading,
      ),
    );
    try {
      final List<TodoModel> listOfTodos;
      if (typeIndex > 0) {
        listOfTodos =
            await repository.filterNonDeletedTodosByType(type: typeIndex);
        emit(
            state.copyWith(status: FetchStatus.data, listOfTodos: listOfTodos));
      } else {
        listOfTodos = await repository.getAllNonDeletedLocalTodos();
        emit(
            state.copyWith(status: FetchStatus.data, listOfTodos: listOfTodos));
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

  Stream<TodoModel> _syncTodos(
      {required List<TodoModel> localTodos,
      required List<TodoModel> serverTodos}) async* {
    ///Generating maps for easy access through todoId
    final localTodosMap = {
      for (TodoModel todo in localTodos) todo.taskId: todo,
    };

    final serverTodosMap = {
      for (TodoModel todo in serverTodos) todo.taskId: todo,
    };

    ///Creating newest syncTime value;
    DateTime currentSyncTime = DateTime.now();

    for (String todoId in localTodosMap.keys) {
      final TodoModel localTodo = localTodosMap[todoId]!;
      final TodoModel? serverTodo = serverTodosMap[todoId];

      ///Case when server and local db has same todos
      if (serverTodo != null) {
        ///Check if localTodo has latest data comparing last sync time
        if (localTodo.syncTime!.isAfter(serverTodo.syncTime!)) {
          ///Create updated todo
          final updatedTodo = localTodo.copyWith(syncTime: currentSyncTime);

          ///Send updated todo to the server
          await repository.createServerTodo(todo: updatedTodo);

          ///Throw todo to the stream
          yield updatedTodo;

          ///Check if serverTodo has latest data comparing last sync time
        } else if (serverTodo.syncTime!.isAfter(localTodo.syncTime!)) {
          ///Create updated todo
          final updatedTodo = serverTodo.copyWith(syncTime: currentSyncTime);

          ///Save updated todo in local db
          await repository.putLocalTodo(todo: updatedTodo);

          ///Throw todo to the stream
          yield updatedTodo;
        }

        ///Case when local db has todos, are not present on server
      } else {
        ///Create updated todo
        final updatedTodo = localTodo.copyWith(syncTime: currentSyncTime);

        ///Send updated todo to the server
        await repository.createServerTodo(todo: updatedTodo);

        ///Throw todo to the stream
        yield updatedTodo;
      }
    }

    for (String todoId in serverTodosMap.keys) {
      final TodoModel serverTodo = serverTodosMap[todoId]!;
      if (localTodosMap.containsKey(todoId)) {
        final TodoModel localTodo = localTodosMap[todoId]!;
        if (localTodo.lastDeletedAt != null &&
            localTodo.lastDeletedAt!.isAfter(localTodo.syncTime!)) {
          ///If a local todo has been marked as deleted,
          ///remove it from the local db and the server
          await repository.deleteLocalTodo(todoId: todoId);
          await repository.deleteServerTodo(todoId: todoId);
        }
      } else {
        ///If the local db does not contain the server todo,
        ///add it to the local db
        final updatedTodo = serverTodo.copyWith(syncTime: currentSyncTime);
        await repository.putLocalTodo(todo: updatedTodo);
        yield updatedTodo;
      }
    }
  }
}
