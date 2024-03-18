import 'package:flutter/material.dart';
import 'dart:math';
import 'package:quiz_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/models/questions_model.dart';
import 'package:quiz_app/config/appColor.dart';
import 'package:quiz_app/route/result_page.dart';


class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _correctAnswer = 0;
  int _wrongAnswer = 0;
  int _currentIndex = 0;
  bool _isEnabled = false;

  // immutable oldugu icin List.from kullanıp listenin kopyasını olusturarak onun uzerinde işlem yapıyoruz.
  final List<Question> _questions = List<Question>.from(questions);

  @override
  void initState() {
    super.initState();
    _questions.shuffle(); // Soruları karıştır
  }

  void _checkAnswer(String userAnswer) {
    setState(() {
      if (!_isEnabled) {
        String correctAnswer = _questions[_currentIndex].correctAnswer;
        // Sadece tek cevap verilmesini sağlıyoruz.
        if (userAnswer == correctAnswer) {
          _correctAnswer++;
        } else {
          _wrongAnswer++;
        }
        _isEnabled = true; // Cevap verildiğinde butonu etkinleştir

        //Son soruya gelindiğinde sonucu göster
        if (_currentIndex == _questions.length - 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => QuizResult(
                  correctAnswer: _correctAnswer, wrongAnswer: _wrongAnswer),
            ),
          );
        }
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
        _isEnabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor(Color.fromRGBO(76, 125, 123, 1)),
      appBar: AppBar(
        title: Text("Quiz", style: GoogleFonts.signika(fontSize: 30)),
        shape: const Border(
          bottom: BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(85, 0, 0, 0),
          ),
        ),
        backgroundColor: AppColor.backgroundColor(const Color.fromRGBO(76, 125, 123, 1)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: const Offset(0, -40),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                width: 600,
                height: 200,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(30),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    "${_currentIndex + 1}.${_questions[_currentIndex].question}",
                    style: GoogleFonts.signika(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Column(
              children: _questions[_currentIndex].answers.map((answer) {
                return Container(
                  padding: const EdgeInsets.all(2),
                  width: 350,
                  child: ElevatedButton(
                      onPressed: () => _checkAnswer(answer),
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppColor.buttonBackgroundColor(const Color.fromRGBO(248, 198, 96, 1))),
                      child: Text(answer)),
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: _isEnabled
                        ? _nextQuestion
                        : null, // Buton etkinse _nextQuestion fonksiyonunu çağır
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.buttonBackgroundColor(Color.fromARGB(234, 173, 117, 5)),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Sonraki Soru'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}