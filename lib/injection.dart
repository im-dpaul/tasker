import 'package:get/get.dart';
import 'package:tasker/features/tasks/controller/tasks_controller.dart';

Future<void> initCore() async {
  Get.lazyPut(() => TasksController());
}
