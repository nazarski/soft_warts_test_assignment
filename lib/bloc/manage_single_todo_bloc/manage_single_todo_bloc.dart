import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/enums/fetch_status.dart';
import 'package:soft_warts_test_task/models/todo_model.dart';
import 'package:soft_warts_test_task/repositories/manage_todos_repository.dart';

part 'manage_single_todo_event.dart';

part 'manage_single_todo_state.dart';

class ManageSingleTodoBloc
    extends Bloc<ManageSingleTodoEvent, ManageSingleTodoState> {
  final ManageTodosRepository repository;
  final TodoModel? initialTodo;

  ManageSingleTodoBloc({required this.repository, this.initialTodo})
      : super(initialTodo != null
            ? ManageSingleTodoState(todo: initialTodo)
            : const ManageSingleTodoState()) {
    on<ChangeType>(_changeType);
    on<SelectFinishDate>(_selectFinishDate);
    on<MakeUrgent>(_makeUrgent);
    on<AddImage>(_pickImage);
    on<DeleteImage>(_deleteImage);
    on<CreateTodo>(_createTodo);
    on<DeleteTodo>(_deleteTodo);
    on<UpdateTodo>(_updateTodo);
  }

  Future<void> _updateTodo(UpdateTodo event, Emitter emit) async {
    emit(state.copyWith(status: FetchStatus.loading));
    try {
      final todo = state.todo.copyWith(
        name: event.todoName,
        description: event.todoDescription,
      );
      print(todo);
      await repository.updateTodo(todo: todo);
      emit(state.copyWith(status: FetchStatus.data));
    } on Exception catch (error) {
      log(error.toString());
      emit(state.copyWith(status: FetchStatus.error));
    }
  }

  Future<void> _deleteTodo(_, Emitter emit) async {
    emit(state.copyWith(status: FetchStatus.loading));
    try {
      await repository.deleteTodo(todoId: state.todo.taskId);
      emit(state.copyWith(status: FetchStatus.data));
    } on Exception catch (error) {
      log(error.toString());
      emit(state.copyWith(status: FetchStatus.error));
    }
  }

  Future<void> _createTodo(CreateTodo event, Emitter emit) async {
    emit(state.copyWith(status: FetchStatus.loading));
    try {
      final todo = state.todo.copyWith(
        name: event.todoName,
        description: event.todoDescription,
        taskId: DateTime.now().millisecondsSinceEpoch.toString(),
        syncTime: DateTime.now(),
      );
      await repository.createTodo(todo: todo);
      emit(state.copyWith(status: FetchStatus.data));
    } on Exception catch (error) {
      log(error.toString());
      emit(state.copyWith(status: FetchStatus.error));
    }
  }

  void _deleteImage(_, Emitter emit) {
    final updatedTodo = state.todo.copyWith(file: '');
    emit(state.copyWith(todo: updatedTodo));
  }

  Future<void> _pickImage(_, Emitter emit) async {
    final image = await repository.pickImage();
    if (image.isNotEmpty) {
      final updatedTodo = state.todo.copyWith(file: image);
      emit(state.copyWith(todo: updatedTodo));
    }
  }

  void _changeType(ChangeType event, Emitter emit) {
    final updatedTodo = state.todo.copyWith(type: event.type);
    emit(state.copyWith(todo: updatedTodo));
  }

  void _selectFinishDate(SelectFinishDate event, Emitter emit) {
    final updatedTodo = state.todo.copyWith(finishDate: event.finishDate);
    emit(state.copyWith(todo: updatedTodo));
  }

  void _makeUrgent(MakeUrgent event, Emitter emit) {
    final updatedTodo = state.todo.copyWith(urgent: !state.todo.urgent);
    emit(state.copyWith(todo: updatedTodo));
  }
}
