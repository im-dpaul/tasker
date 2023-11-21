import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasker/core/constants/constants.dart';
import 'package:tasker/core/services/db_provider.dart';
import 'package:tasker/core/theme/app_colors.dart';
import 'package:tasker/features/tasks/models/tasks_model.dart';

class TasksController extends GetxController {
  DBProvider dbProvider = DBProvider();
  RxBool enableSelection = RxBool(false);
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
          status: 'IN_PROGRESS'),
    );
    await getTasks();
  }

  updateTask(int id) async {
    await dbProvider.update(
      TasksModel(
          id: id,
          title: "Updated Title",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
          status: 'FINISHED'),
    );
    await getTasks();
  }

  deleteTask(int id) async {
    await dbProvider.delete(id);
    await getTasks();
  }

  setEnableSelection(bool value) {
    enableSelection.value = value;
  }

  String getTaskStatus(String sts) {
    String status = Constants.taskStatus[sts] ?? 'Not Started';
    return status;
  }

  Color getColor(String sts) {
    final status = getTaskStatus(sts);

    if (status == Constants.taskStatus['IN_PROGRESS']) {
      return AppColors.tronBlue;
    } else if (status == Constants.taskStatus['ON_HOLD']) {
      return AppColors.smokyGrey;
    } else if (status == Constants.taskStatus['PENDING']) {
      return AppColors.tangerin;
    } else if (status == Constants.taskStatus['FINISHED']) {
      return AppColors.babyGreen;
    } else if (status == Constants.taskStatus['NOT_STARTED']) {
      return AppColors.brightLavender;
    } else {
      return AppColors.clearBlue;
    }
  }

  String truncateDescription(String? description) {
    if (description == null || description.isEmpty) {
      return '';
    }

    List<String> words = description.split(' ');
    if (words.length <= 25) {
      return description;
    }

    return '${words.take(25).join(' ')}...';
  }
}
