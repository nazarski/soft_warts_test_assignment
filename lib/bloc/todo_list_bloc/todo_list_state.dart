part of 'todo_list_bloc.dart';

@immutable
class TodoListState {
  final List<TodoModel> listOfTodos;
  final FetchStatus status;
  final int listFilterIndex;

  const TodoListState({
    this.listFilterIndex = 0,
    this.listOfTodos = const [],
    this.status = FetchStatus.initial,
  });

  TodoListState copyWith({
    int? listFilterIndex,
    List<TodoModel>? listOfTodos,
    FetchStatus? status,
  }) {
    return TodoListState(
      listFilterIndex: listFilterIndex ?? this.listFilterIndex,
      listOfTodos: listOfTodos ?? this.listOfTodos,
      status: status ?? this.status,
    );
  }
}
