import 'dart:convert';
import 'dart:typed_data';

enum TodoStatus {
  active,
  done,
}

enum TodoType {
  work,
  personal,
}

class TodoModel {
  final String taskId;
  final TodoStatus status;
  final String name;
  final TodoType type;
  final String description;
  final Uint8List file;
  final DateTime finishDate;
  final bool urgent;
  final DateTime syncTime;

//<editor-fold desc="Data Methods">
  const TodoModel({
    required this.taskId,
    required this.status,
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
        ' status: $status,' +
        ' name: $name,' +
        ' type: $type,' +
        ' description: $description,' +
        ' file: $file,' +
        ' finishDate: $finishDate,' +
        ' urgent: $urgent,' +
        ' syncTime: $syncTime,' +
        '}';
  }

  TodoModel copyWith({
    String? taskId,
    TodoStatus? status,
    String? name,
    TodoType? type,
    String? description,
    Uint8List? file,
    DateTime? finishDate,
    bool? urgent,
    DateTime? syncTime,
  }) {
    return TodoModel(
      taskId: taskId ?? this.taskId,
      status: status ?? this.status,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      file: file ?? this.file,
      finishDate: finishDate ?? this.finishDate,
      urgent: urgent ?? this.urgent,
      syncTime: syncTime ?? this.syncTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'status': status.index + 1,
      'name': name,
      'type': type.index + 1,
      'description': description,
      'file': base64Encode(file),
      'finishDate': finishDate,
      'urgent': urgent,
      'syncTime': syncTime,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      taskId: map['taskId'] as String,
      status: map['status'] == 1 ? TodoStatus.active : TodoStatus.done,
      name: map['name'] as String,
      type: map['type'] == 1 ? TodoType.work : TodoType.personal,
      description: map['description'] as String,
      file: base64Decode(map['file']),
      finishDate: map['finishDate'] as DateTime,
      urgent: map['urgent'] as bool,
      syncTime: map['syncTime'] as DateTime,
    );
  }
}
