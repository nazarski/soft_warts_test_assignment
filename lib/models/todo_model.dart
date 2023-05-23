import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

class TodoModel {
  final String taskId;
  final bool completed;
  final String name;
  final int type;
  final String description;
  final String file;
  final DateTime finishDate;
  final bool urgent;
  final DateTime syncTime;

//<editor-fold desc="Data Methods">
  const TodoModel({
    required this.taskId,
    required this.completed,
    required this.name,
    required this.type,
    required this.description,
    required this.file,
    required this.finishDate,
    required this.urgent,
    required this.syncTime,
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
      'finishDate': finishDate,
      'urgent': urgent ? 1 : 0,
      'syncTime': syncTime,
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
    bool? isActive,
    String? name,
    int? type,
    String? description,
    String? file,
    DateTime? finishDate,
    bool? urgent,
    DateTime? syncTime,
  }) {
    return TodoModel(
      taskId: taskId ?? this.taskId,
      completed: isActive ?? this.completed,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      file: file ?? this.file,
      finishDate: finishDate ?? this.finishDate,
      urgent: urgent ?? this.urgent,
      syncTime: syncTime ?? this.syncTime,
    );
  }
}
