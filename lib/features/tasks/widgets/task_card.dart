import 'package:flutter/material.dart';
import 'package:tasker/core/extensions/size_extension.dart';
import 'package:tasker/core/responsive/size_config.dart';
import 'package:tasker/core/theme/app_colors.dart';
import 'package:tasker/widgets/custom_sized_box.dart';

class TaskCard extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const TaskCard(
      {super.key,
      required this.id,
      required this.title,
      this.description,
      required this.onTap,
      required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        // width: SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.base,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title),
            const CustomSizedBox(
              height: 10,
            ),
            if (description != null) Text(description ?? ''),
          ],
        ),
      ),
    );
  }
}
