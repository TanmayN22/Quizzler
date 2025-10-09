import 'package:flutter/material.dart';
import 'package:quizller/utils/constants/sizes.dart';

class CoursesSection extends StatelessWidget {
  const CoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final List<String> items =
        List<String>.generate(10, (i) => 'Item ${i + 1}');
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Courses',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: AppSizes.p8),
          Text(
            'Tech Core Subjects',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(
            height: AppSizes.p12,
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSizes.p4),
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusLg),
                          border:
                              Border.all(color: colorScheme.primaryContainer)),
                    ),
                  );
                }),
          ),
          SizedBox(height: AppSizes.p16),
          Padding(
            padding: const EdgeInsets.only(left: AppSizes.p12),
            child: Text(
              'Aptitude',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(
            height: AppSizes.p12,
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.p4),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                        border:
                            Border.all(color: colorScheme.primaryContainer)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
