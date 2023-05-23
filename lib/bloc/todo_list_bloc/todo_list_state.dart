part of 'todo_list_bloc.dart';

@immutable
class TodoListState {
  final List<TodoModel> listOfTodos;
  final FetchStatus status;

  const TodoListState({
    this.listOfTodos = const [],
    this.status = FetchStatus.loading,
  });

  TodoListState copyWith({
    List<TodoModel>? listOfTodos,
    FetchStatus? status,
  }) {
    return TodoListState(
      listOfTodos: listOfTodos ?? this.listOfTodos,
      status: status ?? this.status,
    );
  }
}
