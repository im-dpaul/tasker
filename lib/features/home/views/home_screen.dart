import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasker/core/extensions/size_extension.dart';
import 'package:tasker/core/routes/app_routes.dart';
import 'package:tasker/core/theme/app_colors.dart';
import 'package:tasker/core/utils/common_functions.dart';
import 'package:tasker/features/tasks/controller/tasks_controller.dart';
import 'package:tasker/features/tasks/widgets/add_tasks_text_widget.dart';
import 'package:tasker/features/tasks/widgets/task_card.dart';
import 'package:tasker/widgets/common_app_bar.dart';
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
      appBar: const CommonAppBar(
        title: 'Tasker',
      ),
      body: Obx(
        () => Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 8.w,
          ),
          child: WillPopScope(
            onWillPop: () async {
              if (tasksController.enableSelection.value) {
                tasksController.setEnableSelection(value: false);
                return false;
              } else {
                return true;
              }
            },
            child: tasksController.tasksList.isNotEmpty
                ? ListView.separated(
                    itemCount: tasksController.tasksList.length,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: 16.h,
                      right: 8.w,
                      bottom: 108.h,
                      left: 8.w,
                    ),
                    itemBuilder: (context, index) {
                      return TaskCard(
                        id: tasksController.tasksList[index].id ?? 0,
                        title: tasksController.tasksList[index].title ?? '',
                        description: tasksController.truncateDescription(
                            tasksController.tasksList[index].description),
                        status: getTaskStatus(
                            tasksController.tasksList[index].status ?? ''),
                        color: getColor(
                            tasksController.tasksList[index].status ?? ''),
                        onTap: () async {
                          tasksController.setEnableSelection(value: false);
                          final value = await Navigator.of(context).pushNamed(
                              AppRoutes.addUpdateTasksScreen,
                              arguments: tasksController.tasksList[index]);
                          if (value == true) {
                            tasksController.getTasks();
                          }
                        },
                        onLongPress: () {
                          tasksController.setEnableSelection(
                              value: true,
                              id: tasksController.tasksList[index].id);
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const CustomSizedBox(height: 16),
                  )
                : const AddTasksTextWidget(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => Container(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: tasksController.enableSelection.value,
                child: GestureDetector(
                  onTap: () {
                    tasksController.setEnableSelection(value: false);
                  },
                  child: Container(
                    height: 50.h,
                    width: 50.w,
                    margin: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.h,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.clearBlue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 28,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (tasksController.enableSelection.value) {
                    if (tasksController.selectedTasksId.isNotEmpty) {
                      tasksController.deleteMultipleTask();
                    }
                  } else {
                    final value = await Navigator.of(context)
                        .pushNamed(AppRoutes.addUpdateTasksScreen);

                    if (value == true) {
                      tasksController.getTasks();
                    }
                  }
                },
                child: Container(
                  height: 50.h,
                  width: 50.w,
                  margin: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: tasksController.enableSelection.value
                        ? AppColors.lightRed
                        : AppColors.mediumGreen,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Icon(
                    tasksController.enableSelection.value
                        ? Icons.delete_outline_outlined
                        : Icons.add,
                    size: 28,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
