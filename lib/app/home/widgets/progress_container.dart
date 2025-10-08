import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizller/utils/constants/sizes.dart';
import 'package:quizller/utils/helpers/responsive.dart';

class ProgressContainer extends StatelessWidget {
  ProgressContainer({super.key});
  final username = FirebaseAuth.instance.currentUser?.displayName;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(AppSizes.p8.w),
      child: Container(
        width: Get.width,
        height: 120,
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          border: Border.all(color: colorScheme.primary.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: AppSizes.p8.h, left: AppSizes.p8.w),
              child: Text("Welcome, $username !",
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            SizedBox(height: AppSizes.p8.h),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    EdgeInsets.only(left: AppSizes.p8.w, right: AppSizes.p8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Overall Progress',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      '33%',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.p8.w),
              child: LinearProgressIndicator(
                value: 0.33,
                minHeight: 10,
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                backgroundColor: colorScheme.primary.withOpacity(0.15),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    EdgeInsets.only(left: AppSizes.p12.w, right: AppSizes.p8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Not Ready!',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    // Text(
                    //   '33%',
                    //   style: Theme.of(context).textTheme.bodyLarge,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
