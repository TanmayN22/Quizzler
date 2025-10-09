import 'package:flutter/material.dart';
import 'package:quizller/app/home/widgets/course_section.dart';
import 'package:quizller/app/home/widgets/daily_stat_container.dart';
import 'package:quizller/app/home/widgets/progress_container.dart';
import 'package:quizller/utils/constants/sizes.dart';
import 'package:quizller/widgets/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'Quizzler'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProgressContainer(),
          DailyStatContainer(),
          SizedBox(height: AppSizes.p12),
          CoursesSection()
        ],
      ),
    );
  }
}
