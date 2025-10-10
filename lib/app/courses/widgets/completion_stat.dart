import 'package:flutter/material.dart';
import 'package:quizller/utils/constants/sizes.dart';

Widget completionStat(
    BuildContext context, String subject, String value, double val) {
  final colorScheme = Theme.of(context).colorScheme;
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subject,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            '$value%',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
      SizedBox(
        height: AppSizes.p8,
      ),
      LinearProgressIndicator(
        value: val / 100,
        minHeight: 10,
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        backgroundColor: colorScheme.primary.withOpacity(0.15),
      ),
    ],
  );
}