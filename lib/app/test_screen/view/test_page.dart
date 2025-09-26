import 'package:flutter/material.dart';
import 'package:quizller/widgets/navbar.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: Navbar(title: 'Tests'));
  }
}
