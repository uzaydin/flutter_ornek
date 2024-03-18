import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/config/appColor.dart';
import 'package:quiz_app/route/quiz_page.dart';


class StartGame extends StatelessWidget {
  const StartGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor(const Color.fromRGBO(76, 125, 123, 1)),
      appBar: AppBar(
        title:
            Text("Quiz App", style: GoogleFonts.signika(fontSize: 30)),
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(85, 0, 0, 0),
          ),
        ),
        backgroundColor: AppColor.backgroundColor(const Color.fromRGBO(76, 125, 123, 1)),
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
                  backgroundColor: AppColor.buttonBackgroundColor(const Color.fromRGBO(248, 198, 96, 1)),
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