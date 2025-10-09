import 'package:flutter/material.dart';
import 'package:quizller/utils/constants/sizes.dart';

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
