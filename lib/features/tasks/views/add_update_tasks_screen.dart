import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasker/core/extensions/size_extension.dart';
import 'package:tasker/core/responsive/size_config.dart';
import 'package:tasker/core/theme/app_colors.dart';
import 'package:tasker/core/theme/app_text_styles.dart';
import 'package:tasker/features/tasks/controller/add_update_tasks_controller.dart';
import 'package:tasker/features/tasks/models/tasks_model.dart';
import 'package:tasker/widgets/app_button.dart';
import 'package:tasker/widgets/app_textfield.dart';
import 'package:tasker/widgets/common_app_bar.dart';
import 'package:tasker/widgets/custom_sized_box.dart';

class AddUpdateTasksScreen extends StatefulWidget {
  final TasksModel? tasksModel;
  const AddUpdateTasksScreen({super.key, this.tasksModel});

  @override
  State<AddUpdateTasksScreen> createState() => _AddUpdateTasksScreenState();
}

class _AddUpdateTasksScreenState extends State<AddUpdateTasksScreen> {
  final addUpdateTasksController = Get.find<AddUpdateTasksController>();

  @override
  void initState() {
    super.initState();
    addUpdateTasksController.setInitialData(widget.tasksModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: (addUpdateTasksController.taskId.value == -1)
            ? 'Add Task'
            : 'Update Task',
        titleStyle: AppTextStyles.f16w600TextBlack,
        backButton: true,
        backButtonOnTap: () {
          addUpdateTasksController.clearTextController();
          Navigator.of(context).pop<bool>(false);
        },
      ),
      body: Obx(
        () => Container(
          color: AppColors.white,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 8.h,
                ),
                child: Column(
                  children: [
                    AppTextField(
                      controller: addUpdateTasksController.titleController,
                      style: AppTextStyles.f16w600TextBlack,
                      hintText: 'Title',
                      hintStyle: AppTextStyles.f16w600TextBlack
                          .copyWith(color: AppColors.lightGrey2),
                      maxLines: null,
                      maxLength: 75,
                      errorText: null,
                      onChanged: (title) {
                        addUpdateTasksController.checkValidation();
                      },
                    ),
                    const CustomSizedBox(height: 2),
                    AppTextField(
                      controller:
                          addUpdateTasksController.descriptionController,
                      style: AppTextStyles.f14w600TextBlack
                          .copyWith(color: AppColors.smokyGrey),
                      hintText: 'Description',
                      hintStyle: AppTextStyles.f14w600TextBlack
                          .copyWith(color: AppColors.lightGrey2),
                      maxLines: null,
                      // maxLength: 300,
                      errorText: null,
                      onChanged: (description) {
                        addUpdateTasksController.checkValidation();
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  // height: 60.h,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.1),
                        spreadRadius: 4,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Center(
                    child: AppButton(
                      title: (addUpdateTasksController.taskId.value == -1)
                          ? 'Save'
                          : 'Update',
                      enabled: addUpdateTasksController.validated.value,
                      onTap: () async {
                        if (addUpdateTasksController.validated.value) {
                          bool result = false;

                          if (addUpdateTasksController.taskId.value == -1) {
                            result = await addUpdateTasksController.addTask();
                          } else {
                            result =
                                await addUpdateTasksController.updateTask();
                          }

                          if (result) {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop<bool>(true);
                          }
                        }
                      },
                    ),
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
