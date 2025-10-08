import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizller/app/profile/view/profile_screen.dart';
// import 'package:quizller/controllers/auth/auth_controller.dart';
// import 'package:quizller/controllers/theme/theme_controller.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // final authController = Get.find<AuthController>();
    final colorScheme = Theme.of(context).colorScheme;
    // final themeController = Get.find<ThemeController>();

    return AppBar(
      elevation: 1.0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
            ),
      ),
      actions: [
        IconButton(
          onPressed: () =>
              // authController.logout(),
              // themeController.toggleTheme(),
              Get.to(ProfileScreen()),
          icon: Icon(
            Icons.person,
            // themeController.isDarkMode.value
            // ? Icons.light_mode
            //     : Icons.nights_stay,
            size: 25,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
