import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizller/controllers/auth/auth_controller.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1.0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      actions: [
        IconButton(
          onPressed: () => authController.logout(),
          icon: Icon(
            Icons.circle,
            size: 40,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
