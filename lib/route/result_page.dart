import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/config/appColor.dart';
import 'package:quiz_app/route/start_page.dart';



class QuizResult extends StatelessWidget {
  final int correctAnswer;
  final int wrongAnswer;

  const QuizResult(
      {super.key, required this.correctAnswer, required this.wrongAnswer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'Quiz Sonuçları',
          style: GoogleFonts.signika(fontSize: 30),
        ),
        shape: const Border(
            bottom: BorderSide(
                style: BorderStyle.solid,
                color: Color.fromRGBO(0, 0, 0, 1),
                width: 1.2)),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor(const Color.fromRGBO(76, 125, 123, 1)),
      ),
      body: Center(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Doğru Cevaplar: $correctAnswer',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                'Yanlış Cevaplar: $wrongAnswer',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StartGame(),
                      ));
                },
                style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
                child: const Text('Tekrar Başla'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}