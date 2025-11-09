import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
      leading:
          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
      title: Text(
        'Profile',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
            ),
      ),
    ));
  }
}
