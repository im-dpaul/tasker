import 'package:get/get.dart';
import 'package:tasker/features/tasks/controller/add_update_tasks_controller.dart';
import 'package:tasker/features/tasks/controller/tasks_controller.dart';

Future<void> initCore() async {
  Get.lazyPut(() => TasksController());
  Get.lazyPut(() => AddUpdateTasksController());
}
