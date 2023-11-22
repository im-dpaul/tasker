import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/core/extensions/size_extension.dart';
import 'package:tasker/core/theme/app_colors.dart';
import 'package:tasker/core/theme/app_text_styles.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final TextStyle? titleStyle;
  final double? elevation;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final Widget? leadingWidget;
  final double? leadingWidth;
  final bool? backButton;
  final void Function()? backButtonOnTap;

  const CommonAppBar({
    super.key,
    this.title,
    this.titleStyle,
    this.elevation,
    this.backgroundColor,
    this.actions,
    this.leadingWidget,
    this.leadingWidth,
    this.backButton,
    this.backButtonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (backButton == true) ? 0 : 8.w,
                vertical: 6.h,
              ),
              child: Text(
                title!,
                style: titleStyle ?? AppTextStyles.f24w700TextBlack,
              ),
            )
          : null,
      backgroundColor: backgroundColor ?? AppColors.white,
      elevation: elevation ?? 0,
      bottomOpacity: 0,
      leading: (backButton == true)
          ? Container(
              padding: EdgeInsets.only(left: 12.w),
              child: GestureDetector(
                onTap: backButtonOnTap,
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 24,
                  color: AppColors.black,
                ),
              ),
            )
          : leadingWidget,
      leadingWidth: leadingWidth ?? ((backButton == true) ? 36 : 52),
      automaticallyImplyLeading: false,
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
