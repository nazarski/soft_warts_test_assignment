import 'package:isar/isar.dart';

part 'todo_model.g.dart';

@collection
class TodoModel {
  final Id? id;
  @Index(unique: true, replace: true)
  final String taskId;
  final bool completed;
  final String name;
  final int type;
  final String description;
  final String file;
  final DateTime? finishDate;
  final bool urgent;
  final DateTime? syncTime;
  final DateTime? lastDeletedAt;

  const TodoModel({
    this.id,
    required this.taskId,
    required this.completed,
    required this.name,
    required this.type,
    required this.description,
    required this.file,
    this.finishDate,
    required this.urgent,
    this.syncTime,
    this.lastDeletedAt,
  });

  const TodoModel.empty({
    this.id,
    this.taskId = '',
    this.completed = false,
    this.name = '',
    this.type = 1,
    this.description = '',
    this.file = '',
    this.finishDate,
    this.urgent = false,
    this.syncTime,
    this.lastDeletedAt,
  });

  @override
  String toString() {
    return 'TodoModel{' +
        ' taskId: $taskId,' +
        ' status: $completed,' +
        ' name: $name,' +
        ' type: $type,' +
        ' description: $description,' +
        ' file: $file,' +
        ' finishDate: $finishDate,' +
        ' urgent: $urgent,' +
        ' syncTime: $syncTime,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'status': completed ? 2 : 1,
      'name': name,
      'type': type,
      'description': description,
      'file': file,
      'finishDate': finishDate?.toIso8601String(),
      'urgent': urgent ? 1 : 0,
      'syncTime': syncTime?.toIso8601String(),
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      taskId: map['taskId'] as String,
      completed: map['status'] == 2,
      name: map['name'] as String,
      type: map['type'],
      description: map['description'] as String,
      file: map['file'],
      finishDate: DateTime.parse(map['finishDate']),
      urgent: map['urgent'] == 1,
      syncTime: DateTime.parse(map['syncTime']),
    );
  }

  TodoModel copyWith({
    String? taskId,
    bool? completed,
    String? name,
    int? type,
    String? description,
    String? file,
    DateTime? finishDate,
    bool? urgent,
    DateTime? syncTime,
    DateTime? lastDeletedAt,
  }) {
    return TodoModel(
      taskId: taskId ?? this.taskId,
      completed: completed ?? this.completed,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      file: file ?? this.file,
      finishDate: finishDate ?? this.finishDate,
      urgent: urgent ?? this.urgent,
      syncTime: syncTime ?? this.syncTime,
      lastDeletedAt: lastDeletedAt ?? this.lastDeletedAt,
    );
  }
}
