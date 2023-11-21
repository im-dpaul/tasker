import 'package:flutter/material.dart';
import 'package:tasker/core/constants/image_path.dart';
import 'package:tasker/core/routes/app_routes.dart';
import 'package:tasker/core/theme/app_colors.dart';
import 'package:tasker/core/theme/app_text_styles.dart';
import 'package:tasker/widgets/custom_sized_box.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5)).then((value) => navigate());
  }

  Future<void> navigate() async {
    Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.white,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSizedBox(
                  height: 80,
                  width: 60,
                  childWidget: Image.asset(ImagePath.taskerLogo),
                ),
                const CustomSizedBox(width: 8),
                Text(
                  'Tasker',
                  style: AppTextStyles.f24w700TextBlack,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
