import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'quiz_screen.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  final List<Map<String, dynamic>> subjects = const [
    {'title': 'Operating Systems', 'key': 'OS'},
    {'title': 'Database and Management System ', 'key': 'DBMS'},
    {'title': 'Data Structures', 'key': 'DSA'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Tests"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(subject['title']),
              trailing: ElevatedButton(
                onPressed: () {
                  Get.to(() => QuizScreen(subjectKey: subject['key']));
                },
                child: const Text("Start Test"),
              ),
            ),
          );
        },
      ),
    );
  }
}
