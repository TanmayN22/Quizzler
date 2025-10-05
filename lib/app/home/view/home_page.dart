import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizller/theme/colors.dart';
import 'package:quizller/utils/constants/sizes.dart';
import 'package:quizller/utils/helpers/responsive.dart';
import 'package:quizller/widgets/navbar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final username = FirebaseAuth.instance.currentUser?.displayName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'Quizzler'),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.p8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome, $username !",
                style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(
              height: AppSizes.p8.h,
            ),
            Container(
              width: 400,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                border: Border.all(color: AppColors.primaryVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.p8),
                    child: Text(
                      'Your Progress',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
