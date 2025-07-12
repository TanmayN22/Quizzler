import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {
  final String subject;
  final int score;

  const AnalyticsPage({super.key, required this.subject, required this.score});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Mock data for performance history
  final List<Map<String, dynamic>> _performanceHistory = [
    {'date': 'Apr 5', 'score': 65},
    {'date': 'Apr 7', 'score': 72},
    {'date': 'Apr 9', 'score': 68},
    {'date': 'Apr 10', 'score': 75},
  ];
  
  // Mock data for subject strengths
  final Map<String, double> _topicStrengths = {
    'Fundamentals': 0.85,
    'Advanced Concepts': 0.65,
    'Problem Solving': 0.75,
    'Theoretical Knowledge': 0.60,
    'Practical Application': 0.70,
  };
  
  // Mock data for recommendation categories
  final List<Map<String, dynamic>> _recommendationCategories = [
    {
      'title': 'Study Resources',
      'icon': Icons.book,
      'color': Colors.blue,
    },
    {
      'title': 'Practice Exercises',
      'icon': Icons.edit,
      'color': Colors.green,
    },
    {
      'title': 'Video Tutorials',
      'icon': Icons.play_circle_fill,
      'color': Colors.red,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Add current score to history
    _performanceHistory.add({
      'date': 'Apr 11', 
      'score': widget.score,
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis: ${widget.subject}'),
        backgroundColor: Colors.purple.shade700,
        foregroundColor: Colors.white,
        elevation: 2,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Strengths'),
            Tab(text: 'Recommendations'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildStrengthsTab(),
          _buildRecommendationsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    // Calculate color based on score
    Color scoreColor;
    if (widget.score >= 80) {
      scoreColor = Colors.green;
    } else if (widget.score >= 65) {
      scoreColor = Colors.orange;
    } else {
      scoreColor = Colors.red;
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Score card
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current Score',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12, 
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.subject,
                          style: TextStyle(
                            color: Colors.purple.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${widget.score}%',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                  Text(
                    _getPerformanceText(widget.score),
                    style: TextStyle(color: scoreColor),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: widget.score / 100,
                    backgroundColor: Colors.grey.shade200,
                    color: scoreColor,
                    minHeight: 8,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Performance history
          const Text(
            'Performance Trend',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: _buildPerformanceChart(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _getTrendAnalysis(),
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Progress comparison
          const Text(
            'Comparison with Others',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildComparisonItem(
                          title: 'Your Score',
                          value: '${widget.score}%',
                          color: scoreColor,
                        ),
                      ),
                      Expanded(
                        child: _buildComparisonItem(
                          title: 'Average',
                          value: '70%',
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: _buildComparisonItem(
                          title: 'Top Score',
                          value: '95%',
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _getComparisonAnalysis(),
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Quick actions
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickActionButton(
                    icon: Icons.replay,
                    label: 'Retry Quiz',
                    color: Colors.orange,
                  ),
                  _buildQuickActionButton(
                    icon: Icons.list_alt,
                    label: 'Practice Set',
                    color: Colors.green,
                  ),
                  _buildQuickActionButton(
                    icon: Icons.share,
                    label: 'Share',
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStrengthsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Subject Knowledge Breakdown',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: _topicStrengths.entries.map((entry) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              entry.key,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                LinearProgressIndicator(
                                  value: entry.value,
                                  backgroundColor: Colors.grey.shade200,
                                  color: _getStrengthColor(entry.value),
                                  minHeight: 10,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${(entry.value * 100).round()}%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          const Text(
            'Strengths & Weaknesses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          // Strengths card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Your Strengths',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildStrengthsWeaknessesList(_getStrengths()),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Weaknesses card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_down,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Areas to Improve',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildStrengthsWeaknessesList(_getWeaknesses()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Study plan
          const Text(
            'Recommended Study Plan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.purple,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Weekly Plan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildStudyPlanItem(
                    dayOfWeek: 'Monday',
                    topic: 'Review Basic Concepts',
                    duration: '30 minutes',
                  ),
                  _buildStudyPlanItem(
                    dayOfWeek: 'Wednesday',
                    topic: 'Practice Problems',
                    duration: '45 minutes',
                  ),
                  _buildStudyPlanItem(
                    dayOfWeek: 'Friday',
                    topic: 'Take Practice Quiz',
                    duration: '20 minutes',
                  ),
                  _buildStudyPlanItem(
                    dayOfWeek: 'Weekend',
                    topic: 'Advanced Topics',
                    duration: '1 hour',
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Resources
          const Text(
            'Learning Resources',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          // Resources cards
          ..._recommendationCategories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            category['icon'],
                            color: category['color'],
                          ),
                          const SizedBox(width: 8),
                          Text(
                            category['title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: category['color'],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildResourcesList(category['title']),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          
          const SizedBox(height: 24),
          
          // Progress targets
          const Text(
            'Target Goals',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: Icon(
                        Icons.speed,
                        color: Colors.green,
                      ),
                    ),
                    title: const Text('Short-term Goal'),
                    subtitle: Text(
                      'Improve score to ${widget.score + 10}% in 2 weeks',
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange.shade100,
                      child: Icon(
                        Icons.trending_up,
                        color: Colors.orange,
                      ),
                    ),
                    title: const Text('Mid-term Goal'),
                    subtitle: Text(
                      'Achieve mastery (85%+) in ${widget.subject} within 1 month',
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        Icons.emoji_events,
                        color: Colors.blue,
                      ),
                    ),
                    title: const Text('Long-term Goal'),
                    subtitle: const Text(
                      'Apply concepts to real-world projects',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widgets
  Widget _buildPerformanceChart() {
    double maxScore = 0;
    for (var entry in _performanceHistory) {
      if (entry['score'] > maxScore) {
        maxScore = entry['score'].toDouble();
      }
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          final chartHeight = height - 40; // space for labels
          final barWidth = width / (_performanceHistory.length * 2);
          final spacing = width / _performanceHistory.length;
          
          return Column(
            children: [
              SizedBox(
                height: chartHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _performanceHistory.map((entry) {
                    final normalizedHeight = (entry['score'] / 100) * chartHeight;
                    
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: barWidth,
                          height: normalizedHeight,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                _getScoreColor(entry['score']),
                                _getScoreColor(entry['score']).withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _performanceHistory.map((entry) {
                    return Column(
                      children: [
                        Text(
                          '${entry['score']}%',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          entry['date'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildComparisonItem({
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.1),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.1),
          ),
          child: Center(
            child: Icon(icon, color: color),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildStrengthsWeaknessesList(List<String> items) {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.circle,
                size: 10,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(item),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStudyPlanItem({
    required String dayOfWeek, 
    required String topic, 
    required String duration,
    bool isLast = false,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              child: Text(
                dayOfWeek,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Text(topic),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8, 
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                duration,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        ),
        if (!isLast)
          Divider(height: 24),
      ],
    );
  }

  Widget _buildResourcesList(String category) {
    List<Map<String, String>> resources = [];
    
    // Generate mock resources based on category
    if (category == 'Study Resources') {
      resources = [
        {'title': 'Core Concepts Handbook', 'type': 'E-Book'},
        {'title': 'Professional Guide to ${widget.subject}', 'type': 'PDF'},
        {'title': 'Interactive Learning Module', 'type': 'Online'},
      ];
    } else if (category == 'Practice Exercises') {
      resources = [
        {'title': 'Problem Set: Fundamentals', 'type': 'Exercises'},
        {'title': 'Advanced Challenge Problems', 'type': 'Quiz'},
        {'title': 'Timed Practice Tests', 'type': 'Assessment'},
      ];
    } else {
      resources = [
        {'title': 'Video Series: ${widget.subject} Basics', 'type': 'Video'},
        {'title': 'Expert Lectures on Advanced Topics', 'type': 'Course'},
        {'title': 'Animated Concept Explanations', 'type': 'Tutorial'},
      ];
    }
    
    return Column(
      children: resources.map((resource) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(resource['title']!),
          subtitle: Text(resource['type']!),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        );
      }).toList(),
    );
  }

  // Helper methods
  String _getPerformanceText(int score) {
    if (score >= 90) return 'Excellent';
    if (score >= 80) return 'Very Good';
    if (score >= 70) return 'Good';
    if (score >= 60) return 'Satisfactory';
    if (score >= 50) return 'Needs Improvement';
    return 'Requires Attention';
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 70) return Colors.lightGreen;
    if (score >= 60) return Colors.amber;
    if (score >= 50) return Colors.orange;
    return Colors.red;
  }

  Color _getStrengthColor(double value) {
    if (value >= 0.8) return Colors.green;
    if (value >= 0.6) return Colors.amber;
    return Colors.red;
  }

  String _getTrendAnalysis() {
    // Calculate if trend is improving
    final latestScores = _performanceHistory.length >= 3
        ? _performanceHistory.sublist(_performanceHistory.length - 3)
        : _performanceHistory;
    
    if (latestScores.length < 2) return 'Not enough data to determine trend.';
    
    bool isImproving = true;
    for (int i = 1; i < latestScores.length; i++) {
      if (latestScores[i]['score'] < latestScores[i-1]['score']) {
        isImproving = false;
        break;
      }
    }
    
    if (isImproving) {
      return 'Your performance shows a positive trend. Keep up the good work!';
    } else {
      return 'Your performance has some fluctuations. Consistent practice will help stabilize results.';
    }
  }

  String _getComparisonAnalysis() {
    if (widget.score > 70) {
      return 'You\'re performing above average! Keep practicing to reach the top scores.';
    } else if (widget.score >= 60) {
      return 'You\'re close to the average score. A little more practice will help you exceed it.';
    } else {
      return 'You\'re currently below the average. Focus on the recommendations to improve.';
    }
  }

  List<String> _getStrengths() {
    // Get top 3 strengths based on mock data
    final strengths = _topicStrengths.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    final topStrengths = strengths.take(2).toList();
    
    return topStrengths.map((entry) {
      final area = entry.key;
      
      if (area == 'Fundamentals') {
        return 'Strong grasp of core concepts in ${widget.subject}';
      } else if (area == 'Problem Solving') {
        return 'Good at applying knowledge to solve problems';
      } else if (area == 'Practical Application') {
        return 'Effective at practical implementation of concepts';
      } else {
        return 'Strong understanding of $area';
      }
    }).toList();
  }

  List<String> _getWeaknesses() {
    // Get bottom 2 weaknesses based on mock data
    final weaknesses = _topicStrengths.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    
    final topWeaknesses = weaknesses.take(2).toList();
    
    return topWeaknesses.map((entry) {
      final area = entry.key;
      
      if (area == 'Theoretical Knowledge') {
        return 'Need to strengthen understanding of theoretical concepts';
      } else if (area == 'Advanced Concepts') {
        return 'Can improve on advanced topics in ${widget.subject}';
      } else {
        return 'Room for improvement in $area area';
      }
    }).toList();
  }
}