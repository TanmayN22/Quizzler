import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizller/routes/app_pages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // delayed navigation
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(Routes.AUTHPAGE);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.asset(
                'assets/app_icon.png',
                height: 200,
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
