import 'package:taskapp/data/network/baseApiServices.dart';
import 'package:taskapp/data/network/network_api_services.dart';
import 'package:taskapp/view_model.dart/model/task_model.dart';

class TaskRepository {
  bool isupdate = false;

  TaskModel? taskModel;

  final apiServices = NetworkApiServices();

  Future<TaskModel> createTaskApi(Map<String, dynamic> data) async {
    dynamic response =
        await apiServices.postRequest(BaseApiservices.createtask, data);
    return TaskModel(
      id: response['id'].toString(),
      name: response['name'] ?? '',
      value: data['value'],
    );
  }

  Future<List<TaskModel>> fetchApi() async {
    dynamic response = await apiServices.getRequest(BaseApiservices.fetchtask);
    var taskList = response['data'] as List;

    return taskList.map((task) => TaskModel.fromJson(task)).toList();
  }

  Future<Map<String, dynamic>> updateApi(
      String taskId, Map<String, dynamic> data) async {
    dynamic response =
        await apiServices.putRequest(BaseApiservices.updatetask + taskId, data);
    if (response != null) {
      isupdate = true;
    }
    return response;
  }
}
