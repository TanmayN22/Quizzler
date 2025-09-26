import 'package:flutter/material.dart';
import 'package:quizller/widgets/navbar.dart';

class AnalyticsPage extends StatefulWidget {
  final String subject;
  final int score;

  const AnalyticsPage({super.key, required this.subject, required this.score});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'Analytics'),
      body: TabBarView(
        controller: _tabController,
        children: [],
      ),
    );
  }
}
