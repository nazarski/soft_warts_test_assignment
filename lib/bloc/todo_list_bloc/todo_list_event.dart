part of 'todo_list_bloc.dart';

@immutable
abstract class TodoListEvent {}

class GetAllTodos extends TodoListEvent{}

class FilterTodos extends TodoListEvent{
  final int todoType;

  FilterTodos(this.todoType);

}
class UpdateTodoCheckbox extends TodoListEvent{
  final TodoModel todo;
  final bool isActive;

  UpdateTodoCheckbox(this.todo, this.isActive);

}
