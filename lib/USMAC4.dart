import 'package:flutter/material.dart';
import 'dart:math';
class RandomNumberGame extends StatefulWidget {
  @override
  _RandomNumberGameState createState() => _RandomNumberGameState();
}

class _RandomNumberGameState extends State<RandomNumberGame> {
  Random random = Random();
  int randomNumber1 = Random().nextInt(100);
  int randomNumber2 = Random().nextInt(100);
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Number Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$randomNumber1 + $randomNumber2 = ?'),
            SizedBox(height: 16),
            TextField(
              controller: answerController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {

                });
                int userAnswer = int.parse(answerController.text);
                int correctAnswer = randomNumber1 + randomNumber2;
                if (userAnswer == correctAnswer) {
                  // Display a message indicating the user's answer is correct
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Correct!'),
                        content: Text('Your answer is correct.'),
                        actions: [
                          ElevatedButton(

                            onPressed: () {
                              setState(() {

                              });
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Display a message indicating the user's answer is incorrect
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Incorrect!'),
                        content: Text('Your answer is incorrect.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {

                              });
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Check Answer'),
            ),
          ],
        ),
      ),
    );
  }
}