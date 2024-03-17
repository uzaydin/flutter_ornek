import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_build.dart';

void main() {
  runApp(const Quiz());
}


class Quiz extends StatelessWidget {
  const Quiz({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Quiz Uygulaması',
      home: StartGame(),
    );
  }
}