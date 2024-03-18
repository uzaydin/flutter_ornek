import 'package:flutter/material.dart';
import 'dart:math';
import 'package:quiz_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/models/questions_model.dart';

// app color changes except result page!

Color _appBackgroundColor = const Color.fromRGBO(76, 125, 123, 1);
Color _appButtonBackgroundColor = const Color.fromRGBO(248, 198, 96, 1);

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _correctAnswer = 0;
  int _wrongAnswer = 0;
  int _currentIndex = 0;

  // immutable oldugu icin List.from kullanıp listenin kopyasını olusturarak onun uzerinde işlem yapıyoruz.
  final List<Question> _questions = List<Question>.from(questions);

  @override
  void initState() {
    super.initState();
    _questions.shuffle(); // Soruları karıştır
  }

  void _checkAnswer(dynamic userAnswer) {
    setState(() {
      String correctAnswer = _questions[_currentIndex].correctAnswer;

      if (userAnswer == correctAnswer) {
        _correctAnswer++;
      } else {
        _wrongAnswer++;
      }
      _nextQuestion();
    });
  }

  

  void _nextQuestion() {
    if (_currentIndex == _questions.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResult(
              correctAnswer: _correctAnswer, wrongAnswer: _wrongAnswer),
        ),
      );
    } else {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void updateAnswer(String newAnswer) {
  String correctAnswer = _questions[_currentIndex].correctAnswer;
  String userAnswer = _questions[_currentIndex].answers[0]; // Doğru cevabı kontrol etmek için indeks 0 kullanıyoruz

  if (userAnswer == correctAnswer) {
    if (newAnswer != correctAnswer) {
      _correctAnswer--;
      _wrongAnswer++;
    }
  } else {
    if (newAnswer == correctAnswer) {
      _correctAnswer++;
      _wrongAnswer--;
    }
  }
  _nextQuestion();
}

  void _previousQuestion() {
    if (_currentIndex > 0) {
      
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _appBackgroundColor,
      appBar: AppBar(
        title: Text("Quiz", style: GoogleFonts.signika(fontSize: 30)),
        shape: const Border(
          bottom: BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(85, 0, 0, 0),
          ),
        ),
        backgroundColor: _appBackgroundColor,
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
                      onPressed: () => updateAnswer(answer),
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: _appButtonBackgroundColor),
                      child: Text(answer)),
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (_currentIndex > 0)
                  ElevatedButton(
                    onPressed: _previousQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _appButtonBackgroundColor,
                    ),
                    child: const Text('Önceki Soru'),
                  ),
                if (_currentIndex < questions.length - 1)
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _appButtonBackgroundColor,
                    ),
                    child: const Text('Sonraki Soru'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class _QuizAppState extends State<QuizApp> {
//   int _correctAnswer = 0;
//   int _wrongAnswer = 0;
//   int _currentIndex = 0;

//   // immutable oldugu icin List.from kullanıp listenin kopyasını olusturarak onun uzerinde işlem yapıyoruz.
//   final List<Question> _questions = List<Question>.from(questions);

//   @override
//   void initState() {
//     super.initState();
//     _questions.shuffle(); // Soruları karıştır
//   }

//   void _checkAnswer(String userAnswer) {
//     setState(() {
//       String correctAnswer = _questions[_currentIndex].correctAnswer;

//       if (userAnswer == correctAnswer) {
//         _correctAnswer++;
//       } else {
//         _wrongAnswer++;
//       }
//       _nextQuestion();
//     });
//   }

//   void _nextQuestion() {
//     if (_currentIndex == _questions.length - 1) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => QuizResult(
//               correctAnswer: _correctAnswer, wrongAnswer: _wrongAnswer),
//         ),
//       );
//     } else {
//       setState(() {
//         _currentIndex++;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _appBackgroundColor,
//       appBar: AppBar(
//         title: Text("Quiz", style: GoogleFonts.signika(fontSize: 30)),
//         shape: const Border(
//           bottom: BorderSide(
//             style: BorderStyle.solid,
//             color: Color.fromARGB(85, 0, 0, 0),
//           ),
//         ),
//         backgroundColor: _appBackgroundColor,
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Transform.translate(
//               offset: const Offset(0, -40),
//               child: Container(
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(15))),
//                 width: 600,
//                 height: 200,
//                 padding: const EdgeInsets.all(20),
//                 margin: const EdgeInsets.all(30),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 40),
//                   child: Text(
//                     "${_currentIndex + 1}.${_questions[_currentIndex].question}",
//                     style: GoogleFonts.signika(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                         color: const Color.fromARGB(255, 0, 0, 0)),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//             Column(
//               children: _questions[_currentIndex].answers.map((answer) {
//                 return Container(
//                   padding: const EdgeInsets.all(2),
//                   width: 350,
//                   child: ElevatedButton(
//                       onPressed: () => _checkAnswer(answer),
//                       style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: _appButtonBackgroundColor),
//                       child: Text(answer)),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
        backgroundColor: _appBackgroundColor,
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

class StartGame extends StatelessWidget {
  const StartGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _appBackgroundColor,
      appBar: AppBar(
        title:
            Text("Quiz Uygulaması", style: GoogleFonts.signika(fontSize: 30)),
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(85, 0, 0, 0),
          ),
        ),
        backgroundColor: _appBackgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200, // Box genişliğini sabit tut
              height: 200, // Box yüksekliğini sabit tut
              margin: const EdgeInsets.only(top: 250),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(300)),
              child: Center(
                child: Text(
                  'Hoşgeldiniz!',
                  style: GoogleFonts.redressed(fontSize: 40),
                ),
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsetsDirectional.only(bottom: 40),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizApp(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: _appButtonBackgroundColor,
                ),
                child: const Text('Başla'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
