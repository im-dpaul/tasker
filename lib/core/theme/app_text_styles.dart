import 'package:flutter/material.dart';
import 'package:tasker/core/extensions/size_extension.dart';
import 'package:tasker/core/theme/app_colors.dart';

class AppTextStyles {
  static TextStyle f24w700TextBlack = TextStyle(
    color: AppColors.textBlack,
    fontSize: 24.textMultiplier,
    fontFamily: 'Inter-Black',
    fontWeight: FontWeight.w700,
  );

  static TextStyle f20w600TextBlack = TextStyle(
    color: AppColors.textBlack,
    fontSize: 20.textMultiplier,
    fontFamily: 'Inter-Bold',
    fontWeight: FontWeight.w600,
  );

  static TextStyle f16w600TextBlack = TextStyle(
    color: AppColors.textBlack,
    fontSize: 16.textMultiplier,
    fontFamily: 'Inter-Bold',
    fontWeight: FontWeight.w600,
  );

  static TextStyle f14w600TextBlack = TextStyle(
    color: AppColors.textBlack,
    fontSize: 14.textMultiplier,
    fontFamily: 'Inter-Bold',
    fontWeight: FontWeight.w600,
  );

  static TextStyle f14w400TextBlack = TextStyle(
    color: AppColors.textBlack,
    fontSize: 14.textMultiplier,
    fontFamily: 'Inter-Bold',
    fontWeight: FontWeight.w400,
  );

  static TextStyle f12w400SmokyGrey = TextStyle(
    color: AppColors.smokyGrey,
    fontSize: 12.textMultiplier,
    fontFamily: 'Inter-Bold',
    fontWeight: FontWeight.w400,
  );
}
