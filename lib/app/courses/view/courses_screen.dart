import 'package:flutter/material.dart';
import 'package:quizller/app/courses/widgets/completion_stat.dart';
import 'package:quizller/utils/constants/sizes.dart';
import 'package:quizller/widgets/navbar.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'Courses'),
      body: Padding(
        padding: const EdgeInsets.only(left: AppSizes.p12, right: AppSizes.p12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            completionStat(context, 'Core Subjects', '22', 22.0),
            SizedBox(height: AppSizes.p8),
            completionStat(context, 'Aptitude', '10', 10.0),
          ],
        ),
      ),
    );
  }
}
