import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/Models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;
  TaskProvider() {
    loadTasks();
  }
  void addtask(Task task) {
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    saveTasks();
    notifyListeners();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> taskJsonList =
        _tasks.map((task) => jsonEncode(task.tojson())).toList();
    prefs.setStringList('tasks', taskJsonList);
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? taskJsonList = prefs.getStringList('tasks');

    if (taskJsonList != null) {
      _tasks =
          taskJsonList
              .map((taskJson) => Task.fromJson(jsonDecode(taskJson)))
              .toList();
      notifyListeners();
    }
  }
}
