import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizller/app/home/widgets/progress_container.dart';
import 'package:quizller/utils/constants/sizes.dart';
import 'package:quizller/utils/helpers/responsive.dart';
import 'package:quizller/widgets/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: Navbar(title: 'Quizzler'),
      body: Column(
        children: [
          ProgressContainer(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: AppSizes.p16, right: AppSizes.p16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        )),
                    Text(
                      'Today',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: AppSizes.p8.w, right: AppSizes.p8.w),
                child: Container(
                  width: Get.width,
                  height: 120,
                  decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      border: Border.all(
                          color: colorScheme.primary.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        statBox(context, 'Tests', '3'),
                        statBox(context, 'Lectures', '12'),
                        statBox(context, 'Score', '72%')
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget statBox(BuildContext context, String title, String value) {
  final colorScheme = Theme.of(context).colorScheme;

  return Container(
    width: 110,
    height: 100,
    decoration: BoxDecoration(
        color: colorScheme.secondary,
        border: Border.all(color: colorScheme.primary),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
    child: Column(
      children: [
        SizedBox(
          height: 4,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Theme.of(context).colorScheme.primaryContainer),
        )
      ],
    ),
  );
}
