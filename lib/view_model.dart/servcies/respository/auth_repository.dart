import 'package:get/get.dart';
import 'package:taskapp/data/network/baseApiServices.dart';
import 'package:taskapp/data/network/network_api_services.dart';
import 'package:taskapp/routes/pages.dart';

import '../../../data/local_storage_services/local_storage_methods_services.dart';
import '../../model/task_model.dart';

class AuthRepositpory {
  late TaskModel taskModel;
  final apiServices = NetworkApiServices();
  Future<dynamic> signUpApi(var data) async {
    dynamic response =
        await apiServices.postRequest(BaseApiservices.signup, data);
    print('Response SIGNUP:$response');
    return response;
  }

  Future<dynamic> loginApi(var data) async {
    dynamic response =
        await apiServices.postRequest(BaseApiservices.login, data);
    print('Response LOGIN:$response');

    await LocalStorageMethods.instance
        .writeUserApiToken((response["access_token"]));
    final token = LocalStorageMethods.instance.getUserApiToken();
    print('locaal siguptoken:$token');

    await LocalStorageMethods.instance.writeUsername(response["user"]["name"]);
    return response;
  }

  Future<dynamic> logoutApi(String? token) async {
    if (token == null) {
      throw Exception("Token is null");
    }

    dynamic response =
        await apiServices.postRequest(BaseApiservices.logout, token);

    await LocalStorageMethods.instance.clear();
    Get.offAllNamed(Pages.signin);
    return response;
  }
}
