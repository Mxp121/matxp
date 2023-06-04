import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'USMAC Number Quiz',
      home: NumberQuiz(),
    );
  }
}

class NumberQuiz extends StatefulWidget {
  @override
  _NumberQuizState createState() => _NumberQuizState();
}

class _NumberQuizState extends State<NumberQuiz> {
  int num1 = Random().nextInt(10);
  int num2 = Random().nextInt(10);
  int correctAnswer = 0;
  TextEditingController answerController = TextEditingController();

  void checkAnswer() {
    int userAnswer = int.parse(answerController.text);
    int sum = num1 + num2;
    setState(() {
      correctAnswer = sum;
    });
    if (userAnswer == sum) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Correct!'),
            content: Text('$num1 + $num2 = $sum'),
            actions: <Widget>[
             ElevatedButton(
                onPressed: () {
                  setState(() {

                  });
                  Navigator.of(context).pop();
                  setState(() {
                    num1 = Random().nextInt(10);
                    num2 = Random().nextInt(10);
                    correctAnswer = 0;
                    answerController.clear();
                  });
                },
                child: Text('Next Question'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Incorrect!'),
            content: Text('$num1 + $num2 = $sum'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {

                  });
                  Navigator.of(context).pop();
                },
                child: Text('Try Again'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USMAC Number Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset('images/$num1.png', width: 100.0, height: 100.0),
                Image.asset('images/$num2.png', width: 100.0, height: 100.0),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'What is $num1 + $num2?',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Container(
              width: 100.0,
              child: TextField(
                controller: answerController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {

                });
                checkAnswer();
              },
              child: Text('Check Answer'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Correct Answer: $correctAnswer',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}