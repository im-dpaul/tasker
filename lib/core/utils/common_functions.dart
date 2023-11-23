import 'package:flutter/material.dart';
import 'package:tasker/core/constants/constants.dart';
import 'package:tasker/core/theme/app_colors.dart';

String getTaskStatus(String sts) {
  String status = Constants.taskStatus[sts] ?? 'Not Started';
  return status;
}

Color getColor(String sts) {
  String status = getTaskStatus(sts);

  if (status == Constants.taskStatus['IN_PROGRESS']) {
    return AppColors.tronBlue;
  } else if (status == Constants.taskStatus['ON_HOLD']) {
    return AppColors.smokyGrey;
  } else if (status == Constants.taskStatus['PENDING']) {
    return AppColors.tangerin;
  } else if (status == Constants.taskStatus['FINISHED']) {
    return AppColors.babyGreen;
  } else if (status == Constants.taskStatus['NOT_STARTED']) {
    return AppColors.brightLavender;
  } else {
    return AppColors.clearBlue;
  }
}

String? getKeyFromValue(Map<String, String> map, String targetValue) {
  for (var entry in map.entries) {
    if (entry.value == targetValue) {
      return entry.key;
    }
  }
  return null; // Return null if the value is not found
}
