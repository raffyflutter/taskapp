import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/data/local_storage_services/local_storage_methods_services.dart';
import 'package:taskapp/routes/pages.dart';

import '../servcies/respository/auth_repository.dart';

class AuthController extends GetxController {
  final repository = AuthRepositpory();
  RxBool isLoading = false.obs;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final confirmpasswordController = TextEditingController().obs;
  void signUp() {
    isLoading.value = true;
    Map data = {
      'name': nameController.value.text,
      'email': emailController.value.text,
      'password': passwordController.value.text,
      'password_confirmation': confirmpasswordController.value.text
    };
    repository.signUpApi(data).then((Value) {
      isLoading.value = false;
      Get.snackbar('Register', 'Register Successfully');
      Get.toNamed(Pages.signin);
    }).onError((error, StackTrace) {
      isLoading.value = false;
      Get.snackbar('Register', error.toString());
      print(error);
    });
  }

  void login() {
    isLoading.value = true;
    Map data = {
      'email': emailController.value.text,
      'password': passwordController.value.text,
    };
    repository.loginApi(data).then((Value) {
      isLoading.value = false;
      Get.snackbar('Login', 'Login Successfully');
      Get.toNamed(Pages.home);
    }).onError((error, StackTrace) {
      isLoading.value = false;
      Get.snackbar('Login', error.toString());
      print(error);
    });
  }

  void logout() {
    isLoading.value = true;
    final token = LocalStorageMethods.instance.getUserApiToken();
    print('LogoutTken $token');
    // if (token == null) {
    //   isLoading.value = false;
    //   Get.snackbar('Logout', 'No token found');
    //   return;
    // }
    repository.logoutApi(token).then((value) {
      isLoading.value = false;
      LocalStorageMethods.instance.clear();
      Get.snackbar('Logout', 'Logged out successfully');
      Get.toNamed(Pages.signin);
    }).onError((error, stackTrace) {
      isLoading.value = false;
      Get.snackbar('Logout', error.toString());
      print(error);
    });
  }
}
