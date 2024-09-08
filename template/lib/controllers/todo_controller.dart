import 'dart:convert';
import 'dart:async';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:template/main.dart';
import 'package:template/struct/todo.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoController with ChangeNotifier {
  static const _todoKey = 'todo_list';
  List<Todo> _todos = [];

  TodoController() {
    _loadTodos();
  }

  List<Todo> get todos => _todos;

  void _loadTodos() async {
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

    notifyListeners();
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
    _sortTodosAndPublish();
  }

  void deleteTodo(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);

    if (index >= 0 && index < _todos.length) {
      _todos.removeAt(index);
      _sortTodosAndPublish();
    }
  }

  void updateTodo(Todo updatedTodo) {
    final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);

    if (index != -1) {
      _todos[index] = updatedTodo;
      _sortTodosAndPublish();
    }
  }

  Future<void> _sortTodosAndPublish() async {
    _todos.sort((a, b) {
      if (a.isCompleted && !b.isCompleted) return 1;
      if (!a.isCompleted && b.isCompleted) return -1;
      return b.dateCreated.compareTo(a.dateCreated);
    });
    _publishChanges();
  }

  void _publishChanges() {
    _saveTodos();
    notifyListeners();
  }

  Future<String?> analyzeTodoList() async {
    final gemini = Gemini.instance;

    return (await gemini.text(
            "The output you send back should not be more than 2 sentences. Give me a nice summary of my todo list. Make a joke about certain tasks and be funny. Here is the list: $_todos"))
        ?.output;
  }
}
