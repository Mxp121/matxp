import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      title: 'USMAC Number Quiz',
      home: NumberQuiz(),
    );
  }
}

class NumberQuiz extends StatefulWidget {
  @override
  _NumberQuizState createState() => _NumberQuizState();
}

class _NumberQuizState extends State<NumberQuiz> with SingleTickerProviderStateMixin {
  int num1 = Random().nextInt(10);
  int num2 = Random().nextInt(10);
  int correctAnswer = 0;
  TextEditingController answerController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

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
                  _controller.reset();
                  _controller.forward();
                  setState(() {
                    num1 = Random().nextInt(10);
                    num2 = Random().nextInt(10);
                    correctAnswer = 0;
                    answerController.clear();
                  });
                  Navigator.of(context).pop();
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
                  _controller.reset();
                  _controller.forward();
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
            FadeTransition(
              opacity: _animation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/$num1.jpg', width: 200.0, height: 200.0),
                  Text("+",style: TextStyle(
                      fontSize: 50
                  ),),
                  Image.asset('assets/$num2.jpg', width: 200.0, height: 200.0),
                ],
              ),
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
                _controller.reset();
                _controller.forward();
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
