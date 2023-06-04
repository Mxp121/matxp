import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('USMAC Number App')),
        body: NumberGame(),
      ),
    );
  }
}

class NumberGame extends StatefulWidget {
  @override
  _NumberGameState createState() => _NumberGameState();
}

class _NumberGameState extends State<NumberGame> {
  int firstNumber = 0;
  int secondNumber = 0;
  String userAnswer = '';
  String resultMessage = '';

  @override
  void initState() {
    super.initState();
    _generateRandomNumbers();
  }

  void _generateRandomNumbers() {
    setState(() {
      firstNumber = Random().nextInt(10);
      secondNumber = Random().nextInt(10);
    });
  }

  void _checkAnswer() {
    int correctAnswer = firstNumber + secondNumber;
    if (int.parse(userAnswer) == correctAnswer) {
      setState(() {
        resultMessage = 'Correct!';
      });
    } else {
      setState(() {
        resultMessage = 'Incorrect. The correct answer is $correctAnswer.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/numbers/$firstNumber.png'),
            Text('+'),
            Image.asset('assets/numbers/$secondNumber.png'),
          ],
        ),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            userAnswer = value;
          },
        ),
        ElevatedButton(
          onPressed: _checkAnswer,
          child: Text('Submit'),
        ),
        Text(resultMessage),
      ],
    );
  }
}
