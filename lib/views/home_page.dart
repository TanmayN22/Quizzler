import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizller/controllers/auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildProgress(String label, double value) {
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
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              );
            }),
            const SizedBox(height: 4),
            const Text(
              'Continue your personalized learning journey',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // 📊 Progress Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent.withOpacity(0.2)),
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
                  Wrap(
                    alignment: WrapAlignment.spaceAround,
                    spacing: 30,
                    runSpacing: 16,
                    children: [
                      buildProgress('OS', 0.75),
                      buildProgress('DBMS', 0.50),
                      buildProgress('DSA', 0.90),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 📢 Motivation
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

            // 🧠 Recommended Tests
            const Text(
              'Start a New Test',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: buildSubjectCard('Operating Systems', ['Scheduling', 'Memory Mgmt'], Colors.redAccent)),
                const SizedBox(width: 10),
                Expanded(child: buildSubjectCard('DBMS', ['SQL', 'Normalization'], Colors.blueAccent)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: buildSubjectCard('Data Structures', ['Arrays', 'Trees'], Colors.green)),
                const SizedBox(width: 10),
                const Expanded(child: SizedBox()), // Spacer
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildActivityTile('Completed OS Quiz', 'Apr 10, 2025 • Score: 92%', Icons.check_circle, Colors.deepPurple),
            buildActivityTile('Started DBMS Course', 'Apr 9, 2025 • Progress: 40%', Icons.play_circle_fill, Colors.orange),
          ],
        ),
      ),
    );
  }

  // 📌 Recent Activity Tile
  Widget buildActivityTile(String title, String subtitle, IconData icon, Color iconColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }

  // 📌 Subject Card
  Widget buildSubjectCard(String title, List<String> topics, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          for (var topic in topics) Text('• $topic', style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
