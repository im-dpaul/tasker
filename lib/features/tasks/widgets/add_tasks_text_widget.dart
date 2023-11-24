import 'package:flutter/material.dart';
import 'package:tasker/core/theme/app_text_styles.dart';
import 'package:tasker/widgets/custom_sized_box.dart';

class AddTasksTextWidget extends StatelessWidget {
  const AddTasksTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomSizedBox(
        width: 250,
        childWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Efficiently organize your day!',
              style: AppTextStyles.f12w400SmokyGrey,
              textAlign: TextAlign.center,
            ),
            const CustomSizedBox(height: 8),
            Text(
              'Add tasks now for a productive and successful schedule ahead.',
              style: AppTextStyles.f12w400SmokyGrey,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
