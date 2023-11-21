import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/core/extensions/size_extension.dart';
import 'package:tasker/core/theme/app_colors.dart';
import 'package:tasker/core/theme/app_text_styles.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? elevation;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final Widget? leadingWidget;
  final double? leadingWidth;

  const CommonAppBar({
    super.key,
    this.title,
    this.elevation,
    this.backgroundColor,
    this.actions,
    this.leadingWidget,
    this.leadingWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 6.h,
              ),
              child: Text(
                title!,
                style: AppTextStyles.f24w700TextBlack,
              ),
            )
          : null,
      backgroundColor: backgroundColor ?? AppColors.white,
      elevation: elevation ?? 0,
      bottomOpacity: 0,
      leading: leadingWidget,
      leadingWidth: leadingWidth ?? 42,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
