import 'package:isar/isar.dart';
import 'package:soft_warts_test_task/models/todo_model.dart';

class IsarDb {
  final Isar _isar;

  IsarDb(this._isar);

  Future<List<TodoModel>> getAllTodosFromLocal() async {
    return await _isar.txn(() async {
      return await _isar.todoModels.where().findAll();
    });
  }

  Future<List<TodoModel>> getAllNonDeletedTodosFromLocal() async {
    return await _isar.txn(() async {
      return await _isar.todoModels.filter().lastDeletedAtIsNull().findAll();
    });
  }

  Future<List<TodoModel>> filterTodoByType({required int type}) async {
    return await _isar.txn(() async {
      return await _isar.todoModels
          .filter()
          .lastDeletedAtIsNull()
          .typeEqualTo(type)
          .findAll();
    });
  }

  Future<void> putSingleTodo({required TodoModel todo}) async {
    await _isar.writeTxn(() async {
      await _isar.todoModels.put(todo);
    });
  }

  Future<void> deleteSingleTodo({required String todoId}) async {
    await _isar.writeTxn(() async {
      await _isar.todoModels.filter().taskIdEqualTo(todoId).deleteAll();
    });
  }
}
