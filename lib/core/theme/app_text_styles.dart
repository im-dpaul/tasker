import 'package:flutter/material.dart';
import 'package:tasker/core/extensions/size_extension.dart';
import 'package:tasker/core/theme/app_colors.dart';

class AppTextStyles {
  static TextStyle f24w700InterTextBlack = TextStyle(
    color: AppColors.textBlack,
    fontSize: 24.textMultiplier,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
  );

  static TextStyle f16w500InterNeutral06 = TextStyle(
    color: AppColors.neutral06,
    fontSize: 16.textMultiplier,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
  );
}
