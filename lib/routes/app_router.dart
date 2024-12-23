import 'package:flutter/material.dart';
import 'package:taskapp/view_model.dart/model/task_model.dart';
import 'package:taskapp/view/new_task_screen.dart';
import 'package:taskapp/view/splash_screen.dart';
import 'package:taskapp/view/update_task_screen.dart';

import '../page_not_found.dart';
import '../view/sign_in.dart';
import '../view/sign_up.dart';
import '../view/tasks_screen.dart';
import 'pages.dart';

Route onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Pages.initial:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case Pages.signin:
      return MaterialPageRoute(
        builder: (context) => SignInScreen(),
      );
    case Pages.signup:
      return MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      );
    case Pages.home:
      return MaterialPageRoute(
        builder: (context) => const TasksScreen(),
      );
    case Pages.createNewTask:
      return MaterialPageRoute(
        builder: (context) => const NewTaskScreen(),
      );
    case Pages.updateTask:
      final args = routeSettings.arguments as TaskModel;
      return MaterialPageRoute(
        builder: (context) => UpdateTaskScreen(taskModel: args),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const PageNotFound(),
      );
  }
}
