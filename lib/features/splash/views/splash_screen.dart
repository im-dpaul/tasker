import 'package:flutter/material.dart';
import 'package:tasker/core/routes/app_routes.dart';
import 'package:tasker/core/theme/app_text_styles.dart';

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
        child: Center(
          child: Text(
            'Tasker',
            style: AppTextStyles.f24w700InterTextBlack,
          ),
        ),
      ),
    );
  }
}
