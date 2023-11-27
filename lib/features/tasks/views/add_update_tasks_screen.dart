import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasker/core/constants/constants.dart';
import 'package:tasker/core/extensions/size_extension.dart';
import 'package:tasker/core/responsive/size_config.dart';
import 'package:tasker/core/theme/app_colors.dart';
import 'package:tasker/core/theme/app_text_styles.dart';
import 'package:tasker/core/utils/common_functions.dart';
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
        title: (addUpdateTasksController.taskId.value == -1) ? 'Add Task' : '',
        titleStyle: AppTextStyles.f16w600TextBlack,
        backButton: true,
        backButtonOnTap: () {
          addUpdateTasksController.clearData();
          Navigator.of(context).pop<bool>(false);
        },
        actions: [
          Obx(
            () => Visibility(
              visible: (addUpdateTasksController.taskId.value != -1),
              child: Row(
                children: [
                  const CustomSizedBox(width: 10),
                  Visibility(
                    visible: addUpdateTasksController.titleController.text
                            .trim()
                            .isNotEmpty ||
                        addUpdateTasksController.descriptionController.text
                            .trim()
                            .isNotEmpty,
                    child: GestureDetector(
                      onTap: () async {
                        await addUpdateTasksController.shareTask();
                      },
                      child: const Icon(
                        Icons.share_rounded,
                        size: 24,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  const CustomSizedBox(width: 16),
                  GestureDetector(
                    onTap: () async {
                      final result =
                          await addUpdateTasksController.deleteTask();
                      if (result) {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop<bool>(true);
                      }
                    },
                    child: const Icon(
                      Icons.delete_outline_outlined,
                      size: 26,
                      color: AppColors.lightRed,
                    ),
                  ),
                  const CustomSizedBox(width: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => SafeArea(
          child: Container(
            color: AppColors.white,
            height: SizeConfig.screenHeight,
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Status:',
                                style: AppTextStyles.f12w400SmokyGrey,
                              ),
                              const CustomSizedBox(width: 8),
                              DropdownButton(
                                value: getTaskStatus(
                                    addUpdateTasksController.taskStatus.value),
                                icon: const Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  size: 18,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                underline: const SizedBox(),
                                items: Constants.taskStatus.values
                                    .map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: AppTextStyles.f12w400SmokyGrey
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                selectedItemBuilder: (context) {
                                  return Constants.taskStatus.values
                                      .map((String item) {
                                    return Center(
                                      child: Text(
                                        '$item ',
                                        style: AppTextStyles.f12w400SmokyGrey
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: getColor(
                                              addUpdateTasksController
                                                  .taskStatus.value),
                                        ),
                                      ),
                                    );
                                  }).toList();
                                },
                                onChanged: (value) {
                                  addUpdateTasksController.setTaskStatus(value);
                                },
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: addUpdateTasksController
                              .creationTimeVisibility.value,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  addUpdateTasksController.updatedAt.value == ''
                                      ? 'Created on:'
                                      : 'Updated on:',
                                  style: AppTextStyles.f12w400SmokyGrey,
                                ),
                                const CustomSizedBox(width: 8),
                                Text(
                                  addUpdateTasksController.setDateTime(),
                                  style: AppTextStyles.f12w400SmokyGrey
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const CustomSizedBox(height: 12),
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
                        const CustomSizedBox(height: 100),
                      ],
                    ),
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
      ),
    );
  }
}
