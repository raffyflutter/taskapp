import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/view_model.dart/model/task_model.dart';
import 'package:taskapp/routes/pages.dart';
import 'package:taskapp/view_model.dart/servcies/respository/task_repository.dart';

class TaskController extends GetxController {
  var taskRepository = TaskRepository();
  var tasks = <TaskModel>[].obs;
  TaskModel? taskModel;

  final valueController = TextEditingController().obs;

  void createTask() {
    String value = valueController.value.text;

    Map<String, dynamic> data = {
      'name': 'Task ',
      'value': value,
    };

    taskRepository.createTaskApi(data).then((newTask) {
      tasks.add(newTask); // Add the newly created task to the list
      fetchData();

      Get.snackbar('Task', 'Task Created Successfully');
      Get.toNamed(Pages.home);
    }).onError((error, stackTrace) {
      Get.snackbar('Task Create', error.toString());
    });
  }

  void fetchData() {
    taskRepository.fetchApi().then((fetchedTasks) {
      tasks.assignAll(fetchedTasks);
      print('All previous task are loaded');
    }).onError((error, StackTrace) {
      Get.snackbar('Task Load', error.toString());
      print(error);
    });
  }

  Future<void> updateTaskApi(
      String taskId, String newDescription, String status) async {
    try {
      Map<String, dynamic> data = {
        'value': newDescription,
        'status': status,
      };
      taskRepository.updateApi(taskId, data).then((updateTasks) {
        fetchData();
        Get.snackbar('Task Update', 'Updated Succefully');
      }).onError((error, StackTrace) {
        Get.snackbar('Task Update', error.toString());
        print('Update Task : $error');
      });
    } catch (error) {
      Get.snackbar('Task Update', 'Failed to update task: $error');
    }
  }
}
