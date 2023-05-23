part of 'manage_single_todo_bloc.dart';

@immutable
class ManageSingleTodoState extends Equatable {
  final TodoModel todo;
  final FetchStatus status;

  const ManageSingleTodoState({
    this.todo = const TodoModel.empty(),
    this.status = FetchStatus.initial,
  });

  ManageSingleTodoState copyWith({
    TodoModel? todo,
    FetchStatus? status,
  }) {
    return ManageSingleTodoState(
      todo: todo ?? this.todo,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        todo,
        status,
      ];
}
