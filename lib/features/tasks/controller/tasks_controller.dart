import 'package:get/get.dart';
import 'package:tasker/core/services/db_provider.dart';
import 'package:tasker/features/tasks/models/tasks_model.dart';

class TasksController extends GetxController {
  DBProvider dbProvider = DBProvider();
  RxList<TasksModel> tasksList = <TasksModel>[].obs;

  getTasks() async {
    tasksList.value = await dbProvider.getTasks();
    tasksList.value = tasksList.reversed.toList();
  }

  addTask() async {
    await dbProvider.insert(
      TasksModel(
        title: 'Lorem',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      ),
    );
    await getTasks();
  }

  updateTask(int id) async {
    await dbProvider.update(
      TasksModel(
        id: id,
        title: "Updated Title",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      ),
    );
    await getTasks();
  }

  deleteTask(int id) async {
    await dbProvider.delete(id);
    await getTasks();
  }
}
