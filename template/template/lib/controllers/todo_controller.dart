import 'dart:convert';
import 'dart:async';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:template/main.dart';
import 'package:template/struct/todo.dart';

class TodoController {
  static const _todoKey = 'todo_list';

  final StreamController<List<Todo>> _todoStreamController =
      StreamController<List<Todo>>.broadcast();
  List<Todo> _todos = [];

  TodoController() {
    _loadTodos();
  }

  void emitStream() {
    _todoStreamController.add(_todos);
  }

  Stream<List<Todo>> get todosStream {
    _todoStreamController.add(_todos);
    return _todoStreamController.stream;
  }

  void _loadTodos() {
    final todoListString = prefs.getString(_todoKey) ?? '[]';
    final List<dynamic> todoListJson = json.decode(todoListString);

    _todos = todoListJson
        .map((jsonItem) => Todo(
              id: jsonItem['id'] ?? "",
              dateCreated: DateTime.parse(jsonItem['dateCreated'] ?? ""),
              taskName: jsonItem['taskName'] ?? "",
              isCompleted: jsonItem['isCompleted'] ?? false,
            ))
        .toList();

    _todoStreamController.add(_todos);
  }

  Future<void> _saveTodos() async {
    final List<Map<String, dynamic>> todoListJson = _todos
        .map((todo) => {
              'id': todo.id,
              'dateCreated': todo.dateCreated.toIso8601String(),
              'taskName': todo.taskName,
              'isCompleted': todo.isCompleted,
            })
        .toList();

    await prefs.setString(_todoKey, json.encode(todoListJson));
  }

  void addTodo(String taskName) {
    final newTodo = Todo.create(
      taskName: taskName,
      isCompleted: false,
    );
    _todos.insert(0, newTodo);
    _sortTodosAndPublish(shouldPublishChanges: true);
  }

  void deleteTodo(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);

    if (index >= 0 && index < _todos.length) {
      _todos.removeAt(index);
      _sortTodosAndPublish(shouldPublishChanges: true);
    }
  }

  void updateTodo(Todo updatedTodo) {
    final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);

    if (index != -1) {
      _todos[index] = updatedTodo;
      _sortTodosAndPublish(shouldPublishChanges: true);
    }
  }

  Future<void> _sortTodosAndPublish({required shouldPublishChanges}) async {
    _todos.sort((a, b) {
      if (a.isCompleted && !b.isCompleted) return 1;
      if (!a.isCompleted && b.isCompleted) return -1;
      return b.dateCreated.compareTo(a.dateCreated);
    });
    if (shouldPublishChanges) _publishChanges();
  }

  void _publishChanges() {
    _saveTodos();
    _todoStreamController.add(_todos);
  }

  Future<String?> analyzeTodoList() async {
    final gemini = Gemini.instance;

    // TODO return a Gemini analysis of the todo list
    return "";
  }
}
