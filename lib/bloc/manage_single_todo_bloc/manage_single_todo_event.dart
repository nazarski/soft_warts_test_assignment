part of 'manage_single_todo_bloc.dart';

@immutable
abstract class ManageSingleTodoEvent {}

class CreateTodo extends ManageSingleTodoEvent {
  final String todoName;
  final String todoDescription;

  CreateTodo({
    required this.todoName,
    required this.todoDescription,
  });
}

class ChangeType extends ManageSingleTodoEvent{
  final int type;

  ChangeType({required this.type});

}
class AddImage extends ManageSingleTodoEvent{}
class DeleteImage extends ManageSingleTodoEvent{}


class SelectFinishDate extends ManageSingleTodoEvent{
  final DateTime finishDate;

  SelectFinishDate(this.finishDate);
}

class MakeUrgent extends ManageSingleTodoEvent{}