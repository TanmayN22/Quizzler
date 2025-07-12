import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String subjectKey;
  const QuizScreen({super.key, required this.subjectKey});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedAnswerIndex;
  bool isAnswerChecked = false;
  int timeRemaining = 30; // 30 seconds per question
  late Map<String, List<Map<String, dynamic>>> allQuestions;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _startTimer();
  }

  void _loadQuestions() {
    allQuestions = {
      'OS': [
        {
          'question': 'What is the primary function of an Operating System?',
          'options': ['Manage hardware and software resources', 'Compile code', 'Run web servers', 'Design databases'],
          'answerIndex': 0,
          'explanation': 'The OS manages system resources and provides a user interface.'
        },
        {
          'question': 'Which of the following is NOT a type of Operating System?',
          'options': ['Batch', 'Time-sharing', 'Firewall', 'Real-time'],
          'answerIndex': 2,
          'explanation': 'Firewall is a security tool, not an OS.'
        },
        {
          'question': 'Which OS is used on Apple computers?',
          'options': ['Windows', 'Ubuntu', 'macOS', 'DOS'],
          'answerIndex': 2,
          'explanation': 'macOS is the official operating system for Apple Mac computers.'
        },
        {
          'question': 'Which component manages processes in OS?',
          'options': ['Scheduler', 'Compiler', 'Router', 'Decoder'],
          'answerIndex': 0,
          'explanation': 'The scheduler manages processes and allocates CPU time.'
        },
        {
          'question': 'Which OS is open-source?',
          'options': ['Windows', 'macOS', 'Linux', 'iOS'],
          'answerIndex': 2,
          'explanation': 'Linux is an open-source operating system.'
        },
      ],
      'DBMS': [
        {
          'question': 'Which of the following is a DBMS?',
          'options': ['Oracle', 'HTML', 'Linux', 'Photoshop'],
          'answerIndex': 0,
          'explanation': 'Oracle is a popular database management system.'
        },
        {
          'question': 'What is the purpose of SQL?',
          'options': ['Design web pages', 'Query databases', 'Write system software', 'Create animations'],
          'answerIndex': 1,
          'explanation': 'SQL is used to manage and query databases.'
        },
        {
          'question': 'What is a primary key?',
          'options': ['A unique identifier for a row', 'A field that stores passwords', 'A type of foreign key', 'A duplicate value in a table'],
          'answerIndex': 0,
          'explanation': 'Primary keys uniquely identify each record in a table.'
        },
        {
          'question': 'Which normal form eliminates transitive dependency?',
          'options': ['1NF', '2NF', '3NF', 'BCNF'],
          'answerIndex': 2,
          'explanation': '3NF removes transitive dependencies.'
        },
        {
          'question': 'Which command is used to remove a table?',
          'options': ['DROP', 'DELETE', 'REMOVE', 'CLEAR'],
          'answerIndex': 0,
          'explanation': '`DROP` removes the entire table structure and its data.'
        },
      ],
      'DSA': [
        {
          'question': 'Which data structure uses LIFO?',
          'options': ['Queue', 'Stack', 'Array', 'Linked List'],
          'answerIndex': 1,
          'explanation': 'Stack follows Last-In-First-Out (LIFO) principle.'
        },
        {
          'question': 'What is the time complexity of binary search?',
          'options': ['O(n)', 'O(log n)', 'O(n²)', 'O(1)'],
          'answerIndex': 1,
          'explanation': 'Binary search is O(log n) because it divides the array in half.'
        },
        {
          'question': 'Which data structure uses FIFO?',
          'options': ['Stack', 'Queue', 'Tree', 'Graph'],
          'answerIndex': 1,
          'explanation': 'Queue follows First-In-First-Out (FIFO) order.'
        },
        {
          'question': 'What is the best case time complexity for linear search?',
          'options': ['O(1)', 'O(log n)', 'O(n)', 'O(n²)'],
          'answerIndex': 0,
          'explanation': 'Best case is O(1) when the element is found at the start.'
        },
        {
          'question': 'Which data structure is used for implementing recursion?',
          'options': ['Queue', 'Array', 'Stack', 'Graph'],
          'answerIndex': 2,
          'explanation': 'Stacks are used internally in recursion to keep track of function calls.'
        },
      ],
    };
  }

  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          if (timeRemaining > 0) {
            timeRemaining--;
          } else {
            // Time's up, move to next question
            _moveToNextQuestion();
          }
        });
      }
      return false; // Stop the loop when we're unmounted
    });
  }

  List<Map<String, dynamic>> get currentSubjectQuestions {
    // Return questions for current subject or default to first subject if not found
    return allQuestions[widget.subjectKey] ?? allQuestions.values.first;
  }

  void checkAnswer(int index) {
    setState(() {
      selectedAnswerIndex = index;
      isAnswerChecked = true;
    });

    // Add a slight delay before moving to the next question
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _moveToNextQuestion();
      }
    });
  }

  void _moveToNextQuestion() {
    if (selectedAnswerIndex != null && selectedAnswerIndex == currentSubjectQuestions[currentQuestionIndex]['answerIndex']) {
      score++;
    }

    if (currentQuestionIndex < currentSubjectQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        isAnswerChecked = false;
        timeRemaining = 30; // Reset timer
      });
    } else {
      // Quiz is complete, navigate to results
      Get.off(() => ResultScreen(score: score, total: currentSubjectQuestions.length, subjectKey: widget.subjectKey));
    }
  }

  Color _getOptionColor(int optionIndex) {
    if (!isAnswerChecked) return Colors.white;

    final correctIndex = currentSubjectQuestions[currentQuestionIndex]['answerIndex'];

    if (optionIndex == correctIndex) {
      return Colors.green.shade100;
    } else if (optionIndex == selectedAnswerIndex) {
      return Colors.red.shade100;
    }

    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final question = currentSubjectQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectKey} Quiz'),
        elevation: 2,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Progress and timer
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: (currentQuestionIndex + 1) / currentSubjectQuestions.length,
                    backgroundColor: Colors.grey.shade200,
                    color: Colors.blue,
                    minHeight: 10,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: timeRemaining < 10 ? Colors.red : Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.timer, color: Colors.white, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '$timeRemaining s',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Question counter
            Text(
              'Question ${currentQuestionIndex + 1}/${currentSubjectQuestions.length}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 24),

            // Question text
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade100,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                question['question'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 24),

            // Answer options
            Expanded(
              child: ListView.builder(
                itemCount: question['options'].length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: isAnswerChecked ? null : () => checkAnswer(index),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: _getOptionColor(index),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedAnswerIndex == index ? Colors.blue : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        title: Text(
                          question['options'][index],
                          style: const TextStyle(fontSize: 16),
                        ),
                        leading: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedAnswerIndex == index ? Colors.blue : Colors.grey.shade200,
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(65 + index), // A, B, C, D
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selectedAnswerIndex == index ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Explanation (shown when answer is checked)
            if (isAnswerChecked)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explanation:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      question['explanation'] ?? 'No explanation available.',
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            // Skip button
            if (!isAnswerChecked)
              ElevatedButton(
                onPressed: _moveToNextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  minimumSize: const Size(120, 40),
                ),
                child: const Text('Skip Question'),
              ),
          ],
        ),
      ),
    );
  }
}
