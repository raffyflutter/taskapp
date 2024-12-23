import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:taskapp/view_model.dart/model/task_model.dart';

class TaskStorageService {
  static const String _tasksKey = "tasks_list";

  // Save tasks list to SharedPreferences
  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskListJson =
        tasks.map((task) => task.toJson()).toList(); // Convert tasks to JSON
    prefs.setString(_tasksKey, json.encode(taskListJson));
  }

  Future<List<TaskModel>> retrieveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskListString = prefs.getString(_tasksKey);

    if (taskListString != null) {
      final List<dynamic> taskListJson = json.decode(taskListString);
      return taskListJson.map((task) => TaskModel.fromJson(task)).toList();
    }
    return [];
  }

  // Clear all tasks from SharedPreferences
  Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_tasksKey);
  }
}
