import 'package:flutter/material.dart';
import 'package:quiz_app/route/start_page.dart';

void main() {
  runApp(const Quiz());
}


class Quiz extends StatelessWidget {
  const Quiz({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Uygulaması',
      home: StartGame(),
    );
  }
}