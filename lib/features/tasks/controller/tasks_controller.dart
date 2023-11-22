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
  RxList<int> selectedTasksId = RxList([]);

  getTasks() async {
    tasksList.value = await dbProvider.getTasks();
    tasksList.value = tasksList.reversed.toList();
  }

  deleteTask(int id) async {
    await dbProvider.delete(id);
    enableSelection.value = false;
    await getTasks();
  }

  deleteMultipleTask() async {
    await dbProvider.deleteMany(selectedTasksId);
    enableSelection.value = false;
    await getTasks();
  }

  setEnableSelection({required bool value, int? id}) {
    enableSelection.value = value;
    if (value) {
      if (id != null) {
        selectedTasksId.add(id);
      }
    } else {
      selectedTasksId.clear();
    }
  }

  addToSelectedList(int id) {
    if (selectedTasksId.contains(id)) {
      selectedTasksId.remove(id);
    } else {
      selectedTasksId.add(id);
    }
  }

  bool checkSelection(int id) {
    if (selectedTasksId.contains(id)) {
      return true;
    }
    return false;
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
