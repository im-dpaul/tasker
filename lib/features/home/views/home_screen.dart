import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasker/core/extensions/size_extension.dart';
import 'package:tasker/core/services/db_provider.dart';
import 'package:tasker/core/theme/app_colors.dart';
import 'package:tasker/features/tasks/controller/tasks_controller.dart';
import 'package:tasker/features/tasks/models/tasks_model.dart';
import 'package:tasker/features/tasks/views/tasks_screen.dart';
import 'package:tasker/features/tasks/widgets/task_card.dart';
import 'package:tasker/widgets/custom_sized_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tasksController = Get.find<TasksController>();

  @override
  void initState() {
    super.initState();
    tasksController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasker'),
      ),
      body: Obx(
        () => CustomSizedBox(
          // height: 700,
          childWidget: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w,
            ),
            child: ListView.separated(
              itemCount: tasksController.tasksList.length,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              itemBuilder: (context, index) {
                return TaskCard(
                  id: tasksController.tasksList[index].id ?? 0,
                  title: tasksController.tasksList[index].title ?? '',
                  description: tasksController.tasksList[index].description,
                  onTap: () {
                    tasksController
                        .updateTask(tasksController.tasksList[index].id ?? 0);
                  },
                  onLongPress: () {
                    tasksController
                        .deleteTask(tasksController.tasksList[index].id ?? 0);
                  },
                );
              },
              separatorBuilder: (context, index) =>
                  const CustomSizedBox(height: 12),
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          tasksController.addTask();
        },
        child: Container(
          height: 56.h,
          width: 56.w,
          margin: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          decoration: const BoxDecoration(
            color: AppColors.accent03,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: const Icon(
            Icons.add,
            size: 30,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
