import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/isar_provider.dart';
import 'package:flutter_application_1/models/todos/todo.dart';
import 'package:isar/isar.dart';

class TodoDatabase extends ChangeNotifier {
  static Isar get isar => IsarProvider.isar;

  // List of notes
  final List<Todo> currTodos = [];

  // Create
  Future<void> createTodo(String textFromUser) async {
    final newTodo = Todo()..text = textFromUser;
    await isar.writeTxn(() => isar.todos.put(newTodo));
    await readTodos();
  }

  // Read
  Future<void> readTodos() async {
    List<Todo> fetchedTodo = await isar.todos.where().findAll();
    currTodos.clear();
    currTodos.addAll(fetchedTodo);
    notifyListeners();
  }

  // Update
  Future<void> updateTodo(int id, String newText) async {
    final existingTodo = await isar.todos.get(id);
    if (existingTodo != null) {
      existingTodo.text = newText;
      await isar.writeTxn(() => isar.todos.put(existingTodo));
      await readTodos();
    }
  }

  // Delete
  Future<void> deleteTodo(int id) async {
    await isar.writeTxn(() => isar.todos.delete(id));
    await readTodos();
  }

  // Complete
  Future<void> completeTodo(int id) async {
    final existingTodo = await isar.todos.get(id);
    if (existingTodo != null) {
      existingTodo.completed = true;
      await isar.writeTxn(() => isar.todos.put(existingTodo));
      await readTodos();
    }
  }
}
