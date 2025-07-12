import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'analytics_page.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final String subjectKey;

  const ResultScreen({super.key, required this.score, required this.total, required this.subjectKey});

  // Get the performance message based on score percentage
  String get performanceMessage {
    final percentage = (score / total) * 100;
    
    if (percentage >= 90) return 'Excellent! You mastered this subject!';
    if (percentage >= 75) return 'Great job! You know this topic well!';
    if (percentage >= 60) return 'Good work! You have a solid understanding.';
    if (percentage >= 40) return 'Nice try! Keep practicing to improve.';
    return 'Keep going! More practice will help you master this.';
  }

  // Get color based on score percentage  
  Color get scoreColor {
    final percentage = (score / total) * 100;
    
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.blue;
    if (percentage >= 40) return Colors.orange;
    return Colors.red;
  }

  // Get emoji based on score
  String get resultEmoji {
    final percentage = (score / total) * 100;
    
    if (percentage >= 90) return '🏆';
    if (percentage >= 75) return '🎉';
    if (percentage >= 60) return '👍';
    if (percentage >= 40) return '😊';
    return '🔄';
  }

  // Share result
  void _shareResult(BuildContext context) async {
    final String textToShare = 
        'I scored $score out of $total in my $subjectKey quiz! ${performanceMessage.split('!')[0]}!';
    
    await Clipboard.setData(ClipboardData(text: textToShare));
    
    // Show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Result copied to clipboard! You can share it now.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (score / total) * 100;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Result"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              
              // Emoji result
              Text(
                resultEmoji,
                style: const TextStyle(fontSize: 70),
              ),
              
              const SizedBox(height: 16),
              
              // Score display
              Text(
                '$score/$total',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                ),
              ),
              
              Text(
                '${percentage.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: scoreColor,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Performance message
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  performanceMessage,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Visual progress indicator
              Container(
                width: double.infinity,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: score / total,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: scoreColor,
                      boxShadow: [
                        BoxShadow(
                          color: scoreColor.withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.replay,
                    label: 'Retry Quiz',
                    color: Colors.orange,
                    onTap: () {
                      Get.off(() => QuizScreen(subjectKey: subjectKey));
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.share,
                    label: 'Share Result',
                    color: Colors.blue,
                    onTap: () => _shareResult(context),
                  ),
                  _buildActionButton(
                    icon: Icons.analytics,
                    label: 'Analyze',
                    color: Colors.purple,
                    onTap: () {
                      Get.to(() => AnalyticsPage(
                        subject: subjectKey, 
                        score: percentage.round(),
                      ));
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Subject badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16, 
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.school,
                      size: 18,
                      color: Colors.blue.shade700,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      subjectKey,
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Additional recommendations
              if (percentage < 70)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Study Recommendations',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Continue studying $subjectKey to improve your knowledge. Focus on core concepts and practice regularly.',
                        style: TextStyle(color: Colors.orange.shade800),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              
              if (percentage >= 70)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Next Steps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You\'re doing great with $subjectKey! Consider taking an advanced quiz or exploring related topics.',
                        style: TextStyle(color: Colors.green.shade800),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}