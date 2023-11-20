import 'package:flutter/material.dart';
import 'package:tasker/core/extensions/size_extension.dart';

class CustomSizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? childWidget;

  const CustomSizedBox({
    super.key,
    this.height,
    this.width,
    this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    return (height != null && width != null)
        ? SizedBox(
            height: height!.h,
            width: width!.w,
            child: childWidget,
          )
        : (height != null)
            ? SizedBox(
                height: height!.h,
                child: childWidget,
              )
            : (width != null)
                ? SizedBox(
                    width: width!.w,
                    child: childWidget,
                  )
                : SizedBox(
                    child: childWidget,
                  );
  }
}
