import 'package:flutter/material.dart';

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
        backgroundColor: const Color.fromARGB(255, 103, 58, 183),
      ),
    );
  }
}
