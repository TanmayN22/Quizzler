import 'package:flutter/material.dart';
import 'package:quizller/app/views/courses/widgets/completion_stat.dart';
import 'package:quizller/app/core/utils/constants/sizes.dart';
import 'package:quizller/app/views/widgets/navbar.dart';

// --- 1. THE NEW DATA MODEL ---
class Topic {
  final String name;
  final double progress; // Progress from 0 to 100

  Topic({required this.name, required this.progress});
}

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List<bool> isSelected = [true, false];
  final List<String> _toggleOptions = ['Core Subjects', 'Aptitude'];

  // --- 2. UPDATED DATA LISTS ---
  final List<Topic> _coreSubjectTopics = [
    Topic(name: 'Data Structures & Algorithms', progress: 6.0),
    Topic(name: 'Operating Systems', progress: 4.0),
    Topic(name: 'Database Management Systems', progress: 5.0),
    Topic(name: 'Computer Networks', progress: 4.0),
    Topic(name: 'Object-Oriented Programming', progress: 3.0),
  ];

  final List<Topic> _aptitudeTopics = [
    Topic(name: 'Quantitative Aptitude', progress: 2.0),
    Topic(name: 'Logical Reasoning', progress: 1.0),
    Topic(name: 'Verbal Ability', progress: 4.0),
    Topic(name: 'Data Interpretation', progress: 3.0),
  ];

  @override
  Widget build(BuildContext context) {
    // ... (Your build method remains the same as before)
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: Navbar(title: 'Courses'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            completionStat(context, 'Core Subjects', '22', 22.0),
            const SizedBox(height: AppSizes.p24),
            completionStat(context, 'Aptitude', '10', 10.0),
            const SizedBox(height: AppSizes.p24),
            ToggleButtons(
              isSelected: isSelected,
              renderBorder: false,
              fillColor: Colors.transparent,
              selectedColor: colorScheme.primary,
              color: Colors.grey.shade600,
              splashColor: Colors.transparent,
              children: List.generate(_toggleOptions.length, (index) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isSelected[index]
                            ? colorScheme.primary
                            : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Text(
                    _toggleOptions[index],
                    style: const TextStyle(
                      fontSize: AppSizes.fontMd,
                    ),
                  ),
                );
              }),
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = i == index;
                  }
                });
              },
            ),
            isSelected[0]
                ? TopicList(topics: _coreSubjectTopics)
                : TopicList(topics: _aptitudeTopics),
          ],
        ),
      ),
    );
  }
}

// --- 3. MODIFIED TOPICLIST WIDGET ---
class TopicList extends StatelessWidget {
  // Now accepts a list of Topic objects
  final List<Topic> topics;

  const TopicList({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: AppSizes.p16),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          // Get the full Topic object for the current item
          final topic = topics[index];
          return Card(
            margin: const EdgeInsets.only(bottom: AppSizes.p8),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.book_outlined,
                    color: colorScheme.primary,
                  ),
                  // Use topic.name for the title
                  title: Text(topic.name),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                // [NEW] Added a Padding and LinearProgressIndicator
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 12.0),
                  child: LinearProgressIndicator(
                    // Use topic.progress, remembering to divide by 100
                    value: topic.progress / 100.0,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    backgroundColor: colorScheme.primary.withOpacity(0.15),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
