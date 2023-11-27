import 'package:flutter/material.dart';
import 'package:tasker/features/home/views/home_screen.dart';
import 'package:tasker/features/splash/views/splash_screen.dart';
import 'package:tasker/features/tasks/models/tasks_model.dart';
import 'package:tasker/features/tasks/views/add_update_tasks_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String homeScreen = '/homeScreen';
  static const String addUpdateTasksScreen = '/addUpdateTasksScreen';
  static const String settingsScreen = '/settingsScreen';
}

mixin GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? route = settings.name;
    final arguments = settings.arguments;

    switch (route) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
      case AppRoutes.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
          settings: settings,
        );
      case AppRoutes.addUpdateTasksScreen:
        TasksModel tasksModel = TasksModel();
        if (arguments != null) {
          tasksModel = arguments as TasksModel;
        }
        return MaterialPageRoute(
          builder: (context) => AddUpdateTasksScreen(tasksModel: tasksModel),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
          settings: settings,
        );
    }
  }
}
