import 'package:flutter/material.dart';
import 'package:tasker/core/extensions/size_extension.dart';
import 'package:tasker/core/responsive/size_config.dart';
import 'package:tasker/core/theme/app_colors.dart';
import 'package:tasker/core/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String title;
  final bool? enabled;
  final double? height;
  final double? width;
  final void Function()? onTap;

  const AppButton({
    super.key,
    required this.title,
    this.enabled,
    this.height,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 42.h,
        width: width ?? SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 16.w,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 16.w,
        ),
        decoration: BoxDecoration(
          color:
              (enabled == false) ? AppColors.lightGrey : AppColors.mediumGreen,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            title,
            style:
                AppTextStyles.f14w400TextBlack.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
