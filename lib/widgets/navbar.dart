import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizller/controllers/auth/auth_controller.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colorScheme.surface,
      elevation: 1.0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
            ),
      ),
      actions: [
        IconButton(
          onPressed: () => authController.logout(),
          icon: Icon(
            Icons.circle,
            size: 40,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
