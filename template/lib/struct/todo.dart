import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final DateTime dateCreated;
  final String taskName;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.dateCreated,
    required this.taskName,
    required this.isCompleted,
  });

  factory Todo.create({
    required String taskName,
    required bool isCompleted,
  }) {
    return Todo(
      id: const Uuid().v4(),
      dateCreated: DateTime.now(),
      taskName: taskName,
      isCompleted: isCompleted,
    );
  }

  Todo copyWith({
    String? id,
    DateTime? dateCreated,
    String? taskName,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      taskName: taskName ?? this.taskName,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'Todo{id: $id, dateCreated: $dateCreated, taskName: $taskName, isCompleted: $isCompleted}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          dateCreated == other.dateCreated &&
          taskName == other.taskName &&
          isCompleted == other.isCompleted);

  @override
  int get hashCode =>
      id.hashCode ^
      dateCreated.hashCode ^
      taskName.hashCode ^
      isCompleted.hashCode;
}
