import 'package:flutter/material.dart';
import 'dart:math';
import 'About-1.dart';
import 'Setting-1.dart';

void main() => runApp(MyApp());
 var sped1;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'USMAC Number Quiz',
      home: NumberQuiz(),
    );
  }
}

class NumberQuiz extends StatefulWidget {
  @override
  _NumberQuizState createState() => _NumberQuizState();
}

class _NumberQuizState extends State<NumberQuiz>
    with SingleTickerProviderStateMixin {
  int num1 = Random().nextInt(10);
  int num2 = Random().nextInt(10);
  int correctAnswer = 0;
  TextEditingController answerController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _animation;
  int sped1 = 5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: sped1),
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
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text('Settings'),
                value: 'settings',
              ),
              PopupMenuItem(
                child: Text('Speed+'),
                value: 'Speed+',
              ),
              PopupMenuItem(
                child: Text('About'),
                value: 'about',
              ),
            ],
            onSelected: (value) {
              // Handle menu item selection
              if (value == 'settings') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingAPP()));
              } else if (value == 'about') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutAPP()));
              }
              if (value == 'Speed+') {
                setState(() {
                  sped1 = sped1 + 5;
                  _controller.duration = Duration(seconds: sped1);
                });
              }
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.red,Colors.black12],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeTransition(
                opacity: _animation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/$num1.jpg',
                        width: 200.0, height: 200.0),
                    Text(
                      "+",
                      style: TextStyle(fontSize: 50),
                    ),
                    Image.asset('assets/$num2.jpg',
                        width: 200.0, height: 200.0),
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
      ),
    );
  }
}
