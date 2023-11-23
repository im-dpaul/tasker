import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasker/core/constants/constants.dart';
import 'package:tasker/core/services/db_provider.dart';
import 'package:tasker/core/utils/common_functions.dart';
import 'package:tasker/features/tasks/models/tasks_model.dart';

class AddUpdateTasksController extends GetxController {
  DBProvider dbProvider = DBProvider();
  RxInt taskId = RxInt(-1);
  RxString taskStatus = RxString('NOT_STARTED');
  RxBool validated = RxBool(false);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  setInitialData(TasksModel? tasksModel) {
    if (tasksModel != null) {
      if (tasksModel.id != null) {
        taskId.value = tasksModel.id ?? 0;
      }
      if (tasksModel.title != null) {
        titleController.text = tasksModel.title ?? '';
      }
      if (tasksModel.description != null) {
        descriptionController.text = tasksModel.description ?? '';
      }
      if (tasksModel.status != null) {
        taskStatus.value = tasksModel.status ?? '';
      }
    }
  }

  setTaskStatus(String? value) {
    if (value != null) {
      String key =
          getKeyFromValue(Constants.taskStatus, value) ?? "NOT_STARTED";
      if (key != taskStatus.value) {
        taskStatus.value = key;
        checkValidation();
      }
    }
  }

  clearData() {
    titleController.clear();
    descriptionController.clear();
    taskId.value = -1;
    taskStatus.value = 'NOT_STARTED';
    validated.value = false;
  }

  checkValidation() {
    if (titleController.text.isNotEmpty) {
      validated.value = true;
    } else {
      validated.value = false;
    }
  }

  Future<bool> addTask() async {
    try {
      await dbProvider.insert(
        TasksModel(
          title: titleController.text,
          description: descriptionController.text,
          status: taskStatus.value,
        ),
      );
      clearData();
      return true;
    } catch (e) {
      log('Error in addTask -> $e', name: 'Error');
      return false;
    }
  }

  Future<bool> updateTask() async {
    try {
      await dbProvider.update(
        TasksModel(
          id: taskId.value,
          title: titleController.text,
          description: descriptionController.text,
          status: taskStatus.value,
        ),
      );
      clearData();
      return true;
    } catch (e) {
      log('Error in updateTask -> $e', name: 'Error');
      return false;
    }
  }

  Future<bool> deleteTask() async {
    try {
      await dbProvider.delete(taskId.value);
      clearData();
      return true;
    } catch (e) {
      log('Error in deleteTask -> $e', name: 'Error');
      return false;
    }
  }
}
