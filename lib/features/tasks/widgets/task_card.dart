import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasker/core/constants/image_path.dart';
import 'package:tasker/core/extensions/size_extension.dart';
import 'package:tasker/core/responsive/size_config.dart';
import 'package:tasker/core/theme/app_colors.dart';
import 'package:tasker/core/theme/app_text_styles.dart';
import 'package:tasker/features/tasks/controller/tasks_controller.dart';
import 'package:tasker/widgets/custom_sized_box.dart';

class TaskCard extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final String status;
  final Color color;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const TaskCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.color,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final tasksController = Get.find<TasksController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: Container(
          // width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(12),
            border: tasksController.enableSelection.value
                ? Border.all(color: AppColors.lightGrey, width: 2)
                : const Border(),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                spreadRadius: 4,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: SizeConfig.screenWidth -
                  (tasksController.enableSelection.value ? 44.w : 40.w),
              decoration: const BoxDecoration(
                color: AppColors.snowDrift,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Container(
                // width: SizeConfig.screenWidth - 48,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomSizedBox(
                      height: 16,
                      childWidget: Row(
                        children: [
                          Container(
                            height: 6.h,
                            width: 6.w,
                            decoration: BoxDecoration(
                              color: widget.color,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const CustomSizedBox(width: 6),
                          Text(
                            widget.status,
                            style: AppTextStyles.f12w400SmokyGrey
                                .copyWith(color: AppColors.tuna, fontSize: 10),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              tasksController.addToSelectedList(widget.id);
                            },
                            child: Visibility(
                              visible: tasksController.enableSelection.value,
                              child: tasksController.checkSelection(widget.id)
                                  ? CustomSizedBox(
                                      height: 16,
                                      width: 16,
                                      childWidget:
                                          SvgPicture.asset(ImagePath.checkBox),
                                    )
                                  : Container(
                                      height: 16.h,
                                      width: 16.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: AppColors.lightGrey),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CustomSizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.title,
                      style: AppTextStyles.f14w600TextBlack,
                    ),
                    if (widget.description.isNotEmpty)
                      const CustomSizedBox(
                        height: 10,
                      ),
                    if (widget.description.isNotEmpty)
                      Text(
                        widget.description,
                        style: AppTextStyles.f12w400SmokyGrey,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
