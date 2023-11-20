import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasker/core/responsive/size_config.dart';
import 'package:tasker/core/routes/app_routes.dart';
import 'package:tasker/injection.dart';

void main() {
  initCore();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                SizeConfig().init(constraints, orientation);
                return GetMaterialApp(
                  theme: ThemeData(fontFamily: 'Inter'),
                  onGenerateRoute: GenerateRoute.generateRoute,
                  initialRoute: '/',
                  title: 'Tasker',
                  debugShowCheckedModeBanner: false,
                );
              },
            );
          },
        );
      },
    );
  }
}
