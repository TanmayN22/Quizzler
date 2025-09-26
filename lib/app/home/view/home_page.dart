import 'package:flutter/material.dart';
import 'package:quizller/widgets/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Navbar(title: 'Quizzler')
    );
  }
}