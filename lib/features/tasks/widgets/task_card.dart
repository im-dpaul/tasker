import 'package:flutter/material.dart';
import 'package:tasker/core/extensions/size_extension.dart';
import 'package:tasker/core/responsive/size_config.dart';
import 'package:tasker/core/theme/app_colors.dart';
import 'package:tasker/core/theme/app_text_styles.dart';
import 'package:tasker/widgets/custom_sized_box.dart';

class TaskCard extends StatefulWidget {
  final int id;
  final String title;
  final String? description;
  final String status;
  final bool selected;
  final bool selectionEnabled;
  final Color color;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const TaskCard({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.selected,
    required this.selectionEnabled,
    required this.status,
    required this.color,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Container(
        // width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(12),
          border: widget.selectionEnabled
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
                (widget.selectionEnabled ? 48.w : 44.w),
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
                  Row(
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
                    ],
                  ),
                  const CustomSizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.title,
                    style: AppTextStyles.f14w600TextBlack,
                  ),
                  const CustomSizedBox(
                    height: 10,
                  ),
                  if (widget.description != null)
                    Text(
                      widget.description ?? '',
                      style: AppTextStyles.f12w400SmokyGrey,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
