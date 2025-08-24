// lib/views/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizller/controllers/auth_controller.dart';
import 'package:quizller/views/courses_screen.dart'; // Import the courses screen
import 'package:quizller/views/test_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Quizzler'),
        actions: [
          IconButton(
            onPressed: () => authController.logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final displayName = authController.user?.displayName ?? 'User';
              return Text(
                "👋 Welcome back, $displayName!",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              );
            }),
            const SizedBox(height: 4),
            const Text(
              'Continue your personalized learning journey',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.deepPurpleAccent.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📊 Your Progress',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Wrap(
                    alignment: WrapAlignment.spaceAround,
                    spacing: 30,
                    runSpacing: 16,
                    children: [
                      _ProgressCircle(label: 'OS', value: 0.75),
                      _ProgressCircle(label: 'DBMS', value: 0.50),
                      _ProgressCircle(label: 'DSA', value: 0.90),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- Motivational Quote ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '"The beautiful thing about learning is that no one can take it away from you." – B.B. King',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
            ),

            const SizedBox(height: 30),

            // --- Recommended Tests ---
            const Text(
              'Start a New Test',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Expanded(
                  child: _SubjectCard(
                    title: 'Operating Systems',
                    topics: ['Scheduling', 'Memory Mgmt'],
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _SubjectCard(
                    title: 'DBMS',
                    topics: ['SQL', 'Normalization'],
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Expanded(
                  child: _SubjectCard(
                    title: 'Data Structures',
                    topics: ['Arrays', 'Trees'],
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(child: SizedBox()), // Spacer
              ],
            ),

            const SizedBox(height: 30),

            // --- Recent Activity ---
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _ActivityTile(
              title: 'Completed OS Quiz',
              subtitle: 'Apr 10, 2025 • Score: 92%',
              icon: Icons.check_circle,
              iconColor: Colors.deepPurple,
              onTap: () {
                // TODO: Navigate to the specific result screen
              },
            ),
            _ActivityTile(
              title: 'Started DBMS Course',
              subtitle: 'Apr 9, 2025 • Progress: 40%',
              icon: Icons.play_circle_fill,
              iconColor: Colors.orange,
              onTap: () {
                // **Navigate to the Courses screen on tap**
                Get.to(() => const CoursesScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 📌 Refactored private widget for Progress Circle
class _ProgressCircle extends StatelessWidget {
  final String label;
  final double value;
  const _ProgressCircle({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 50,
          width: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: value,
                color: Colors.deepPurple,
                backgroundColor: Colors.grey[300],
                strokeWidth: 6,
              ),
              Text('${(value * 100).round()}%'),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

// 📌 Refactored private widget for Recent Activity Tile
class _ActivityTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _ActivityTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 📌 Refactored private widget for Subject Card
class _SubjectCard extends StatelessWidget {
  final String title;
  final List<String> topics;
  final Color color;

  const _SubjectCard({
    required this.title,
    required this.topics,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Get.to(() => const TestPage());
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              for (var topic in topics)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text('• $topic',
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
